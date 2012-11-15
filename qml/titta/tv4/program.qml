import QtQuick 1.1

import "../common.js" as Common
import "../viewstack.js" as ViewStack

import ".."

Item {
    id: list

    signal statusChanged(int newStatus)

    property alias url: programModel.source
    property alias model: programModel
    property string programName

    XmlListModel {
        id: programModel
        query: "//a[@class=\"js-show-more btn secondary full\"]"

        onStatusChanged: {
            if (status === XmlListModel.Ready) {
                try {
                    episodesList.model.source = "tidy://www.tv4play.se" + decodeURIComponent(get(0).link) + "&page=0&per_page=999";
                } catch (err) {
                    if (err.name === 'TypeError')
                        episodesList.model.source = programModel.source;
                    else
                        throw err;
                }
            }
        }

        XmlRole {
            name: "link"
            query: "@data-more-from/string()"
        }
    }
    ListView {
        id: episodesList

        anchors.fill: parent
        model: XmlListModel {
            onStatusChanged: list.statusChanged(status)

            query: "//div[@class=\"js-search-page\"]//li[not(descendant::p[starts-with(@class, 'requires-authorization')])]"

            XmlRole {
                name: "text"
                query: "div/h3/string()"
            }
            XmlRole {
                name: "link"
                query: "div/h3[@class=\"video-title\"]/a/@href/string()"
            }
            XmlRole {
                name: "date"
                query: "div/div[@class=\"video-meta\"]/p[@class=\"date\"]/string()"
            }
            XmlRole {
                name: "image"
                query: "p[@class=\"video-picture\"]/a/img/@src/string()"
            }
        }
        delegate: ListItem {
            imgSource: {
                var url = model.image;
                var pairs = url.split("&amp;");
                for (var i=0; i<pairs.length; i++) {
                    var pair = pairs[i].split("=");
                    if (pair[0] === "source")
                        return pair[1];
                }
            }
            text: model.text.slim() + "<br/>" + model.date

            onClicked: {
                var newFactory = {
                    loader: currentView,
                    url: "http://pirateplay.se/api/get_streams.xml?url=http://tv4play.se" + model.link,
                    source: "../pirateplay.qml",
                    callback: function () {
                        this.loader.source = this.source;
                        this.loader.item.model.source = this.url;
                    }};
                ViewStack.pushFactory(newFactory);
            }
        }
    }
}
