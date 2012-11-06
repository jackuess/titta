#ifndef TIDYNETWORKMANAGER_H
#define TIDYNETWORKMANAGER_H

#include <QNetworkAccessManager>

class TidyNetworkAccessManager : public QNetworkAccessManager
{
    Q_OBJECT
public:
    explicit TidyNetworkAccessManager(QObject *parent = 0);
    QNetworkReply *createRequest(Operation op, const QNetworkRequest &request, QIODevice *outgoingData);
};

#endif // TIDYNETWORKMANAGER_H
