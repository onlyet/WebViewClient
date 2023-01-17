#pragma once

#ifndef CUSTOMWEBENGINEPAGE_H
#define CUSTOMWEBENGINEPAGE_H

#include <QWebEnginePage>

class CustomWebEnginePage : public QWebEnginePage
{
	Q_OBJECT

public:
	CustomWebEnginePage(QObject *parent = Q_NULLPTR);

protected:
    // �ر�HTTPS��֤
    virtual bool certificateError(const QWebEngineCertificateError& certificateError);

private Q_SLOTS:
	// ��ȡ��Ƶ����Ƶ�����Ȩ�ޣ��������¼����bug
	void onFeaturePermissionRequested(const QUrl &securityOrigin, QWebEnginePage::Feature feature);

};

#endif // CUSTOMWEBENGINEPAGE_H
