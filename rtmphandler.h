#ifndef RTMPHANDLER_H
#define RTMPHANDLER_H

#include <QObject>
#include <QUrl>
#include <QProcess>

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

    QProcess rtmpGw;
    QString rtmpGwPath;
};

#endif // RTMPHANDLER_H
