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

        source: "tidy://www.aftonbladet.se/webbtv/"
        namespaceDeclarations: "declare default element namespace 'http://www.w3.org/1999/xhtml';"
        query: '//*[@id="abNavProgrambox"]/div/ul/li[@class="level1"]/a'

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
        text: model.text

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: model.link.replace('http://', 'tidy://'),
                source: Qt.resolvedUrl("program.qml"),
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
