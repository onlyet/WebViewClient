#pragma once

#include <QWebEngineView>

class QWidget;

class CWebEngineView : public QWebEngineView
{
    Q_OBJECT

public:
    CWebEngineView(QWidget* parent = nullptr);
    ~CWebEngineView();

protected:
    // ½â¾ö´íÎó£ºqt No RenderWidgetHost exists with id 10 in process 3
    virtual QWebEngineView* createWindow(QWebEnginePage::WebWindowType type);
};
