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

        query: '//div[@class="k5-video-teasers-grid"]//table[not(@width)]//td//a'

        XmlRole {
            name: "title"
            query: "@title/string()"
        }
        XmlRole {
            name: "link"
            query: "@href/string()"
        }
        XmlRole {
            name: "programName"
            query: 'span[@class="title"]/span[@class="program-name"]/string()'
        }

        XmlRole {
            name: "thumb"
            query: "img/@src/string()"
        }
    }
    delegate: ListItem {
        imgSource: model.thumb
        text: model.title.slim()

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "http://pirateplay.se/api/get_streams.xml?url=http://kanal9play.se" + model.link,
                source: Qt.resolvedUrl("../pirateplay.qml"),
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
}
