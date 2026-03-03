function fn() {
/*
  var env = karate.env || 'prod';
  karate.log('Test environment :', env);
 */

  // Read endpoints only once
  //var endpoints = karate.callSingle('classpath:config/endpoints.js', { environment: env });
  //direct access to endpoints in feature files
    var endpoints = karate.callSingle('classpath:config/endpoints.js');
  karate.set('endpoints', endpoints);
    // Read headers only once
  karate.configure('headers', karate.read('classpath:config/header.js'));
   

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 5000);


   // Debug mode
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);
  karate.configure('printEnabled', true);
  // mask sensitive info in reports like api keys, tokens, etc
  karate.configure('report', {
    showLog: true,
    showAllSteps: true,
    masks: ['key','Key','token','Token','apiKey','apiToken','Authorization']
  });


    return {
         baseUrl: endpoints.url,
         accessToken: karate.properties['TRELLO_ACCESS_TOKEN'] || java.lang.System.getenv('TRELLO_ACCESS_TOKEN'),
         apiKey: karate.properties['TRELLO_API_KEY'] || java.lang.System.getenv('TRELLO_API_KEY')

    };


 }
