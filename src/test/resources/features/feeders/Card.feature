
Feature: Card operations

  Background: Common setup
    Given url baseUrl
    * param key = apiKey
    * param token = accessToken
    * def naming = call read('classpath:helpers/naming-helper.js')
    * def path = endpoints.path

  @createCard
  Scenario: Create a card under the list
    * path endpoints.path.cards()
    * param name = (typeof cardName != 'undefined' && cardName ? cardName : naming.getStandartNaming('Card'))
    * param idList = karate.get('idList')
    * request ''
    * method post
    * status 200
    * match response.id == "#notnull"
    * match response.closed == false
    * def cardSchema = read('classpath:schemas/card.json')
    * def result = { id: '#(response.id)', name: '#(response.name)', listId: '#(response.idBList)' }
    * print "Card created with ID:", result.id

  @updateCardName
  Scenario: Update card name by id and return updated card
    * def cardId = karate.get('id')
    * def newName = (typeof cardName != 'undefined' && cardName ? cardName : naming.getStandartNaming('Card'))
    * path endpoints.path.cardById(cardId)
    * param name = newName
    * request ''
    * method put
    * status 200
    * match $.name == newName
    * def result = { id: '#(response.id)', name: '#(response.name)', listId: '#(response.idBList)' }
    * print "Card updated with new name:", response.name

  @getCardDetails
  Scenario: Get card details
    * def cardId = karate.get('id')
    * path endpoints.path.cardById(cardId)
    * request ''
    * method get
    * status 200
    * def result = { id: '#(response.id)', name: '#(response.name)', listId: '#(response.idBList)' }
    * print "Card details retrieved for ID:", response.id

  @deleteCard
  Scenario: Delete card by id
    * def cardId = karate.get('id')
    * path endpoints.path.cardById(cardId)
    * request ''
    * method delete
    * status 200
    * print 'The card (' + cardId + ') is deleted successfully'






