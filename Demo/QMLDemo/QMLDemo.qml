import QtQuick 1.0

Rectangle {
    width: 800
    height: 600

    FontLoader {
        source: ":/Gutenberg.ttf"
    }

    Text {
        anchors.centerIn: parent
        font.pointSize: 250
        font.family: "FontAwesome"
        text: "\uf00c"
    }

}
