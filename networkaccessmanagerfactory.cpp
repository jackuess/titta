#include "networkaccessmanagerfactory.h"

#include "tidynetworkaccessmanager.h"

//NetworkAccessManagerFactory::NetworkAccessManagerFactory(QObject *parent) :
//    QDeclarativeNetworkAccessManagerFactory()
//{
//}

QNetworkAccessManager *NetworkAccessManagerFactory::create(QObject *parent) {
    return new TidyNetworkAccessManager(parent);
}
