#include <QApplication>
#include <QDeclarativeEngine>
#include <QDebug>
#include <QDesktopServices>

#include "qmlapplicationviewer.h"
#include "networkaccessmanagerfactory.h"
#include "rtmphandler.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

#ifdef Q_OS_ANDROID
    QFont roboto = QFont("Roboto");
    app->setFont(roboto);
#endif

    RtmpHandler handler;
    QDesktopServices::setUrlHandler("rtmp", &handler, "play");
    QDesktopServices::setUrlHandler("rtmpe", &handler, "play");

    QmlApplicationViewer viewer;
    NetworkAccessManagerFactory namf;

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.engine()->setNetworkAccessManagerFactory(&namf);
    viewer.setMainQmlFile(QLatin1String("qml/titta/main.qml"));
    viewer.showExpanded();
#ifndef Q_OS_ANDROID
    viewer.resize(320, 480);
#endif

    return app->exec();
}
