import QtQuick 1.1

import "../viewstack.js" as ViewStack
import "../common.js" as Common
import ".."

ListView {
    id: list

    signal statusChanged(int newStatus)

    property string programName

    height: 1
    model: XmlListModel {
        id: indexModel

        onStatusChanged: list.statusChanged(indexModel.status)

        query: "//div[@class=\"season\"]"

        XmlRole {
            name: "text"
            query: "h2/string()"
        }
        XmlRole {
            name: "link"
            query: "div[@class=\"season-info\"]/a/@href/string()"
        }
    }
    delegate: ListItem {
        text: model.text.slim()

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "tidy://www.kanal5play.se" + model.link,
                source: Qt.resolvedUrl("program.qml"),
                season: parseInt(model.text.slim().replace("Säsong ", "")),
                name: list.programName,
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                    this.loader.item.programSeason = this.season;
                    this.loader.item.programName = this.name;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
}
