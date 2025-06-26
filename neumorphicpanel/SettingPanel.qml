/**
 * @brief: A Setting Panel
 */

import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic

Item {
	id: rootItem

	/* === Visual Properties === */
	property bool show: true
	property color mainColor: "gray"
	property real sliderWidth: 270
	property real showAnimation: show ? 1 : 0

	width: 270 // default, can be overridden

	/* === Control Properties ===*/
	property real objectSize: 200
	property real objectBlur: 40
	property real objectRadius: 40
	property real objectSpread: 0.0
	property real offsetX: -20
	property real offsetY: -20
	property real objectOpacity: 0.5
	property bool showDebug: false

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
		rootItem.offsetX = dX * 30;
		rootItem.offsetY = dY * 30;
		lightItem.x = posX;
		lightItem.y = posY;
	}

	function resetPosition() {
		let lw = lightMouseArea.width
		let lh = lightMouseArea.height
		let sizeValue = sizeSlider.value - sizeSlider.from;
		let sizeRange = sizeSlider.to - sizeSlider.from;
		let lightX = lw * 0.4 - lw * 0.2 * (sizeValue) / (sizeRange)
		let lightY = lh * 0.4 - lh * 0.2 * (sizeValue) / (sizeRange)
		updatePosition(lightX, lightY)
	}

	function resetSettings() {
		objectSize = 200;
		objectBlur = 40;
		objectRadius = 40;
		objectSpread = 0.0;
		offsetX = -20;
		offsetY = -20;
		objectOpacity = 0.5;
		showDebug = false;
		resetPosition();
	}

	Behavior on showAnimation {
		NumberAnimation {
			duration: 400
			easing.type: Easing.InOutQuad
		}
	}

	/* === Child Objects ===*/	

	/// Open/close button
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

	/// Side Bar

	// Background
	Rectangle {
		anchors.fill: scrollView
		anchors.margins: -10
		color: Qt.lighter(rootItem.mainColor, 0.15)
		radius: 4
	}

	// An array of sliders
	ScrollView {
		id: scrollView
		anchors.fill: parent
		ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
		ScrollBar.vertical.interactive: false
		clip: true

		Column {
			id: settingsArea
			anchors.fill: parent
			spacing: 8

			SettingsComponentSlider {
				id: sizeSlider
				text: qsTr("Size") + ": " + value.toFixed()
				sliderWidth: rootItem.sliderWidth
				from: 100
				to: 300
				value: rootItem.objectSize				
				onMoved: {
					rootItem.objectSize = value
					rootItem.objectRadius = Math.min(rootItem.objectRadius, radiusSlider.to)
					rootItem.objectRadius = Math.max(rootItem.objectRadius, radiusSlider.from)
					rootItem.objectSpread = Math.min(rootItem.objectSpread, spreadSlider.to)
					rootItem.objectSpread = Math.max(rootItem.objectSpread, spreadSlider.from)
					rootItem.objectBlur = value * 0.2
					rootItem.resetPosition();
				}				
			}
			SettingsComponentSlider {
				id: radiusSlider
				text: qsTr("Radius") + ": " + value.toFixed()
				sliderWidth: rootItem.sliderWidth
				from: 0
				to: rootItem.objectSize * 0.5
				value: rootItem.objectRadius				
				onMoved: {
					rootItem.objectRadius = value
				}
			}
			SettingsComponentSlider {
				text: qsTr("Blur") + ": " + value.toFixed()
				sliderWidth: rootItem.sliderWidth
				from: 0
				to: 100
				value: rootItem.objectBlur				
				onMoved: {
					rootItem.objectBlur = value;
				}
			}
			SettingsComponentSlider {
				text: qsTr("Opacity") + ": " + value.toFixed(2)
				sliderWidth: rootItem.sliderWidth
				from: 0.0
				to: 1.0
				value: rootItem.objectOpacity
				onMoved: {
					rootItem.objectOpacity = value;
				}
			}
			SettingsComponentSlider {
				id: spreadSlider
				sliderWidth: rootItem.sliderWidth
				text: qsTr("Spread") + ": " + value.toFixed(2)				
				from: -rootItem.objectSize * 0.1
				to: rootItem.objectSize * 0.1
				value: rootItem.objectSpread
				onMoved: {
					rootItem.objectSpread = value;
				}
			}

			/// A 2D locator
			Text {
				anchors.horizontalCenter: parent.horizontalCenter
				color: "#e0e0e0"
				font.pixelSize: 14
				text: "Offset (" + rootItem.offsetX.toFixed(0) + ", " +
					  rootItem.offsetY.toFixed(0) + ")"
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
						id: lightBackground
						anchors.centerIn: parent
						width: 10
						height: width
						radius: width / 2
						color: "#e0e0e0"
						RectangularShadow {
							anchors.centerIn: lightBackground
							width: parent.width * 3.0
							height: width
							radius: width / 2
							color: "#fff9f0"
							opacity: rootItem.objectOpacity
							blur: width
						}
					}
				}
				MouseArea {
					id: lightMouseArea
					anchors.fill: parent
					preventStealing: true
					Component.onCompleted: {
						rootItem.resetPosition()
					}
					onPositionChanged:
						(mouse)=> {
							rootItem.updatePosition(mouse.x, mouse.y);
						}
					onPressed:
						(mouse)=> {
							rootItem.updatePosition(mouse.x, mouse.y);
						}
				}
			}
		}
	}

	// Button group
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
			checked: rootItem.showDebug
			onCheckedChanged: rootItem.showDebug = checked
		}
		SettingsComponentButton {
			id: resetButton
			text: "RESET"
			buttonWidth: 100
			buttonHeight: 40			
			onClicked: rootItem.resetSettings()
		}
	}
}
