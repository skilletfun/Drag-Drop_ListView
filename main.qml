import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12
import Qt.labs.platform 1.0

Window {
    id: root

    width: 500
    height: 600
    title: "WEB Parser"
    visible: true
    color: color_base

    minimumHeight: 600
    minimumWidth: 900

    property color color_base: "#ffffff"
    property color color_accent: "#00ff00"
    property color color_hover: "#caffcf"
    property color color_press: "#74ff7f"

    signal changeIndex(var index_src, var index_dest)
    signal removeIndex(var index)

    onChangeIndex: {
        _model.move(index_src, index_dest, 1);
    }

    onRemoveIndex: {
        _model.remove(index);
    }

    ListView {
        id: view
        anchors.fill: parent
        anchors.margins: 20
        model: _model
        spacing: 10
        clip: true


        displaced: Transition {
            NumberAnimation {
                properties: "x,y"
                easing.type: Easing.OutQuad
                duration: 200
            }
        }

        delegate: DroppableRect {
            id: rect

            height: _height
            width: view.width

            Text {
                text: t
                anchors.centerIn: parent
                font.pixelSize: parent.height/4
            }

            onDropped: {
                root.changeIndex(srcIndex, destIndex);
            }

            onDoubleClicked: {
                root.deleteImageFromModel(index);
            }
        }

    }

    ListModel {
        id: _model

        ListElement {
            t: "Text 1"
        }

        ListElement {
            t: "Text 2"
        }

        ListElement {
            t: "Text 3"
        }
        ListElement {
            t: "Text 4"
        }
        ListElement {
            t: "Text 5"
        }
    }
}
