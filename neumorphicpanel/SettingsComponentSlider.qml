// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic

Column {
	id: control
  
	required property int sliderWidth
	property color mainColor: "gray"

	property alias text: textItem.text	
	property alias from: slider.from
	property alias to: slider.to
	property alias value: slider.value
	property alias stepSize: slider.stepSize

	signal moved

	spacing: 0

	Text {
		id: textItem
		anchors.horizontalCenter: parent.horizontalCenter
		color: "#e0e0e0"
		font.pixelSize: 14
	}

	Slider {
		id: slider
		property real handlePadding: (handleItem.width - handleVisualItem.width) * 0.5
		width: control.sliderWidth
		from: 0
		to: 800
		value: 50
		onMoved: {
			control.moved();
		}

		background: Rectangle {
			x: slider.leftPadding + slider.handlePadding
			y: slider.topPadding + slider.availableHeight / 2 - height / 2
			implicitWidth: 200
			implicitHeight: 4
			width: slider.availableWidth - slider.handlePadding * 2
			height: implicitHeight
			radius: 2
			color: Qt.lighter(control.mainColor, 0.3)
			Rectangle {
				width: slider.visualPosition * parent.width
				height: parent.height
				color: control.mainColor
				radius: 2
				// RectangularShadow {
				// 	anchors.fill: parent
				// 	z: -1
				// 	radius: height / 2
				// 	blur: slider.hovered || slider.pressed ? 12 : 8
				// 	color: Qt.lighter(control.mainColor, 1.2)
				// }
			}
		}

		handle: Item {
			id: handleItem
			x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
			y: slider.topPadding + slider.availableHeight / 2 - height / 2
			implicitWidth: 26
			implicitHeight: 26
			Rectangle {
				id: handleVisualItem
				anchors.centerIn: parent
				width: 8
				height: 8
				radius: width / 2
				color: Qt.lighter(control.mainColor, 1.5)
				// RectangularShadow {
				// 	anchors.fill: parent
				// 	anchors.margins: -2                    
				// 	radius: width / 2
				// 	blur: slider.hovered || slider.pressed ? 16 : 8
				// 	color: Qt.lighter(control.mainColor, 1.2)
				// 	z: -1
				// }
			}
		}
	}
}
