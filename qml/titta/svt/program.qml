import QtQuick 1.1

import "../viewstack.js" as ViewStack
import "../common.js" as Common
import ".."

ListView {
    id: svtProgram

    property string programName
    signal statusChanged(int newStatus)

    height: 1
    spacing: 0
    model: XmlListModel {
        id: programModel
        query: '//div[@data-tabname="episodes" or @data-tabname="recommended"]//article'

        onStatusChanged: svtProgram.statusChanged(programModel.status)

        XmlRole {
            name: "text"
            //query: "div/header/h5/string()"
            query: "@data-title/string()"
        }
        XmlRole {
            name: "link"
            query: "div/a[1]/@href/string()"
        }
        XmlRole {
            name: "thumb"
            query: "div//img/@src/string()"
        }
    }
    delegate: ListItem {
        text: model.text.slim()
        imgSource: model.thumb.startsWith("http://") ? model.thumb : "http://svtplay.se" + model.thumb
        onClicked: {
            var newFactory = {
                loader: currentView,
                url: "http://pirateplay.se/api/get_streams.xml?url=http://svtplay.se" + model.link,
                source: "../pirateplay.qml",
                callback: function () {
                    this.loader.source = this.source;
                    this.loader.item.model.source = this.url;
                }};
            ViewStack.pushFactory(newFactory);
        }
    }
}
