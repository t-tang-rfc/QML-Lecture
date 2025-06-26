// @brief: A Neu-morphic Style Slider

import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Effects

Column {
	id: control
  
	property real sliderWidth: 100
	property color mainColor: "gray"

	property alias text: textItem.text	
	property alias from: slider.from
	property alias to: slider.to
	property alias value: slider.value

	signal moved

	spacing: 0

	Text {
		id: textItem
		text: "Label"
		font.pixelSize: 14
		color: "#e0e0e0"
		anchors.horizontalCenter: parent.horizontalCenter
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
			id: backgroundRect
			x: slider.leftPadding + slider.handlePadding
			y: slider.topPadding + slider.availableHeight / 2 - height / 2
			implicitWidth: 200
			implicitHeight: 4
			width: slider.availableWidth - slider.handlePadding * 2
			height: implicitHeight
			radius: 2
			color: Qt.lighter(control.mainColor, 0.3)
			Rectangle {
				id: progressRect
				width: slider.visualPosition * parent.width
				height: parent.height
				color: control.mainColor
				radius: 2
				RectangularShadow {
					anchors.fill: progressRect
					radius: height / 2
					color: Qt.lighter(control.mainColor, 1.2)					
					blur: slider.hovered || slider.pressed ? 12 : 8
					z: -1
				}
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
				RectangularShadow {
					anchors.fill: handleVisualItem
					anchors.margins: -2                    
					radius: width / 2
					color: Qt.lighter(control.mainColor, 1.2)
					blur: slider.hovered || slider.pressed ? 16 : 8
					z: -1
				}
			}
		}
	}
}
