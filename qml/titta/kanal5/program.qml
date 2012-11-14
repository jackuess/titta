import QtQuick 1.1

import "../viewstack.js" as ViewStack
import "../common.js" as Common
import ".."

ListView {
    id: list

    signal statusChanged(int newStatus)

    property int programSeason
    property string programName

    height: 1
    model: XmlListModel {
        id: indexModel

        onStatusChanged: list.statusChanged(status)

        query: "//div[@class=\"sbs-video-season-episode-teaser\"]"

        XmlRole {
            name: "title"
            query: "table//h4[@class=\"title\"]/a/string()"
        }
        XmlRole {
            name: "description"
            query: "table//p[@class=\"description\"]/string()"
        }

        XmlRole {
            name: "thumb"
            query: "table//img/@src/string()"
        }
        XmlRole {
            name: "link"
            query: "table//h4[@class=\"title\"]/a/@href/string()"
        }
    }
    delegate: ListItem {
        imgSource: model.thumb
        text: "<strong>" + model.title.slim() + "</strong><br/><small>" + model.description + "</small>"

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "http://pirateplay.se/api/get_streams.xml?url=" + "http://kanal5play.se" + model.link,
                source: "../pirateplay.qml",
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
}
