/*==============================================================================

  Program: Gutenberg

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0.txt

==============================================================================*/

// Self includes
#include "QFontIconParser.h"

// Qt includes
#include <QFile>
#include <QDebug>
#include <QStringList>

// STD includes
#include <sstream>

// Private class
//-----------------------------------------------------------------------------
class QFontIconParserPrivate
{
public:
  QString fileName;
  QMap<QString, QString> nameToIconMap;
};

// Public methods
//-----------------------------------------------------------------------------
QFontIconParser::QFontIconParser(QObject* parentObject, QString fileName)
  : QObject(parentObject)
  , d_ptr(new QFontIconParserPrivate)
{
  this->setFileName(fileName);
}

//-----------------------------------------------------------------------------
QFontIconParser::~QFontIconParser()
{
}

//-----------------------------------------------------------------------------
QString QFontIconParser::fileName() const
{
  Q_D(const QFontIconParser);
  return d->fileName;
}

//-----------------------------------------------------------------------------
bool QFontIconParser::load()
{
  Q_D(QFontIconParser);
  return this->load(d->fileName, d->nameToIconMap);
}

//-----------------------------------------------------------------------------
bool QFontIconParser::load(QString fileName, QMap<QString, QString>& map)
{
  QFile cssFile(fileName);
  if (!cssFile.open(QIODevice::ReadOnly))
    {
    qCritical() << "Cannot open file: " << fileName;
    return false;
    }

  map.clear();

  foreach(QString chunk, cssFile.readAll().split('}'))
    {
    QStringList names;
    QString content = "";
    foreach(QString line, chunk.split("\n"))
      {
      // Look for names
      if (line.contains(":before"))
        {
        QString withoutDot = line.right(line.length() -1);
        names << withoutDot.left(withoutDot.indexOf(":before"));
        }
      // Look for the content
      if (line.contains( "content: "))
        {
        int antislashIndex = line.indexOf('\\');
        QString newContent = line.mid(antislashIndex+1, 4);
        content = newContent;
        }
      }

    if (names.size() > 0 && content != "")
      {
      foreach(QString name, names)
        {
        map.insertMulti(name, content);
        }
      }
    }

  return true;
}

//-----------------------------------------------------------------------------
QChar QFontIconParser::icon(QString name) const
{
  Q_D(const QFontIconParser);
  if (d->nameToIconMap.contains(name))
    {
    QString unicode = d->nameToIconMap.value(name);

    bool ok;
    QChar icon = unicode.toInt(&ok, 16);
    if (!ok)
      {
      qCritical() << "Error while converting: " << unicode;
      return 0;
      }

    return icon; // implicit conversion to QString
    }
  return 0;
}

// Public slots
//-----------------------------------------------------------------------------
bool QFontIconParser::setFileName(const QString& name)
{
  Q_D(QFontIconParser);
  if (d->fileName == name)
    {
    return false;
    }

  d->fileName = name;
  return this->load();
}

