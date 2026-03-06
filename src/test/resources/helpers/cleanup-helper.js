var trelloItems = [];

function addTrelloItem(itemName, id) {
    var entity = { type: itemName, id: id };
    trelloItems.push(entity);
    karate.log('Added ' + itemName + ' with id: ' + id);
}

function getTrelloItems() {
    return trelloItems;
}

function clear() {
trelloItems = [];
karate.log('Cleared all Trello items from cleanup list.');
}

{addTrelloItem: add, getTrelloItems: get, clear: clear}