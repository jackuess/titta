import QtQuick 1.1

import "../viewstack.js" as ViewStack
import "../common.js" as Common
import ".."

ListView {
    id: list

    signal statusChanged(int newStatus)

    height: 1
    model: XmlListModel {
        id: indexModel

        onStatusChanged: list.statusChanged(status)

        source: "tidy://www.kanal5play.se/program"
        query: "//div[@class=\"logo\" and descendant::img]"

        XmlRole {
            name: "text"
            query: "a[@class=\"ajax\"]/img/@alt/string()"
        }
        XmlRole {
            name: "image"
            query: "a[@class=\"ajax\"]/img/@src/string()"
        }
        XmlRole {
            name: "link"
            query: "a[@class=\"ajax\"]/@href/string()"
        }
    }
    delegate: ListItem {
        imgSource: model.image
        text: model.text.slim()

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "tidy://www.kanal5play.se" + model.link,
                source: Qt.resolvedUrl("season.qml"),
                name: model.text.slim(),
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
