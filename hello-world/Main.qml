// @brief: A Simple QML Hello World Example
// @see: [The official Qt tutorial](https://doc.qt.io/qt-6/qml-tutorial1.html)

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

		// Animate background color changes
		Behavior on color {
			ColorAnimation { duration: 400 }
		}

		Text {
			id: greetingText
			text: "Hello, RIVERFIELD!"
			font.pixelSize: 64
			color: "#FFFFFF"
			anchors.centerIn: parent // layout using anchors

			// Animate foreground (text) color changes
			Behavior on color {
				ColorAnimation { duration: 400 } // unit in milliseconds
			}
		}

		Grid {
			// @brief: A color picker, first row for for the foreground color, second row for the background color.
			id: colorPicker
			rows: 2; columns: 3; rowSpacing: 10; columnSpacing: 6
			anchors.left: parent.left
			anchors.leftMargin: 8
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 8

			// @note: The constructions go row first.
			Cell {
				cellColor: "#FFFFFF"
				onClicked: function(color) { greetingText.color = color } // @note: this is a JavaScript function!
			}
			Cell {
				cellColor: "#838787"
				onClicked: function(color) { greetingText.color = color }
			}
			Cell {
				cellColor: "#34A5DA"
				onClicked: function(color) { greetingText.color = color }
			}
			Cell {
				cellColor: "#27376C"
				onClicked: function(color) { mainCanvas.color = color }
			}
			Cell {
				cellColor: "#212121"
				onClicked: function(color) { mainCanvas.color = color }
			}
			Cell {
				cellColor: "#FFFFFF"
				onClicked: function(color) { mainCanvas.color = color }
			}
		}
	}

	// Make the window display in the center of the screen
	Component.onCompleted: {
		x = (Screen.width - width) / 2
		y = (Screen.height - height) / 2
	}
}
