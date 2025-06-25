// @brief: A Simple QML Hello World Example

import QtQuick

Window {
	id: mainWindow // id *attribute* is used to reference this object in this QML file
	visible: true
	width: 800
	height: 600
	title: "QML hello-world Example"

	Rectangle {
		id: mainCanvas
		color: "#27376C"
		anchors.fill: parent
		Text {
			id: greetingText
			text: "Hello, RIVERFIELD!"
			font.pixelSize: 64
			color: "#FFFFFF"
			anchors.centerIn: parent // layout using anchors
		}
	}
}
