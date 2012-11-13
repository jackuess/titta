import QtQuick 1.1

import "../viewstack.js" as ViewStack
import "../common.js" as Common

import ".."

ListView {
    id: list

    signal statusChanged(int newStatus)

    height: 1
    model: XmlListModel {
        onStatusChanged: list.statusChanged(status)

        source: "tidy://www.tv4play.se/program?per_page=999&per_row=4&page=1&content-type=a-o&is_premium=false"
        query: "//ul[@class=\"a-o-list js-show-more-content\"]/li/ul/li/a"

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
                url: "tidy://www.tv4play.se" + model.link,
                source: Qt.resolvedUrl("program.qml"),
                name: model.text.slim(),
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.url = this.url;
                    this.loader.item.programName = this.name;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
    section.property: "text"
    section.criteria: ViewSection.FirstCharacter
    section.delegate: AzDelegate {}
}
