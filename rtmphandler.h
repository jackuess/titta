#ifndef RTMPHANDLER_H
#define RTMPHANDLER_H

#include <QObject>
#include <QUrl>
#include <QProcess>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class RtmpHandler : public QObject
{
    Q_OBJECT
public:
    explicit RtmpHandler(QObject *parent = 0);
    ~RtmpHandler();
    
public slots:
    void play(const QUrl &url);
    
private:
    void installRtmpGw();
    void startRtmpGw(const QString &rtmpUrl);
    quint16 freePort();

    QProcess rtmpGw;
    QString rtmpGwPath;
    QString stdErrBuffer;
    QNetworkAccessManager *nam;

private slots:
    void rtmpGwError(QProcess::ProcessError error);
    void rtmpGwFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void readStdErr();
    void startPlayer();
    void onRtmpError(QNetworkReply::NetworkError error);
};

#endif // RTMPHANDLER_H
