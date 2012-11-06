#include <QDebug>

#include "tidynetworkaccessmanager.h"
#include "tidynetworkreply.h"

TidyNetworkAccessManager::TidyNetworkAccessManager(QObject *parent) :
    QNetworkAccessManager(parent)
{
}

QNetworkReply *TidyNetworkAccessManager::createRequest(Operation op, const QNetworkRequest &request, QIODevice *outgoingData) {
    if (op == QNetworkAccessManager::GetOperation && request.url().scheme() == "tidy") {
        QNetworkRequest newReq(request);
        newReq.url().setScheme("http://");
        QUrl newUrl = newReq.url();
        newUrl.setScheme("http");
        newReq.setUrl(newUrl);
        return new TidyNetworkReply(newReq, this);
    }
    else
        return QNetworkAccessManager::createRequest(op, request, outgoingData);
}
