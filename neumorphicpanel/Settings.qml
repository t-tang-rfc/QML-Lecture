// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

QtObject {
    id: rootItem

    property real itemSize: 200
    property real blur: 40
    property real radius: 40
    property real spread: 0.0
    property real offsetX: -20
    property real offsetY: -20
    property real objectOpacity: 0.5
    property bool showDebug: false    

    function resetSettings() {
        itemSize = 200;
        blur = 40;
        radius = 40;
        spread = 0.0;
        offsetX = -20;
        offsetY = -20;
        objectOpacity = 0.5;
        showDebug = false;
        settingsView.resetPosition(); // @todo: Fix this
    }
}
