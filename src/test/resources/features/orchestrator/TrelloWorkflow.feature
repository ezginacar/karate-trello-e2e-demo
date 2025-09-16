@e2e
Feature: E2E Case Study - Complete Trello Workflow

  Background: Setup test data
    * def naming = call read('classpath:helpers/naming-helper.js')

  Scenario: Complete E2E Test - Create Organization, Board, List, Cards, Update and Cleanup

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

    # Step 4: Create First Card
    * print '\033[1;36m=== Step 4: Create First Card ===\033[0m'
    * def card1 = call read('classpath:features/feeders/Card.feature@createCard') { idList: '#(list.result.id)', name: #(naming.getStandartNaming('Card')) }
    * print "A new card created with id:  >>>", card1.result.id

    # Step 5: Create Second Card
    * print '\033[1;36m=== Step 5: Create Second Card ===\033[0m'
    * def card2 = call read('classpath:features/feeders/Card.feature@createCard') { idList: '#(list.result.id)', name: #(naming.getStandartNaming('Card')) }
    * print "A new card created with id:  >>>", card2.result.id

    # Step 6: Get Card Details Before Update
    * print '\033[1;36m=== Step 6: Getting Card Details Before Update ===\033[0m'
    * def before = call read('classpath:features/feeders/Card.feature@getCardDetails') { id: '#(card1.result.id)' }
    * def cardNameBefore = before.result.name
    * print "The first card name is:  >>>", cardNameBefore

    # Step 7: Update Card Name
    * def updatedCard = call read('classpath:features/feeders/Card.feature@updateCardName') { id: '#(card1.result.id)', name: #(naming.getStandartNaming('Card')) }
    * match updatedCard.result.id == card1.result.id
    * match updatedCard.result.name != cardNameBefore
    * print 'Card Name Updated Successfully. New Card Name is: >> ', updatedCard.result.name

    # Step 8: Delete Cards
    * call read('classpath:features/feeders/Card.feature@deleteCard') { id: '#(card1.result.id)' }

    * call read('classpath:features/feeders/Card.feature@deleteCard') { id: '#(card2.result.id)'}

    # Step 9: Delete Board
    * call read('classpath:features/feeders/Board.feature@deleteBoard') { id: '#(board.result.id)' }

    # Step 10: Delete Organization
    * print '\033[1;36m=== Step 10: Deleting Organization ===\033[0m'
    * call read('classpath:features/feeders/Organization.feature@deleteOrganization') { id: '#(organization.result.id)'}






 
  


                
                
              
    
    







