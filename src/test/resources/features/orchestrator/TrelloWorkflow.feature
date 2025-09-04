@e2e
Feature: E2E Case Study - Complete Trello Workflow

  Background: Setup test data
    * def naming = call read('classpath:helpers/naming-helper.js')
    * def cleanup = call read('classpath:helpers/cleanup-helper.js')

  Scenario: Complete E2E Test - Create Organization, Board, List, Cards, Update and Cleanup

    # Step 1: Create Organization
    * print '\033[1;36m=== Step 1: Create An Organization ===\033[0m'
    * def organization = call read('classpath:features/feeders/Organization.feature@createOrganization') { name: #(naming.getStandartNaming('Organization')) }
    * cleanup.registerOrganization(organization.result.id)
    * print "A new organization created with id:  >>>", organization.result.id

    # Cleanup created data if test failed
    * def cleanup =
    """
    function(result, scenario) {
      var failed = !!karate.info.errorMessage;
      if (failed) {
        karate.log('Test failed - Performing emergency cleanup');
        cleanupHelper.performHierarchicalCleanup();
      } else {
        karate.log('Test passed - No emergency cleanup needed');
      }
    }
    """
    * configure afterScenario = cleanup






 
  


                
                
              
    
    







