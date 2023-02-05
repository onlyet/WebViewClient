#include "MainWindow.h"
#include "ui_MainWindow.h"
#include "GlobalConfig.h"
#include "CustomWebEnginePage.h"
#include "CWebEngineView.h"

#include <QWebEngineView>
//#include <QDesktopWidget>
#include <QScreen>
#include <qlabel.h>
#include <qstatusbar.h>
#include <qtimer.h>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    , m_webView(nullptr)
    //, m_timeLabel(nullptr)
{
    ui->setupUi(this);

    m_webView = new CWebEngineView();
	m_webView->setPage(new CustomWebEnginePage());
	//m_webView->setFixedSize(QApplication::desktop()->availableGeometry().width(), QApplication::desktop()->availableGeometry().height() - 40);
	m_webView->setFixedSize(QApplication::primaryScreen()->availableGeometry().width(), QApplication::primaryScreen()->availableGeometry().height() - 40);

	QString url = CONFIG.serverUrl();
	//m_webView->load(QString("https://www.baidu.com"));
	m_webView->load(url);
    m_webView->show();

	//m_timeLabel = new QLabel();
	//m_timeLabel->setFixedSize(QApplication::desktop()->availableGeometry().width(), 40);
	//m_timeLabel->setText("hello world");
	//m_timeLabel->setFrameShape(QFrame::Box);

	ui->mainLayout->addWidget(m_webView);
	//ui->mainLayout->addWidget(m_timeLabel);

	refreshDateTime();
	// 打开定时器
	QTimer *pTimer = new QTimer(this);
	connect(pTimer, &QTimer::timeout, this, &MainWindow::onSetTime);
	pTimer->start(1000);

#if 0
	QTimer::singleShot(5 * 1000, []() {
		int* bug = nullptr;
		*bug = 3;
	});
#endif
}

MainWindow::~MainWindow()
{
	delete m_webView;
	m_webView = nullptr;
	delete ui;
}

void MainWindow::refreshDateTime()
{
	QDateTime cdt = QDateTime::currentDateTime();
	QString time = cdt.toString("yyyy-MM-dd hh:mm:ss");
	ui->statusBar->showMessage(time);
}

void MainWindow::onSetTime()
{
	refreshDateTime();
}
