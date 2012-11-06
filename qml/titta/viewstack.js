.pragma library

var currentFactory;
var factoryStack = [];

var rootItem;

function setRoot(newRoot) { rootItem = newRoot; }

function pushFactory(newFactory) {
    //currentFactory.scroll = scrollArea.verticalScrollBar.value;
    rootItem.isToplevel = false;
    factoryStack.push(currentFactory);
    currentFactory = newFactory;
    currentFactory.callback();
}

