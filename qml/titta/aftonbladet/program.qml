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

        namespaceDeclarations: "declare default element namespace 'http://www.w3.org/1999/xhtml';"
        query: '//*[@id="abArtikelytaContainer"]/div[@class="abLinkBlock"][position() <= 2]//div[@class="abTeaser"]'

        XmlRole {
            name: "title"
            query: 'div//span[@class="abLink"]/a/string()'
        }
        XmlRole {
            name: "description"
            query: 'div[@class="abTeaserText"]/text()[2]/string()'
        }
        XmlRole {
            name: "thumb"
            query: "span//img/@src/string()"
        }
        XmlRole {
            name: "link"
            query: 'div//span[@class="abLink"]/a/@href/string()'
        }
    }
    delegate: ListItem {
        imgSource: decodeURIComponent(model.thumb)
        text: model.title.slim() + " - <small>" + model.description.slim() + "</small>"

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "http://pirateplay.se/api/get_streams.xml?url=" + model.link,
                source: "../pirateplay.qml",
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
}
