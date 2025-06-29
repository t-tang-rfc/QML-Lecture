/**
 * @file Main.qml
 * @brief Main QML file for the Neumorphic Panel Example
 * @author t-tang-rfc
 * @date 2025-06-26
 *
 * @details
 * This file demonstrates a simple neumorphic panel using Qt Quick.
 * It includes a side panel with settings and a main canvas area.
 *
 * @note
 * This example is adapted from a [Qt Example](https://doc.qt.io/qt-6/qtquick-multieffect-neumorphicpanel-example.html)
 * But it is heavily modified to enhance syntax correctness and structure clearness.
*/

import QtQuick
import QtQuick.Window
import QtQuick.Effects

Window {
	id: mainWindow
	visible: true
	width: 1280
	height: 720
	title: "QML Neumorphic Panel Example"

	Rectangle {
		id: mainCanvas

		property color mainColor: "#b0b0b0"

		anchors.fill: parent
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

		/// Primary (left) Side Bar
		SettingPanel {
			id: settings
			visible: true
			width: 270
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.topMargin: 20
			anchors.bottomMargin: 20
			x: -(width + 30) * (1 - this.showAnimation) + 20 // Slides in/out effect
		}

		/// Main Canvas Area
		Item {
			id: mainArea
			anchors.left: settings.right
			anchors.right: parent.right
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			Rectangle {
				id: sourceItem
				anchors.centerIn: parent
				height: settings.objectSize
				width: height * 2
				radius: settings.objectRadius
				gradient: Gradient {
					id: gradient
					property real lightLevelUp: 1.05 - settings.offsetY * 0.004 * settings.objectOpacity
					property real lightLevelDown: 1.05 + settings.offsetY * 0.004 * settings.objectOpacity
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
					width: parent.width * 0.6
					height: width * 0.6
					source: "images/logo.png" // image size: 500x300
					opacity: 0.3
				}
			}

			RectangularShadow {
				anchors.fill: sourceItem
				offset.x: settings.offsetX
				offset.y: settings.offsetY
				radius: settings.objectRadius
				color: Qt.lighter(mainCanvas.mainColor, 1.5) // Bright shadow
				opacity: settings.objectOpacity
				spread: settings.objectSpread
				blur: settings.objectBlur
				z: -1
				material: null
				Rectangle {
					z: 1
					x: parent.material.x - 1
					y: parent.material.y - 1
					width: parent.material.width + 2
					height: parent.material.height + 2
					color: "transparent"
					border.width: 1
					border.color: "#ffffff"
					visible: settings.showDebug
				}
			}

			RectangularShadow {
				anchors.fill: sourceItem
				offset.x: -settings.offsetX
				offset.y: -settings.offsetY
				radius: settings.objectRadius
				color: Qt.darker(mainCanvas.mainColor, 2.0) // Dark shadow
				opacity: settings.objectOpacity
				spread: settings.objectSpread
				blur: settings.objectBlur
				z: -2
				material: null // Use the default material
				Rectangle {
					z: 1
					x: parent.material.x - 1
					y: parent.material.y - 1
					width: parent.material.width + 2
					height: parent.material.height + 2
					color: "transparent"
					border.width: 1
					border.color: "#000000"
					visible: settings.showDebug
				}
			}
		}
	}

	// Center the window on the screen
	Component.onCompleted: {
		x = (Screen.width - width) / 2
		y = (Screen.height - height) / 2
	}
}
