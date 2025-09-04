function fn(args){
// env-> qa, prod, etc

 //from karate-config.js
 var environment = args.environment || 'prod';
 // set base url based on environment
 var url = {
    prod: 'https://api.trello.com/1',
    // qa: 'https://qa.api.trello.com/1'
 };

 var baseUrl = url[environment];


 //path builder
 var path = {

    boards: function() { return '/boards'; },
    boardById: function(id) { return '/boards/' + id; },
    cards: function() { return '/cards'; },
    cardById: function(id) { return '/cards/' + id; },
    organizations: function() { return '/organizations'; },
    organizationById: function(id) { return '/organizations/' + id; },
    lists: function() { return '/lists'; },
    listById: function(id) { return '/lists/' + id; }

 };

 return {url: baseUrl , path: path} ;


}