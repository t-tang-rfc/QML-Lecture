// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

QtObject {
    id: rootItem

    property real objectSize: 200
    property real objectBlur: 40
    property real objectRadius: 40
    property real objectSpread: 0.0
    property real offsetX: -20
    property real offsetY: -20
    property real objectOpacity: 0.5
    property bool showDebug: false    

    function resetSettings() {
        objectSize = 200;
        objectBlur = 40;
        objectRadius = 40;
        objectSpread = 0.0;
        offsetX = -20;
        offsetY = -20;
        objectOpacity = 0.5;
        showDebug = false;
        settingsView.resetPosition(); // @todo: Fix this
    }
}
