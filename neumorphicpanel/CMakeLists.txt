# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
# @note: 
# - This program requires Qt 6.9 to build.
# - It also requires the Qt Quick Controls 2 module (@see https://doc.qt.io/qt-6/qtquickcontrols-index.html)

cmake_minimum_required(VERSION 3.16)
project(neumorphicpanel LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# @note: adjust the path to your Qt installation, or use symbolic link if necessary
list(APPEND CMAKE_PREFIX_PATH "/opt/qt/qt6/gcc_64/lib/cmake")
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.8)

add_subdirectory("./shared" "shared")

qt_add_executable(neumorphicpanelexample
	main.cpp
)

target_link_libraries(neumorphicpanelexample PRIVATE
	Qt6::Core
	Qt6::Gui
	Qt6::Qml
	Qt6::Quick
	Qt6::QuickControls2
)

add_dependencies(neumorphicpanelexample neumorphicpanel_shared)

# Resources:
qt_add_qml_module(neumorphicpanelexample
	URI neumorphicpanel
	QML_FILES
		"qml/main.qml"
		"qml/Settings.qml"
		"qml/SettingsView.qml"
		"qml/SettingsComponentSlider.qml"
		"qml/SettingsComponentButton.qml"
		"qml/CloudyRectMaterial/CloudyRectMaterial.qml"
	RESOURCES
		"qml/images/arrow.png"
		"qml/images/qt_logo_white_rgb.png"
		"qml/CloudyRectMaterial/cloudyrectmaterial.vert.qsb"
		"qml/CloudyRectMaterial/cloudyrectmaterial.frag.qsb"
)
