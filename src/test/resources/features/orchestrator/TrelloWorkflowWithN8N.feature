@n8n
Feature: Test Trello Workflow with n8n Integration

  Scenario: Successfull Create New Trello List with n8n Integration
    #precondition: we have an existing organization, board.
    # List will create in n8n workflow and then we will update list name in Karate and verify the update with n8n workflow.
    * def n8nUrl = 'http://n8n:5678/webhook/create-trello-list'
    Given url n8nUrl
    And request {}
    When method post
    Then status 200

    * print response
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
    * print 'List Name Updated Successfully. New Lard Name is: >> ', list.result.name






 
  


                
                
              
    
    







