#include <QApplication>
#include <QDeclarativeEngine>
#include <QDebug>
#include <QDesktopServices>
#include <QMessageBox>
#include <QDesktopWidget>
#include <QSettings>

#include "qmlapplicationviewer.h"
#include "networkaccessmanagerfactory.h"
#include "rtmphandler.h"

void show_vlc_message() {
    QDesktopWidget *win = new QDesktopWidget();

    QMessageBox message(QMessageBox::Information, "Videouppspelning",
                        QString::fromUtf8("Titta behöver en videospelare som klarar att spela upp Flv-filmer. För bästa resultat rekommenderas <em>Vlc for Android</em>. Vlc kan installeras gratis via Google-play. Ignorera detta meddelande om du har Vlc installerat."),
                        QMessageBox::NoButton);

#ifdef Q_OS_ANDROID
    message.setStyleSheet("QMessageBox { border: 1px solid #373A3D } QMessageBox, QPushButton { font-size: 16px }");
#endif

    QPushButton *openPlayButton = message.addButton(QString::fromUtf8("Installera Vlc via Google-play"), QMessageBox::ActionRole);
    message.addButton(QMessageBox::Ok);
    message.show();
    message.move( win->width() / 2 - message.width() / 2, win->height() / 2 - message.height() / 2 );
    message.exec();

    if (message.clickedButton() == (QAbstractButton*)openPlayButton)
        QDesktopServices::openUrl(QUrl("https://play.google.com/store/apps/details?id=org.videolan.vlc.betav7neon"));
}

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    app->setOrganizationName("wrutschkow");
    app->setOrganizationDomain("wrutschkow.org");
    app->setApplicationName("Titta");

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


    QSettings settings;
    if (!settings.value("beenRun", QVariant(false)).toBool())
        show_vlc_message();
    settings.setValue("beenRun", QVariant(true));

    return app->exec();
}
