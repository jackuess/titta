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

        onStatusChanged: {
            if (status === XmlListModel.Ready && indexModel.count < 1) {
                currentView.source = Qt.resolvedUrl('program.qml');
                currentView.item.model.namespaceDeclarations = "declare default element namespace 'http://www.w3.org/1999/xhtml';"
                currentView.item.model.source = decodeURIComponent(indexModel.source);
            } else {
                list.statusChanged(status)
            }
        }

        namespaceDeclarations: "declare default element namespace 'http://www.w3.org/1999/xhtml';"
        query: '//div[@class="k5-tab selected"]/table//div[@class="buttons"]/div'

        XmlRole {
            name: "seasonNumber"
            query: "text()[1]/string()"
        }
        XmlRole {
            name: "link"
            query: "span/string()"
        }
    }
    delegate: ListItem {
        gradient: Gradient {
            GradientStop { position: 0.0; color: ["#444","#444"][model.index%2] }
            GradientStop { position: 1.0; color: ["#222","#666"][model.index%2] }
        }
        text: "Säsong " + model.seasonNumber

        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "tidy://www.kanal9play.se" + model.link,
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
