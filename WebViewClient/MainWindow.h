#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class QWebEngineView;
class QLabel;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:
	void onSetTime();

protected:
	void refreshDateTime();

private:
    Ui::MainWindow	*ui;
    QWebEngineView	*m_webView;
	QLabel		    *m_timeLabel;

};
#endif // MAINWINDOW_H
