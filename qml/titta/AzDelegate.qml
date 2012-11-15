import QtQuick 1.1

Rectangle {
    height: 25
    width: parent.width
    color: "transparent"

    Text {
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#eee";
        font {
            bold: true
            family: "Roboto"
            pixelSize: 12
        }
        text: section
    }
}
