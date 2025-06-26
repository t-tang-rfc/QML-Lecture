/**
	@brief: A modern dashboard card with a gradient background, circular progress indicator, and animated button.
	@note: This code is created by GPT 4.1 agent
*/

import QtQuick

Rectangle {
	width: 500; height: 350
	color: "#232946"
	radius: 20
	anchors.centerIn: parent

	// Card with gradient background
	Rectangle {
		id: card
		width: 400; height: 250
		anchors.centerIn: parent
		radius: 18
		border.color: "#eebbc3"
		border.width: 2
		gradient: Gradient {
			GradientStop { position: 0.0; color: "#fffffe" }
			GradientStop { position: 1.0; color: "#eebbc3" }
		}
		// Title
		Text {
			text: "QML Modern Dashboard"
			font.pixelSize: 28
			font.bold: true
			color: "#232946"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin: 24
		}
		// Circular Progress
		Canvas {
			id: progressCanvas
			width: 100; height: 100
			anchors.left: parent.left
			anchors.leftMargin: 32
			anchors.verticalCenter: parent.verticalCenter
			property real progress: 0.0
			property bool animating: true
			onPaint: {
				var ctx = getContext("2d");
				ctx.clearRect(0, 0, width, height);
				ctx.lineWidth = 12;
				ctx.strokeStyle = "#eebbc3";
				ctx.beginPath();
				ctx.arc(width/2, height/2, 40, 0, 2*Math.PI);
				ctx.stroke();
				ctx.strokeStyle = "#232946";
				ctx.beginPath();
				ctx.arc(width/2, height/2, 40, -Math.PI/2, 2*Math.PI*progress - Math.PI/2);
				ctx.stroke();
			}
			Connections {
				target: progressCanvas
				function onProgressChanged() { progressCanvas.requestPaint(); }
			}
			SequentialAnimation {
				id: progressAnim
				running: progressCanvas.animating
				NumberAnimation { target: progressCanvas; property: "progress"; from: 0; to: 1.0; duration: 1200; easing.type: Easing.OutCubic }
				onStopped: progressCanvas.animating = false
			}
		}
		// Animated Button
		Rectangle {
			id: animBtn
			width: 120; height: 44
			radius: 22
			color: animBtnMouse.pressed ? "#232946" : "#eebbc3"
			border.color: "#232946"
			border.width: 2
			anchors.right: parent.right
			anchors.rightMargin: 32
			anchors.verticalCenter: parent.verticalCenter
			scale: animBtnMouse.pressed ? 1.1 : 1.0
			Behavior on color { ColorAnimation { duration: 200 } }
			Behavior on scale { NumberAnimation { duration: 120 } }
			MouseArea {
				id: animBtnMouse
				anchors.fill: parent
				onClicked: {
					if (!progressCanvas.animating) {
						progressCanvas.progress = 0;
						progressCanvas.animating = true;
					}
				}
			}
			Text {
				text: "Click Me!"
				anchors.centerIn: parent
				color: animBtnMouse.pressed ? "#eebbc3" : "#232946"
				font.pixelSize: 20
				font.bold: true
			}
		}
		// Subtitle
		Text {
			text: "Animated, beautiful, and interactive!"
			font.pixelSize: 16
			color: "#393d4a"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 18
		}
	}
}
