// @brief: A simple QML Cell component, to be used as construction block of a grid-like color picker.
// @see: [QML Object Attributes](https://doc.qt.io/qt-6/qtqml-syntax-objectattributes.html)

import QtQuick

Item {
	id: container
	property alias cellColor: rectangle.color   // property *alias* is used to expose a property of a child item
	signal clicked(cellColor: color)            // equivalent to C++ Q_SIGNAL of `QWidget`

	width: 96; height: 32

	Rectangle {
		id: rectangle
		border.color: "black"
		border.width: 2
		anchors.fill: parent
	}

	MouseArea {
		anchors.fill: parent
		onClicked: container.clicked(container.cellColor) // emit the signal with the cell color when clicked
	}
}
