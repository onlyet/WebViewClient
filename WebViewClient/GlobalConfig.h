#pragma once
#include <QVariant>
#include <QMap>
#include "QMutex"

#include "Singleton.h"

#define CONFIG GlobalConfiguration::Instance()

//class QProcess;
class GlobalConfiguration : public QObject, public Singleton<GlobalConfiguration>
{
	Q_OBJECT

public:
	bool loadConfiguration(const QString &path);
	QString serverUrl() const;
	QString mainWindowTitle() const;

private:
	friend Singleton<GlobalConfiguration>;
	explicit GlobalConfiguration(QObject *parent = nullptr);
	~GlobalConfiguration();

private:
	QString m_path;
	QVariant m_config;
};
