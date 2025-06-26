# QML-Lecture

- `hello-world`: demonstrate basic UI creation in QML and simple interaction
- `neumorphic-panel`: showcase visual effects in QML using shadows, and demonstrate the modular design with QML.
- `joystick-robot-sim`: demonstrate QML/C++ integration and Qt Quick 3D usage.

## Hello World Example

The example `hello-world` is a simple pure QML application that demonstrates how to:
1. create a window and visual contents
2. build interaction between components
3. add transition effects

## NeumorphicPanel Example

The `neumorphic-panel` example showcases creating shadow effects in QML.
It is adopted from an official Qt example [3].
Note, the feature `RectangularShadow` is introduced in Qt 6.9, so ensure you have the correct version of Qt to build this example.
It also requires the Qt Quick Controls 2 module (see https://doc.qt.io/qt-6/qtquickcontrols-index.html).

## Simple Dashboard Example

The `simple-dashboard` example is an AI agent generated QML application to show how to create such a GUI using declarative way.

+++ agent mode programming
prompt:
Hi, I am planning to introduce Qt Quick with QML for GUI design for my colleagues (basically we are currently using the tractional QWidget based way), could be provide some interesting example that have attractive looking that I can showcase? (you know the QWidget is a little bit dumb w/o carefully tweaking)"

response:
Here’s an attractive example you can showcase: a simple animated dashboard with a circular progress indicator, a glowing button, and a modern card layout. This will demonstrate QML’s strengths in animation, gradients, and custom shapes.
+++

## Joystick Robot Simulator Example

The `joystick-robot-sim` example demonstrates how to QML/C++ integration.
Also it shows how to use Qt Quick 3D to create a simple robot simulator.

## References

1. [QML Syntax Basics](https://doc.qt.io/qt-6/qtqml-syntax-basics.html)
2. [QML Tutorial](https://doc.qt.io/qt-6/qml-tutorial1.html)
3. [Qt Quick Example](https://doc.qt.io/qt-6/qtquick-multieffect-neumorphicpanel-example.html)
4. [QML/C++ Integration](https://doc.qt.io/qt-6/qtqml-cppintegration-overview.html)
