import QtQuick 1.1

import "../viewstack.js" as ViewStack
import "../common.js" as Common
import ".."

ListView {
    id: list
    spacing: 0
    height: 1
    //onContentHeightChanged: if (contentHeight > 0) height = contentHeight

    signal statusChanged(int newStatus)

    model: XmlListModel {
        id: indexModel
        source: "tidy://www.svtplay.se/program"
        query: "//li[@class=\"playListItem\"]/a"

        onStatusChanged: list.statusChanged(indexModel.status)

        XmlRole {
            name: "text"
            query: "string()"
        }
        XmlRole {
            name: "link"
            query: "@href/string()"
        }
    }
    delegate: ListItem {
        text: model.text.slim()

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "tidy://www.svtplay.se" + model.link,
                name: model.text,
                source: Qt.resolvedUrl("program.qml"),
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                    this.loader.item.programName = this.name;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
    section.property: "text"
    section.criteria: ViewSection.FirstCharacter
    section.delegate: AzDelegate {}
}
