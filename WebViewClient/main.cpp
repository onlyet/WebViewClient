#include "MainWindow.h"
#include "GlobalConfig.h"

#include <dump.h>

#include <QApplication>
#include <qstatusbar.h>
#include <qdir.h>
#include <qdebug.h>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

#if 1
	Dump::Init(QString("%1/dump").arg(a.applicationDirPath()));
#endif

	if (!CONFIG.loadConfiguration(QCoreApplication::applicationDirPath() + "/Global.json"))
	{
		qDebug() << "?Ҳ??? Global.json";
		return -1;
	}

#if 0
	a.setWindowIcon(QIcon(":/momo1.ico"));
#endif

	QString title = CONFIG.mainWindowTitle();
	QString serverUrl = CONFIG.serverUrl();

    MainWindow w;
	w.setWindowTitle(title);

	qDebug() << QDir::currentPath();
	qDebug() << a.applicationDirPath();

	w.showMaximized();
    return a.exec();
}
