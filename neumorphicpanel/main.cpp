// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlFileSelector>

int main(int argc, char* argv[])
{
	QGuiApplication app(argc,argv);

	QQuickView view;
	view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
	new QQmlFileSelector(view.engine(), &view);
	view.setSource(QUrl("qrc:/qt/qml/neumorphicpanel/qml/main.qml"));
	if (view.status() == QQuickView::Error) {
		qWarning() << "Error loading QML file:" << view.errors();
		return -1;
	}
	view.setResizeMode(QQuickView::SizeRootObjectToView);
	view.show();
	return app.exec();
}
