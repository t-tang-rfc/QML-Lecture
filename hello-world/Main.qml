// @brief: A Simple QML Hello World Example

import QtQuick

Window {
	visible: true
	width: 400
	height: 200
	title: "Hello World QML"

	Rectangle {
		anchors.fill: parent
		color: "#f4f4f9"
		Text {
			text: "Hello, World!"
			anchors.centerIn: parent
			font.pixelSize: 32
			color: "#232946"
		}
	}
}
