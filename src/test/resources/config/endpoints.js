function fn(args){
// env-> qa, prod, etc

 //from karate-config.js
 /*
 var environment = args.environment || 'prod';
 // set base url based on environment
 var url = {
    prod: 'https://api.trello.com/v1',
    // qa: 'https://qa.api.trello.com/v1'
 };

 var baseUrl = url[environment];
 */


 //path builder
 var path = {

    boards: () => '/boards',
    boardById: (id) => `/boards/${id}`,
    cards: () => '/cards',
    cardById: (id) => `/cards/${id}`,
    organizations: () => '/organizations',
    organizationById: (id) => `/organizations/${id}`,
    lists : () => '/lists',
    listById : (id) => `/lists/${id}`




 };

 //return {url: baseUrl , path: path} ;
   return {url: 'https://api.trello.com/1', path: path} ;


}