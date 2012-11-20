#include "rtmphandler.h"
#include <QDebug>
#include <QDesktopServices>
#include <QDir>
#include <QMessageBox>
#include <QApplication>
#include <QNetworkRequest>
#include <QFile>
#include <QTcpServer>
#include <QRegExp>

RtmpHandler::RtmpHandler(QObject *parent) :
    QObject(parent)
{
#ifdef Q_OS_ANDROID
    QDir dataDir(QDesktopServices::storageLocation(QDesktopServices::DataLocation));
    this->rtmpGwPath = dataDir.absoluteFilePath("rtmpgw");
    this->installRtmpGw();
#else
    this->rtmpGwPath = "rtmpgw";
#endif

    this->nam = new QNetworkAccessManager(this);

    connect(&this->rtmpGw, SIGNAL(error(QProcess::ProcessError)), SLOT(rtmpGwError(QProcess::ProcessError)));
    connect(&this->rtmpGw, SIGNAL(finished(int,QProcess::ExitStatus)), SLOT(rtmpGwFinished(int,QProcess::ExitStatus)));
    connect(&this->rtmpGw, SIGNAL(readyReadStandardError()), SLOT(readStdErr()));
}

RtmpHandler::~RtmpHandler() {
    this->rtmpGw.kill();
}

void RtmpHandler::play(const QUrl &url) {
    this->startRtmpGw(url.toString());
}

void RtmpHandler::installRtmpGw() {
    if (QFile::copy("assets:/rtmpgw", this->rtmpGwPath))
        QFile::setPermissions(this->rtmpGwPath, QFile::ExeOwner | QFile::ReadOwner);
}

void RtmpHandler::startRtmpGw(const QString &rtmpUrl) {
    quint16 port = this->freePort();
    QString cmd = this->rtmpGwPath;
    cmd += " -g %0 -r \"";
    cmd = cmd.arg(port);
    cmd += rtmpUrl;
    cmd.replace(" playpath=", "\" -y \"");
    cmd.replace(" swfVfy=1", "");
    cmd.replace(" swfUrl=", "\" -W \"");
    cmd.replace(" app=", "\" -a \"");
    cmd.replace(" live=", "\" -v \"");

    //cmd = this->rtmpGwPath + " -r rtmp://bajs -g " + port;

    if (this->rtmpGw.state() != QProcess::NotRunning) {
        this->rtmpGw.kill();
        this->rtmpGw.waitForFinished();
    }
    this->rtmpGw.start(cmd);
}

void RtmpHandler::rtmpGwError(QProcess::ProcessError error) {
    qDebug() << "RtmpGw error" << error;
}

void RtmpHandler::rtmpGwFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    qDebug() << "RtmpGw exited (exit code, exit status)" << exitCode << exitStatus;
}

void RtmpHandler::readStdErr() {
    QByteArray stdErr = this->rtmpGw.readAllStandardError();
    //qDebug() << stdErr;
    this->stdErrBuffer += stdErr;

    QRegExp rx("Streaming on http://([^:]+):(\\d+)");
    int pos = this->stdErrBuffer.lastIndexOf(rx);//"Streaming on http://0.0.0.0:");
    if (pos > -1) {
        QNetworkReply *reply = this->nam->get(QNetworkRequest(QUrl("http://" + rx.cap(1) + ":" + rx.cap(2))));

        connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), SLOT(onRtmpError(QNetworkReply::NetworkError)));
        connect(reply, SIGNAL(readyRead()), SLOT(startPlayer()));
        this->stdErrBuffer = "";
        return;
    }

    pos = this->stdErrBuffer.lastIndexOf("ERROR:");
//    if (pos > -1 && QApplication::topLevelWidgets().count() < 2) {
//        QApplication::activeWindow()->setStyleSheet("QDialog{ font-size: 24px }");
//        QMessageBox::information(QApplication::activeWindow(), "Videouppspelning", "Kunde inte spela upp videon");

//        this->stdErrBuffer = "";
//        return;
//    }
}

void RtmpHandler::onRtmpError(QNetworkReply::NetworkError error) {
    qDebug() << "Rtmp Error" << error;
}

void RtmpHandler::startPlayer() {
    qDebug() << "Start Player";
    QNetworkReply *reply = (QNetworkReply*)QObject::sender();
    QString url = reply->url().toString();
    reply->deleteLater();

#ifdef Q_OS_ANDROID
    //am start -a android.intent.action.VIEW -d http://localhost:8080 -t video/flv
    QDesktopServices::openUrl(QUrl(url + "/test.flv"));
#else
    QProcess::startDetached("mplayer " + url);
#endif
}

quint16 RtmpHandler::freePort() {
    QTcpServer dummyServer;
    dummyServer.listen(QHostAddress::Any, 0);
    return dummyServer.serverPort();
}
