#include "MainWindow.h"
#include "GlobalConfig.h"
#include <QApplication>
#include <qstatusbar.h>
#include <qdir.h>
#include <qdebug.h>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

	if (!CONFIG.loadConfiguration(QCoreApplication::applicationDirPath() + "/Global.json"))
	{
		return -1;
	}

	QString title = CONFIG.mainWindowTitle();
	QString serverUrl = CONFIG.serverUrl();

    MainWindow w;
	w.setWindowTitle(title);

	qDebug() << QDir::currentPath();
	qDebug() << a.applicationDirPath();

	w.showMaximized();
    return a.exec();
}
