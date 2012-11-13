import QtQuick 1.1

import "viewstack.js" as ViewStack
import "common.js" as Common

ListView {
    id: pirateplay

    signal statusChanged(int newStatus)

    height: 1
    spacing: 0
    model: XmlListModel {
        id: pirateModel
        query: '//stream';

        onStatusChanged: {
            if (pirateModel.status == XmlListModel.Error)
                console.log(pirateModel.errorString());
            pirateplay.statusChanged(pirateModel.status)
        }

        XmlRole {
            name: "quality"
            query: "@quality/string()"
        }
        XmlRole {
            name: "streamUrl"
            query: "string()"
        }
    }
    delegate: ListItem {
        text: model.quality.slim()
        onClicked: Qt.openUrlExternally(model.streamUrl)
    }
}
