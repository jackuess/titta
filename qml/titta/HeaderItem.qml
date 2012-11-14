import QtQuick 1.1

import "common.js" as Common

Rectangle {
    id: listItem

    property alias text: label.text
    property alias textColor: label.color
    property alias fontBold: label.font.bold
    property alias fontPixelSize: label.font.pixelSize

    height: 40
    width: parent.width
    color: "#181818"

    Text {
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#eee"
        font.pixelSize: 16
        font.bold: true
        wrapMode: Text.WordWrap
    }

    Rectangle {
        anchors.bottom: parent.bottom
        height: 3
        width: parent.width
        color: "#252525"
    }
}
