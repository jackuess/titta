import QtQuick 1.1

import "common.js" as Common

Rectangle {
    id: listItem

    property alias text: label.text
    property alias textColor: label.color
    property alias fontBold: label.font.bold
    property alias fontPixelSize: label.font.pixelSize
    property alias imgSource: img.source

    signal clicked()

    height: Math.max(label.height + 20, 70)
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"

    Image {
        id: img

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        height: 50
        y: label.height > img.height ? label.height/2 : 10

        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: parent.width - img.width - img.anchors.rightMargin - anchors.leftMargin
        color: "#eee";
        font.pixelSize: 16
        font.family: "Roboto"
        wrapMode: Text.WordWrap
    }
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#373A3D"
        width: parent.width - 20
        height: 1
    }

    MouseArea {
        anchors.fill: parent
        onClicked: listItem.clicked()
        onCanceled: listItem.color = "transparent"
        onEntered: listItem.color = "#0099cc"
        onExited: listItem.color = "transparent"
    }
}
