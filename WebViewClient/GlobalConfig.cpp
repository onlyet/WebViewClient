#include "GlobalConfig.h"
#include <qfile.h>
#include <qjsondocument.h>

QString GlobalConfiguration::serverUrl() const
{
	return m_config.toMap()["serverUrl"].toString();
}

QString GlobalConfiguration::mainWindowTitle() const
{
	return m_config.toMap()["mainWindowTitle"].toString();
}

GlobalConfiguration::GlobalConfiguration(QObject *parent/* = nullptr*/)
	: QObject(parent)
{
}

GlobalConfiguration::~GlobalConfiguration()
{
}

bool GlobalConfiguration::loadConfiguration(const QString & path)
{
	QFile file(path);
	if (!file.open(QIODevice::ReadOnly))
	{
		return false;
	}

	QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
	file.close();
	m_path = path;
	m_config = doc.toVariant();
	return true;
}
