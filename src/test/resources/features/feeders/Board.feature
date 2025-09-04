Feature: Board operations

  Background: Call required fields
    Given url baseUrl
    * param key = apiKey
    * param token = accessToken
    * def naming = call read('classpath:helpers/naming-helper.js')
    * def path = endpoints.path

  @createBoard
  Scenario: Create a new board
    * path endpoints.path.boards()
    * def boardName = (typeof boardName != 'undefined' && boardName ? boardName : naming.getStandartNaming('Board'))
     #Determine organization ID based on available parameters
    * def orgId = (typeof idOrganization != 'undefined' && idOrganization) ? idOrganization : (typeof organizationId != 'undefined' && organizationId) ? organizationId : (typeof id != 'undefined' && id) ? id : null
    * param idOrganization = orgId
    * param name = boardName
    * request ''
    * method post
    * status 200
    * match $.id == "#notnull"
    * def result = { id: '#(response.id)', name: '#(response.name)', organizationId: '#(response.idOrganization)' }
    * print "Board created with ID:", result.id


  @deleteBoard
  Scenario: Delete board by id
    * def boardId = karate.get('id')
    * path endpoints.path.boardById(boardId)
    * request ''
    * method delete
    * status 200
    * print 'The board (' + boardId + ') is deleted successfully'
