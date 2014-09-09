/*==============================================================================

  Program: Gutenberg

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0.txt

==============================================================================*/

// Qt includes
#include <QCoreApplication>
#include <QDebug>
#include <QFile>
#include <QTextStream>
#include <QStringList>

// Self includes
#include "QFontIconParser.h"

int main(int argc, char* argv[])
{
  QCoreApplication app( argc, argv );

  // Check arguments
  QStringList arguments = app.arguments();
  if (arguments.size() != 3)
    {
    qCritical() << "There is an incorrect number of arguments.";
    qCritical() << "Usage: ";
    qCritical() << "  Gutenberger file1 file2";
    return EXIT_FAILURE;
    }

  // Parse icons of the input file
  QString input = arguments[1];
  QMap<QString, QString> nameToIcon;
  QFontIconParser parser(&app);

  if (!parser.load(input, nameToIcon))
    {
    qCritical() << "Error during the parsing.";
    return EXIT_FAILURE;
    }

  // Open and write output file
  QString output = arguments[2];
  QFile headerFile(output);
  if (!headerFile.open( QIODevice::WriteOnly | QIODevice::Text ))
    {
    qCritical() << "Cannot open file " << output << " for writing.";
    }
  QTextStream stream( &headerFile );

  stream << "/*=============================================================================="
    << "\n"
    << "Automatically generated by Gunterberger."
    << "\n"
    << "==============================================================================*/"
    << "\n"
    << "#ifndef __Gutenberg_H\n"
    << "#define __Gutenberg_H\n"
    << "\n"
    << "#include <QChar>\n"
    << "#include <QDebug>\n"
    << "#include <QString>\n"
    << "\n"
    << "class Gutenberg\n"
    << "{\n"
    << "public:\n"
    << "static QString unicodeFromIconName(QString name)\n"
    << "  {\n";
  QMap<QString, QString>::iterator it;
  for (it = nameToIcon.begin(); it != nameToIcon.end(); ++it)
    {
    stream << "    if (name == \"" << it.key() << "\")\n"
      << "      return \"" << it.value() << "\";\n";
    }

  stream << "\n"
    << "    qCritical() << \"Icon not found\";\n"
    << "    return \"\";\n"
    << "  };\n";

  stream << "\n"
    << "  static QChar icon(QString name)\n"
    << "  {\n"
    << "    QString unicode = Gutenberg::unicodeFromIconName(name);\n"
    << "    if (unicode.isEmpty())\n"
    << "      {\n"
    << "      return 0;\n"
    << "      }\n"
    << "\n"
    << "    bool ok;\n"
    << "    QChar icon = unicode.toInt(&ok, 16);\n"
    << "    if (!ok)\n"
    << "      {\n"
    << "      qCritical() << \"Error while converting: \" << unicode;\n"
    << "      return 0;\n"
    << "      }\n"
    << "    return icon;\n"
    << "  };\n"
    << "};\n"
    << "#endif\n"
    << "\n";

  headerFile.close();

  return EXIT_SUCCESS;
}
