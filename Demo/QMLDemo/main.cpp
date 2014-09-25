/*==============================================================================

  Program: Gutenberg

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0.txt

==============================================================================*/

// Qt includes
#include <QApplication>
#include <QDebug>
#include <QFontDatabase>
#include <QLabel>

#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeContext>

// Self includes
#include "GutenbergQMLTest.h"

int main(int argc, char* argv[])
{
  QApplication app( argc, argv );

  QDeclarativeView qmlView;
  qmlView.rootContext()->setContextProperty("QMLTest", &app);
  qmlView.setResizeMode(QDeclarativeView::SizeRootObjectToView);
  qmlView.setMinimumSize(QSize(300, 300));
  qmlView.setSource(QUrl("qrc:/QMLDemo.qml"));

  qmlView.show();
  return app.exec();
}
