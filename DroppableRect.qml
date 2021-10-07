import QtQuick 2.15


Rectangle {
    id: rect

    property int _height: 100

    property int _index: index
    property int _spacing: 10

    property color _hoverBorderColor: "#b8eef5"
    property int _hoverBorderWidth: 6

    signal doubleClicked(var index)
    signal released(var index)
    signal dropped(var srcIndex, var destIndex)

    property color _instantBorderColor: color_accent
    property int _instantBorderWidth: 2

    property color color_base: "#ffffff"
    property color color_accent: "#00ff00"
    property color color_hover: "#caffcf"
    property color color_press: "#74ff7f"

    border.color: color_accent
    border.width: 2

    color: area.containsPress ? color_press : area.containsMouse ? color_hover : color_base

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true

        property double _k: 0.8

        onDoubleClicked: {
            rect.doubleClicked(index);
        }

        onReleased: {
            rect.released(index);
        }

        drag.target: rect

        drag.onActiveChanged: {
            dropA.enabled = !dropA.enabled;
            rect.Drag.drop();
            rect.z = 2;

            if (dropA.enabled)
            {
                rect.x = 0;
                rect.z = 1;
                rect.y = index * (rect.height + rect._spacing);
            }
        }
    }

    DropArea {
        id: dropA
        anchors.fill: parent

        onEntered: {
            rect.border.color = rect._hoverBorderColor;
            rect.border.width = rect._hoverBorderWidth;
        }

        onExited: {
            rect.border.color = color_accent;
            rect.border.width = 2;
        }

        onDropped: {
            rect.border.color = color_accent;
            rect.border.width = 2;
            rect.dropped(drop.source._index, index);
        }
    }

    Drag.active: area.drag.active
    Drag.hotSpot.x: rect.width / 2
    Drag.hotSpot.y: rect.height / 2
}
