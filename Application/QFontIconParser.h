/*==============================================================================

  Program: Gutenberg

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0.txt

==============================================================================*/

#ifndef __QFontIconParser_h
#define __QFontIconParser_h

// Qt includes
#include <QObject>
#include <QMap>
#include <QFont>

class QFontIconParserPrivate;
/// TO DO

class QFontIconParser : public QObject
{
  Q_OBJECT

public:
  QFontIconParser(QObject *parent=0, QString fileName = "");
  virtual ~QFontIconParser();

  QString fileName() const;

  bool load();
  bool load(QString filename, QMap<QString, QString>& map);

  QChar icon(QString name) const;

public slots:
  bool setFileName(const QString& name);

protected:
  QScopedPointer<QFontIconParserPrivate> d_ptr;

private:
  Q_DECLARE_PRIVATE(QFontIconParser);
  Q_DISABLE_COPY(QFontIconParser);
};

#endif
