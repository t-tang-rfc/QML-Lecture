// @brief: A Neu-morphic Style Button

import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Effects

Button {
	id: control

	property real buttonWidth: 100
	property real buttonHeight: 40
	property color mainColor: "gray"
	property real animatedPressed: control.down ? 1.0 : 0.0
	property real animatedChecked: control.checked ? 1.0 : 0.0

	background: Rectangle {
		id: backgroundRect
		implicitWidth: control.buttonWidth
		implicitHeight: control.buttonHeight
		opacity: enabled ? 1 : 0.3
		radius: height * 0.5
		color: Qt.lighter(control.mainColor, 0.3)
		border.width: 1
		RectangularShadow {
			// Inner shadow
			anchors.fill: backgroundRect
			anchors.margins: blur
			radius: height * 0.4
			color: Qt.lighter(control.mainColor, 0.4 + control.animatedPressed * 0.2 + control.animatedChecked * 0.6)
			blur: height * 0.4			
		}
		RectangularShadow {
			// Glow
			anchors.fill: backgroundRect
			radius: height * 0.4
			color: Qt.lighter(control.mainColor, 1.2)
			opacity: 0.1 + control.animatedPressed * 0.4
			blur: 60
			z: -1
		}
	}

	contentItem: Text {
		text: control.text // passed in from parent of Button
		font: control.font
		opacity: enabled ? 0.7 + 0.3 * control.animatedPressed + control.animatedChecked * 0.3 : 0.3
		color: "#ffffff"
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideRight // truncate text and add ellipsis if it doesn't fit
	}

	Behavior on animatedPressed {
		NumberAnimation {
			duration: 200
			easing.type: Easing.InOutQuad
		}
	}
}
