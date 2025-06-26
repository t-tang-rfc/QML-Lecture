// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic

Item {
	id: rootItem

	property bool show: true
	property color mainColor: "gray"
	property real sliderWidth: 270
	property real showAnimation: show ? 1 : 0

	width: 270 // default, can be overridden

	function resetPosition() {
		let lw = lightMouseArea.width
		let lh = lightMouseArea.height
		let sizeValue = sizeSlider.value - sizeSlider.from;
		let sizeRange = sizeSlider.to - sizeSlider.from;
		let lightX = lw * 0.4 - lw * 0.2 * (sizeValue) / (sizeRange)
		let lightY = lh * 0.4 - lh * 0.2 * (sizeValue) / (sizeRange)
		updatePosition(lightX, lightY)
	}

	function updatePosition(posX, posY) {
		let margin = 20;
		let halfW = (lightMouseArea.width - margin * 2) * 0.5;
		let halfH = (lightMouseArea.height - margin * 2) * 0.5;
		posX = Math.max(margin, posX);
		posY = Math.max(margin, posY);
		posX = Math.min(lightMouseArea.width - margin, posX);
		posY = Math.min(lightMouseArea.height - margin, posY);
		let dX = (posX - margin - halfW) / (halfW);
		let dY = (posY - margin - halfH) / (halfH);
		settings.offsetX = dX * 30;
		settings.offsetY = dY * 30;
		lightItem.x = posX;
		lightItem.y = posY;
	}

	Behavior on showAnimation {
		NumberAnimation {
			duration: 400
			easing.type: Easing.InOutQuad
		}
	}

	// Open/close button
	Item {
		width: 24
		height: 24
		anchors.left: parent.right
		anchors.leftMargin: 20
		anchors.top: parent.top
		anchors.topMargin: -10
		Rectangle {
			anchors.fill: parent
			color: Qt.lighter(rootItem.mainColor, 0.8)
			radius: 4
		}
		Image {
			anchors.centerIn: parent
			source: "images/arrow.png"
			rotation: rootItem.showAnimation * 180
		}
		MouseArea {
			anchors.fill: parent
			anchors.margins: -24
			onClicked: {
				rootItem.show = !rootItem.show;
			}
		}
	}

	// Background
	Rectangle {
		anchors.fill: scrollView
		opacity: showAnimation ? 1 : 0
		visible: opacity
		anchors.margins: -10
		color: Qt.lighter(rootItem.mainColor, 0.15)
		radius: 4
	}

	ScrollView {
		id: scrollView
		anchors.fill: parent
		ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
		ScrollBar.vertical.interactive: false
		clip: true

		Column {
			id: settingsArea
			anchors.fill: parent
			opacity: showAnimation
			visible: opacity
			spacing: 8

			/// An array of sliders
			SettingsComponentSlider {
				id: sizeSlider
				text: qsTr("Size") + ": " + value.toFixed()
				sliderWidth: rootItem.sliderWidth
				from: 100
				to: 300
				value: settings.itemSize				
				onMoved: {
					settings.itemSize = value
					settings.radius = Math.min(settings.radius, radiusSlider.to)
					settings.spread = Math.min(settings.spread, spreadSlider.to)
					settings.spread = Math.max(settings.spread, spreadSlider.from)
					settings.blur = value * 0.2
					resetPosition();
				}				
			}
			SettingsComponentSlider {
				id: radiusSlider
				text: qsTr("Radius") + ": " + value.toFixed()
				sliderWidth: rootItem.sliderWidth
				from: 0
				to: settings.itemSize * 0.5
				value: settings.radius				
				onMoved: {
					settings.radius = value
				}
			}
			SettingsComponentSlider {
				text: qsTr("Blur") + ": " + value.toFixed()
				sliderWidth: rootItem.sliderWidth
				from: 0
				to: 100
				value: settings.blur				
				onMoved: {
					settings.blur = value;
				}
			}
			SettingsComponentSlider {
				text: qsTr("Opacity") + ": " + value.toFixed(2)
				sliderWidth: rootItem.sliderWidth
				from: 0.0
				to: 1.0
				value: settings.opacity
				onMoved: {
					settings.opacity = value;
				}
			}
			SettingsComponentSlider {
				id: spreadSlider
				sliderWidth: rootItem.sliderWidth
				text: qsTr("Spread") + ": " + value.toFixed(2)				
				from: -settings.itemSize * 0.1
				to: settings.itemSize * 0.1
				value: settings.spread
				onMoved: {
					settings.spread = value;
				}
			}

			/// A 2D locator
			Text {
				anchors.horizontalCenter: parent.horizontalCenter
				color: "#e0e0e0"
				font.pixelSize: 14
				text: "Offset (" + settings.offsetX.toFixed(0) + ", " +
					  settings.offsetY.toFixed(0) + ")"
			}
			Rectangle {
				id: lightArea
				anchors.horizontalCenter: parent.horizontalCenter
				width: rootItem.width * 0.6
				height: width
				radius: 5
				color: Qt.lighter(rootItem.mainColor, 0.5)
				border.width: 1
				border.color: "#e0e0e0"
				Item {
					id: lightItem
					Rectangle {
						anchors.centerIn: parent
						width: 10
						height: width
						radius: width / 2
						color: "#e0e0e0"
						// RectangularShadow {
						// 	anchors.centerIn: parent
						// 	width: parent.width * 3.0
						// 	height: width
						// 	radius: width / 2
						// 	blur: width
						// 	color: "#fff9f0"
						// 	opacity: settings.opacity
						// }
					}
				}
				MouseArea {
					id: lightMouseArea
					anchors.fill: parent
					preventStealing: true
					Component.onCompleted: {
						resetPosition()
					}
					onPositionChanged:
						(mouse)=> {
							updatePosition(mouse.x, mouse.y);
						}
					onPressed:
						(mouse)=> {
							updatePosition(mouse.x, mouse.y);
						}
				}
			}
		}
	}
	Row {
		anchors.horizontalCenter: scrollView.horizontalCenter
		anchors.bottom: scrollView.bottom
		anchors.bottomMargin: 16
		spacing: 16
		SettingsComponentButton {
			id: debugButton
			text: "DEBUG"
			checkable: true
			buttonWidth: 100
			buttonHeight: 40
			checked: settings.showDebug
			onCheckedChanged: settings.showDebug = checked
		}
		SettingsComponentButton {
			id: resetButton
			text: "RESET"
			buttonWidth: 100
			buttonHeight: 40			
			onClicked: settings.resetSettings()
		}
	}
}
