function fn() {
  
    var getThreadId = function() {
      var thread = java.lang.Thread.currentThread();
      return thread.getName() + "-" + thread.getId();
    };

    // Registry key for each thread for parallel execution safety
    var getRegistryKey = function() {
      return 'cleanupRegistry_' + getThreadId();
    };

    // Thread-specific registry initialization
    var registryKey = getRegistryKey();

    var existingRegistry = karate.get(registryKey);
    if (!existingRegistry) {
      karate.set(registryKey, {
        cards: [],
        lists: [],
        boards: [],
        organizations: [],
        threadId: getThreadId()
      });
      karate.log('Cleanup registry initialized for thread: ' + getThreadId());
    }

    return {

      // Get current thread's registry if exists, otherwise create a new one
      getRegistry: function() {
        var registry = karate.get(getRegistryKey());
        if (!registry) {
          registry = {
            cards: [],
            lists: [],
            boards: [],
            organizations: [],
            threadId: getThreadId(),
            createdAt: new Date().toISOString()
          };
          karate.set(getRegistryKey(), registry);
        }
        return registry;
      },

      // Register resources for cleanup (thread-safe)
      registerCard: function(cardId) {
        if (cardId) {
          var registry = this.getRegistry();
          if (registry.cards.indexOf(cardId) === -1) {
            registry.cards.push(cardId);
            karate.set(getRegistryKey(), registry);
            karate.log('[' + getThreadId() + '] Card registered:', cardId);
          }
        }
      },

      registerList: function(listId) {
        if (listId) {
          var registry = this.getRegistry();
          if (registry.lists.indexOf(listId) === -1) {
            registry.lists.push(listId);
            karate.set(getRegistryKey(), registry);
            karate.log('[' + getThreadId() + '] List registered:', listId);
          }
        }
      },

      registerBoard: function(boardId) {
        if (boardId) {
          var registry = this.getRegistry();
          if (registry.boards.indexOf(boardId) === -1) {
            registry.boards.push(boardId);
            karate.set(getRegistryKey(), registry);
            karate.log('[' + getThreadId() + '] Board registered:', boardId);
          }
        }
      },

      registerOrganization: function(organizationId) {
        if (organizationId) {
          var registry = this.getRegistry();
          if (registry.organizations.indexOf(organizationId) === -1) {
            registry.organizations.push(organizationId);
            karate.set(getRegistryKey(), registry);
            karate.log('[' + getThreadId() + '] Organization registered:', organizationId);
          }
        }
      },

      // Unregister methods (thread-safe)
      unregisterCard: function(cardId) {
        var registry = this.getRegistry();
        var index = registry.cards.indexOf(cardId);
        if (index > -1) {
          registry.cards.splice(index, 1);
          karate.set(getRegistryKey(), registry);
          karate.log('[' + getThreadId() + '] Card unregistered:', cardId);
        }
      },

      unregisterList: function(listId) {
        var registry = this.getRegistry();
        var index = registry.lists.indexOf(listId);
        if (index > -1) {
          registry.lists.splice(index, 1);
          karate.set(getRegistryKey(), registry);
          karate.log('[' + getThreadId() + '] List unregistered:', listId);
        }
      },

      unregisterBoard: function(boardId) {
        var registry = this.getRegistry();
        var index = registry.boards.indexOf(boardId);
        if (index > -1) {
          registry.boards.splice(index, 1);
          karate.set(getRegistryKey(), registry);
          karate.log('[' + getThreadId() + '] Board unregistered:', boardId);
        }
      },

      unregisterOrganization: function(organizationId) {
        var registry = this.getRegistry();
        var index = registry.organizations.indexOf(organizationId);
        if (index > -1) {
          registry.organizations.splice(index, 1);
          karate.set(getRegistryKey(), registry);
          karate.log('[' + getThreadId() + '] Organization unregistered:', organizationId);
        }
      },

      // Thread-safe hierarchical cleanup
      performHierarchicalCleanup: function() {
        //Card> List> Board >Organization
        var registry = this.getRegistry();
        karate.log('🧹 [' + getThreadId() + '] Starting hierarchical cleanup...');

        // 1. Cards cleanup
        while (registry.cards.length > 0) {
          var cardId = registry.cards[0];
          try {
            karate.call('classpath:features/feeders/Card.feature@deleteCard', { id: cardId });
            this.unregisterCard(cardId);
            karate.log('[' + getThreadId() + '] Card deleted:', cardId);
          } catch (e) {
            karate.log('[' + getThreadId() + '] Failed to delete card:', cardId, e.message);
            this.unregisterCard(cardId);
          }
          registry = this.getRegistry();
        }

        // 2. Lists cleanup
        while (registry.lists.length > 0) {
          var listId = registry.lists[0];
          try {
            // List delete implementation (if available)
            karate.call('classpath:features/feeders/List.feature@deleteList', { id: listId });
            this.unregisterList(listId);
          } catch (e) {
            karate.log('[' + getThreadId() + '] Failed to delete list:', listId, e.message);
            this.unregisterList(listId);
          }
          registry = this.getRegistry();
        }

        // 3. Boards cleanup
        while (registry.boards.length > 0) {
          var boardId = registry.boards[0];
          try {
            karate.call('classpath:features/feeders/Board.feature@deleteBoard', { id: boardId });
            this.unregisterBoard(boardId);
            karate.log('[' + getThreadId() + '] Board deleted:', boardId);
          } catch (e) {
            karate.log('[' + getThreadId() + '] Failed to delete board:', boardId, e.message);
            this.unregisterBoard(boardId);
          }
          registry = this.getRegistry();
        }

        // 4. Organizations cleanup
        while (registry.organizations.length > 0) {
          var orgId = registry.organizations[0];
          try {
            karate.call('classpath:features/feeders/Organization.feature@deleteOrganization', { id: orgId });
            this.unregisterOrganization(orgId);
            karate.log('[' + getThreadId() + '] Organization deleted:', orgId);
          } catch (e) {
            karate.log('[' + getThreadId() + '] Failed to delete organization:', orgId, e.message);
            this.unregisterOrganization(orgId);
          }
          registry = this.getRegistry();
        }

        karate.log('🎉 [' + getThreadId() + '] Hierarchical cleanup completed!');
      },

      // Thread-safe registry status
      showRegistryStatus: function() {
        var registry = this.getRegistry();
        var total = registry.cards.length + registry.lists.length + registry.boards.length + registry.organizations.length;

        if (total > 0) {
          karate.log('[' + getThreadId() + '] Cleanup Registry Status:');
          karate.log('* Cards:', registry.cards.length);
          karate.log('* Lists:', registry.lists.length);
          karate.log('* Boards:', registry.boards.length);
          karate.log('* Organizations:', registry.organizations.length);
          karate.log('* Total:', total);
          karate.log('* Created:', registry.createdAt);
        } else {
          karate.log('✨ [' + getThreadId() + '] Cleanup registry is empty');
        }
      },

      // Clear current thread's registry
      clearRegistry: function() {
        karate.remove(getRegistryKey());
        karate.log('🧹 [' + getThreadId() + '] Cleanup registry cleared');
      },


      // Get current thread id
      getThreadId: function() {
        return getThreadId();
      }
    }
  }