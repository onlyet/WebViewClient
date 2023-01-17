#include "CWebEngineView.h"

#include <QWidget>

CWebEngineView::CWebEngineView(QWidget* parent)
    : QWebEngineView(parent)
{
}

CWebEngineView::~CWebEngineView()
{
}

QWebEngineView* CWebEngineView::createWindow(QWebEnginePage::WebWindowType type)
{
    if (type == QWebEnginePage::WebBrowserTab)
    {
        QWebEnginePage* new_page = new QWebEnginePage(this->page()->profile(), this);
        this->setPage(new_page);
    }

    return this;
}