(function() {
    var trelloItems = {};

    function addTrelloItem(itemType, id) {
        if(!trelloItems[itemType]) {
            trelloItems[itemType] = [];
        }
        trelloItems[itemType].push(id);
        karate.log('Added ' + itemType + ' with id: ' + id);
    }

    function getTrelloItems() {  return trelloItems; }

    function clearAll() {
        trelloItems = {};
        karate.log('Cleared all Trello items from cleanup list.');
    }
    return {add: addTrelloItem, get: getTrelloItems, clearAll: clearAll};
})()