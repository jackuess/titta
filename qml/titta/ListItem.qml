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
    color: ["#222", "#444"][model.index%2]
//    gradient: Gradient {
//        GradientStop { position: 0.0; color: ["#555","#333"][model.index%2] }
//        GradientStop { position: 1.0; color: ["#111","#777"][model.index%2] }
//    }
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
    MouseArea {
        anchors.fill: parent
        onClicked: listItem.clicked()
        onCanceled: listItem.color = ["#222", "#444"][model.index%2]
        onEntered: listItem.color = ["#444", "#222"][model.index%2]
        onExited: listItem.color = ["#222", "#444"][model.index%2]
    }
}
