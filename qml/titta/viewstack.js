.pragma library

var currentFactory;
var factoryStack = [];

var rootItem;
var loaderItem;

function setRoot(newRoot) { rootItem = newRoot; }
function setLoader(newLoader) { loaderItem = newLoader; }

function pushFactory(newFactory) {
    currentFactory.scroll = loaderItem.item.contentY;
    rootItem.isToplevel = false;
    factoryStack.push(currentFactory);
    currentFactory = newFactory;
    currentFactory.callback();
}

