
Feature: Test Trello Workflow with n8n Integration

  Background: cleanup
    * def cleanup = read('classpath:helpers/cleanup-helper.js')
    * def naming = call read('classpath:helpers/naming-helper.js')
  @n8n
  Scenario: Successfull Create New Trello List with n8n Integration
    #precondition: we have an existing organization, board.
    # List will create in n8n workflow and then we will update list name in Karate and verify the update with n8n workflow.
    * def n8n  = n8nUrl + '/webhook/create-trello-list'
    Given url n8n
    And request {}
    And method post
    * status 200
    * eval cleanup.add('list', response.listId)
    * match response ==
    """
    {
      listId: '#string',
      listName: '#string',
      boardId: '#string'
    }
    """
    * print '\033[1;36m=== List Created with n8n Integration  ===\033[0m'
    # set list id  to clean up

     # Step : update list name
    * def list = call read('classpath:features/feeders/List.feature@updateList') { id: '#(response.listId)', queryParams: {name: 'To Do' }}
    * match list.result.id == response.listId
    * match list.result.name == 'To Do'
    * print 'List Name Updated Successfully. New List Name is: >> ', list.result.name



  Scenario: Complete E2E Test - Create Organization, Board, List, Cards, Update and Cleanup with n8n workflow

    # Step 1: Create Organization
    * print '\033[1;36m=== Step 1: Create An Organization ===\033[0m'
    * def organization = call read('classpath:features/feeders/Organization.feature@createOrganization') { name: #(naming.getStandartNaming('Organization')) }
    * print "A new organization created with id:  >>>", organization.result.id

    # Step 2: Create Board
    * print '\033[1;36m=== Step 2: Creating Board ===\033[0m'
    * def board = call read('classpath:features/feeders/Board.feature@createBoard') { idOrganization: '#(organization.result.id)', boardName: #(naming.getStandartNaming('Board')) }
    * print "A new board created with id:  >>>", board.result.id

    # Step 3: Create List
    * print '\033[1;36m=== Step 3: Create List ===\033[0m'
    * def list = call read('classpath:features/feeders/List.feature@createList') { boardId: '#(board.result.id)', listName: #(naming.getStandartNaming('List'))  }
    * print "A new list created with id:  >>>", list.result.id

    # Step 4: Create  Card
    * print '\033[1;36m=== Step 4: Create First Card ===\033[0m'
    * def card = call read('classpath:features/feeders/Card.feature@createCard') { idList: '#(list.result.id)', name: #(naming.getStandartNaming('Card')) }
    * print "A new card created with id:  >>>", card.result.id
    * def cardNameBefore = card.result.name

    # Step 5: Get Card Details Before Update
    * def updatedCard = call read('classpath:features/feeders/Card.feature@updateCardName') { id: '#(card.result.id)', name: #(naming.getStandartNaming('Card')) }
    * match updatedCard.result.id == card.result.id
    * match updatedCard.result.name != cardNameBefore
    * print 'Card Name Updated Successfully. New Card Name is: >> ', updatedCard.result.name
















 
  


                
                
              
    
    







