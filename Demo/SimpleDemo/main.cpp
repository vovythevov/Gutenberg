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

// Self includes
#include "GutenbergTest.h"

int main(int argc, char* argv[])
{
  QApplication app( argc, argv );

  QFontDatabase::addApplicationFont(":/test.ttf");

  QFont font;
  font.fromString("FontAwesome");
  font.setPointSize(100);

  QLabel label;
  label.setFont( font );
  label.setText(Gutenberg::icon("fa-sheqel"));

  label.show();
  return app.exec();
}
