import QtQuick 1.1

import "../viewstack.js" as ViewStack
import "../common.js" as Common
import ".."

ListView {
    id: list

    signal statusChanged(int newStatus)

    Component.onCompleted: statusChanged(XmlListModel.Ready)

    height: 1

    model: ListModel {
        ListElement {
            title: "Program A-Ö"
            module: "alfabetical"
            url: "tidy://www.svtplay.se/program"
        }
        ListElement {
            title: "Rekommenderat"
            module: "program"
            url: "tidy://www.svtplay.se/?tab=recommended&sida=3"
        }
        ListElement {
            title: "Senaste program"
            module: "program"
            url: "tidy://www.svtplay.se/?tab=episodes&sida=3"
        }
    }

    delegate: ListItem {
        text: model.title

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: model.url,
                name: model.text,
                source: Qt.resolvedUrl(model.module + ".qml"),
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
}
