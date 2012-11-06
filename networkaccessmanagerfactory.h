#ifndef NETWORKACCESSMANAGERFACTORY_H
#define NETWORKACCESSMANAGERFACTORY_H

#include <QDeclarativeNetworkAccessManagerFactory>

class NetworkAccessManagerFactory : public QDeclarativeNetworkAccessManagerFactory
{
    //Q_OBJECT
public:
    QNetworkAccessManager *create(QObject *parent);
    
signals:
    
public slots:
    
};

#endif // NETWORKACCESSMANAGERFACTORY_H
