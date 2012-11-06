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

        onSourceChanged: console.log(pirateModel.source)

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
        gradient: Gradient {
            GradientStop { position: 0.0; color: ["#555","#333"][model.index%2] }
            GradientStop { position: 1.0; color: ["#111","#777"][model.index%2] }
        }

        text: model.quality.slim()
        onClicked: Qt.openUrlExternally(model.streamUrl)
    }
}
