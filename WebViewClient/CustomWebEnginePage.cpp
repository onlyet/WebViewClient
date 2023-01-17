#include "customwebenginepage.h"

CustomWebEnginePage::CustomWebEnginePage(QObject *parent/* = Q_NULLPTR*/)
	: QWebEnginePage(parent)
{
	connect(this, &CustomWebEnginePage::featurePermissionRequested, this, &CustomWebEnginePage::onFeaturePermissionRequested);
}

bool CustomWebEnginePage::certificateError(const QWebEngineCertificateError &certificateError)
{
	return true;
}

void CustomWebEnginePage::onFeaturePermissionRequested(const QUrl &securityOrigin, QWebEnginePage::Feature feature)
{
	if (feature == QWebEnginePage::MediaAudioCapture
		|| feature == QWebEnginePage::MediaVideoCapture
		|| feature == QWebEnginePage::MediaAudioVideoCapture)
		setFeaturePermission(securityOrigin, feature, QWebEnginePage::PermissionGrantedByUser);
	else
		setFeaturePermission(securityOrigin, feature, QWebEnginePage::PermissionDeniedByUser);
}

