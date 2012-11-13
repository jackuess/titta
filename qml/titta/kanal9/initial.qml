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

        source: "tidy://www.kanal9play.se/program"
        query: '//a[@class="k5-AToZPanel-program k5-AToZPanel-channel-KANAL9" or @class="k5-AToZPanel-program k5-AToZPanel-channel-KANAL9 k5-AToZPanel-program-topical"]'

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
                url: "tidy://www.kanal9play.se" + model.link,
                source: Qt.resolvedUrl("season.qml"),
                name: model.text.slim(),
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
    section.property: "text"
    section.criteria: ViewSection.FirstCharacter
    section.delegate: AzDelegate {}
}
