import QtQuick 2.15
import QtQuick.Window 2.12

Window {
    width: 300
    height: 570
    visible: true
    title: qsTr("List")

    Rectangle {
        id: root
        anchors.fill: parent
        color: "#f7f2f2"
        clip: true

        ListModel {
            id: _model

            ListElement {
                _x: "Element 1"
            }
            ListElement {
                _x: "Element 2"
            }
            ListElement {
                _x: "Element 3"
            }

            ListElement {
                _x: "Element 4"
            }
            ListElement {
                _x: "Element 5"
            }
            ListElement {
                _x: "Element 6"
            }
            ListElement {
                _x: "Element 7"
            }
            ListElement {
                _x: "Element 8"
            }
            ListElement {
                _x: "Element 9"
            }
        }

        signal changeIndex(var index_src, var index_dest)

        onChangeIndex: {
            _model.move(index_src, index_dest, 1);
        }

        ListView {
            id: list
            anchors.fill: parent
            anchors.margins: 20
            model: _model
            spacing: 10

            delegate: Rectangle {
                id: dragRect

                property string _index: index

                width: list.width
                height: 50
                color: "transparent"
                border.color: "transparent"
                border.width: 3

                Rectangle {
                    id: childRect
                    anchors.fill: parent
                    anchors.margins: 3
                    border.color: "black"
                    border.width: 1
                    color: "#cceaff"

                    Text {
                        id: _t
                        text: _x
                        anchors.centerIn: parent
                    }
                }

                MouseArea {
                    id: area
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: dragRect

                    drag.onActiveChanged: {
                        dropA.enabled = !dropA.enabled;
                        dragRect.Drag.drop();
                        dragRect.z = 2;
                        childRect.anchors.margins = 5;
                        childRect.color = "#a6dbff";

                        if (dropA.enabled)
                        {
                            childRect.color = "#cceaff";
                            childRect.anchors.margins = 3;
                            dragRect.z = 1;
                            dragRect.x = 0;
                            dragRect.y = index * (dragRect.height + list.spacing);
                        }
                    }
                }

                DropArea {
                    id: dropA
                    anchors.fill: parent

                    onEntered: {
                        dragRect.border.color = "#54ff67";
                    }
                    onExited: {
                        dragRect.border.color = "transparent";
                    }

                    onDropped: {
                        dragRect.border.color = "transparent";
                        root.changeIndex(drop.source._index, index);
                    }
                }

                Drag.active: area.drag.active
                Drag.hotSpot.x: dragRect.width / 2
                Drag.hotSpot.y: dragRect.height / 2
            }
        }
    }
}
