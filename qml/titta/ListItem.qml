import QtQuick 1.1

import "common.js" as Common

Rectangle {
    id: listitem

    property alias text: label.text
    property alias textColor: label.color
    property alias fontBold: label.font.bold
    property alias fontPixelSize: label.font.pixelSize
    property alias imgSource: img.source

    signal clicked()

    height: 70
    width: parent.width
    color: "#222"
    Image {
        id: img

        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - 20
        y: 5

        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.height/5
        width: parent.width - img.width - img.anchors.rightMargin - anchors.leftMargin
        color: "#eee";
        font.pixelSize: parent.height/3.5
        wrapMode: Text.WordWrap
    }
    MouseArea {
        anchors.fill: parent
        onClicked: listitem.clicked()
    }
}
