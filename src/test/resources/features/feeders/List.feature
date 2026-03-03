Feature: list operations

  Background: Call required fields
    Given url baseUrl
    * param key = apiKey
    * param token = accessToken
    * def naming = call read('classpath:helpers/naming-helper.js')
    * def path = endpoints.path

  @createList
  Scenario: Create a new list under the board
    * path path.lists()
    * def listName = (typeof listName != 'undefined' && listName ? listName : naming.getStandartNaming('List'))
    * param idBoard = boardId
    * param name = listName
    * request ''
    * method post
    * status 200
    * match $.id == "#notnull"
    * def result = { id: '#(response.id)', name: '#(response.displayName)', boardId: '#(response.idBoard)' }
    * print "List created with ID:", result.id
