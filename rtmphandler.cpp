#include "rtmphandler.h"
#include <QDebug>
#include <QDesktopServices>
#include <QDir>
//#include <QProcess>

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
}

RtmpHandler::~RtmpHandler() {
    this->rtmpGw.kill();
}

void RtmpHandler::play(const QUrl &url) {
#ifdef Q_OS_ANDROID
    QString cmd = this->rtmpGwPath;
    cmd += " -g 8080 -r \"";
    cmd += url.toString();
    cmd.replace(" playpath=", "\" -y \"");
    cmd.replace(" swfVfy=1", "");
    cmd.replace(" swfUrl=", "\" -W \"");
    cmd.replace(" app=", "\" -a \"");
    cmd.replace(" live=", "\" -v \"");

    if (this->rtmpGw.state() != QProcess::NotRunning) {
        this->rtmpGw.kill();
        this->rtmpGw.waitForFinished();
    }
    this->rtmpGw.start(cmd);

    QDesktopServices::openUrl(QUrl("http://0.0.0.0:8080"));
#else
    QProcess::startDetached("ffplay \"" + url.toString() + "\"");
    //QProcess::startDetached("mplayer http://0.0.0.0:8080");
#endif
}

void RtmpHandler::installRtmpGw() {
    if (QFile::copy("assets:/rtmpgw", this->rtmpGwPath))
        QFile::setPermissions(this->rtmpGwPath, QFile::ExeOwner | QFile::ReadOwner);
}
