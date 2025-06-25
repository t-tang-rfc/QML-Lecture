// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic

Button {
    id: control

    property color mainColor: "gray"
    property real animatedPressed: control.down ? 1.0 : 0.0
    property real animatedChecked: control.checked ? 1.0 : 0.0

    Behavior on animatedPressed {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    height: 40
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 0.7 + 0.3 * control.animatedPressed + control.animatedChecked * 0.3 : 0.3
        color: "#ffffff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        radius: height * 0.5
        color: Qt.lighter(control.mainColor, 0.3)
        border.width: 1
        border.color: Qt.lighter(control.mainColor, 0.1)
        RectangularShadow {
            // Inner shadow
            anchors.fill: parent
            anchors.margins: blur
            radius: height * 0.4
            blur: height * 0.4
            color: Qt.lighter(control.mainColor, 0.4 + control.animatedPressed * 0.2 + control.animatedChecked * 0.6)
        }
        RectangularShadow {
            // Glow
            anchors.fill: parent
            z: -1
            radius: height * 0.4
            blur: 60
            opacity: 0.1 + control.animatedPressed * 0.4
            color: Qt.lighter(control.mainColor, 1.2)
        }
    }
}
