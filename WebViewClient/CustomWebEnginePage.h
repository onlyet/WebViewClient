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
    // 关闭HTTPS验证
    virtual bool certificateError(const QWebEngineCertificateError& certificateError);

private Q_SLOTS:
	// 获取音频和视频捕获的权限，解决不能录音的bug
	void onFeaturePermissionRequested(const QUrl &securityOrigin, QWebEnginePage::Feature feature);

};

#endif // CUSTOMWEBENGINEPAGE_H
