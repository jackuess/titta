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
    color: "transparent" //"#181818"

    Text {
        id: label
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        x: 10
        color: "#eee"
        font.family: "Roboto"
        font.pixelSize: 16
        font.bold: true
        wrapMode: Text.WordWrap
    }

    Rectangle {
        anchors.bottom: parent.bottom
        height: 2
        width: parent.width
        color: "#33B5E5"
    }
}
