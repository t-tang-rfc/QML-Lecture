// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

/// @todo: Squash merge

import QtQuick
import QtQuick.Window
import QtQuick.Effects

// @todo: Add a window
Rectangle {
	id: mainCanvas

	// Multiplier for resolution independency
	readonly property real dp: 0.8 // 0.2 + Math.min(width, height) / 1200
	// Color used everywhere in the example
	property color mainColor: "#b0b0b0"

	width: 1280
	height: 720
	color: mainColor

	// Animate the background color
	SequentialAnimation on color {
		loops: Animation.Infinite
		ColorAnimation {
			to: "#60c0d0"
			duration: 8000
		}
		ColorAnimation {
			to: "#80d090"
			duration: 8000
		}
		ColorAnimation {
			to: "#d0c0b0"
			duration: 8000
		}
		ColorAnimation {
			to: "#b0b0b0"
			duration: 8000
		}
	}	

	Settings {
		id: settings
	}

	// Primary (left) Side Bar
	SettingsView {
		id: settingsView
		width: 270
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.margins: 20
		visible: settings.showSettingsView
	}

	Item {
		id: mainArea
		anchors.left: settingsView.right
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		Rectangle {
			id: sourceItem
			anchors.centerIn: parent
			width: settings.itemSize * 2
			height: settings.itemSize
			radius: settings.radius
			gradient: Gradient {
				id: gradient
				property real lightLevelUp: 1.05 - settings.offsetY * 0.004 * settings.opacity
				property real lightLevelDown: 1.05 + settings.offsetY * 0.004 * settings.opacity
				GradientStop {
					color: Qt.lighter(mainCanvas.mainColor, gradient.lightLevelUp)
					position: 0
				}
				GradientStop {
					color: Qt.lighter(mainCanvas.mainColor, gradient.lightLevelDown)
					position: 1
				}
			}
			Image {
				anchors.centerIn: parent
				height: parent.height * 0.6
				width: height
				source: "images/qt_logo_white_rgb.png" // @todo
				opacity: 0.1
			}
		}

		// RectangularShadow {
		// 	anchors.fill: sourceItem
		// 	offset.x: settings.offsetX
		// 	offset.y: settings.offsetY
		// 	radius: settings.radius
		// 	blur: settings.blur
		// 	spread: settings.spread
		// 	opacity: settings.opacity
		// 	color: Qt.lighter(mainCanvas.mainColor, 1.5) // Bright shadow
		// 	z: -1
		// 	material: null
		// 	Rectangle {
		// 		z: 1
		// 		x: parent.material.x - 1
		// 		y: parent.material.y - 1
		// 		width: parent.material.width + 2
		// 		height: parent.material.height + 2
		// 		color: "transparent"
		// 		border.width: 1
		// 		border.color: "#ffffff"
		// 		visible: settings.showDebug
		// 	}
		// }

		// RectangularShadow {
		// 	anchors.fill: sourceItem
		// 	offset.x: -settings.offsetX
		// 	offset.y: -settings.offsetY
		// 	radius: settings.radius
		// 	blur: settings.blur
		// 	spread: settings.spread
		// 	opacity: settings.opacity
		// 	color: Qt.darker(mainCanvas.mainColor, 2.0) // Dark shadow
		// 	z: -2
		// 	material: null // Use the default material
		// 	Rectangle {
		// 		z: 1
		// 		x: parent.material.x - 1
		// 		y: parent.material.y - 1
		// 		width: parent.material.width + 2
		// 		height: parent.material.height + 2
		// 		color: "transparent"
		// 		border.width: 1
		// 		border.color: "#000000"
		// 		visible: settings.showDebug
		// 	}
		// }
	}
}
