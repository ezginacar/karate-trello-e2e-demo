@cleanup
Feature: Cleanup operations

  Background:
    Given def registry = read('classpath:helpers/cleanup-helper.js')
    * def itemsToDelete = registry.get();

  @cleanupOrganizationFlow
  Scenario: Delete all created entities with n8n
    * print '\033[1;36m=== Cleanup From N8N cleanup-organization-flow ===\033[0m'
    * def n8n  = n8nUrl + '/webhook/cleanup-organization-flow'
    Given url n8n
    * request { "itemsToDelete": "#(itemsToDelete)", "apiKey": "#(apiKey)", "token": "#(accessToken)" }
    When method post
    Then status 200
    * eval registry.clearAll();