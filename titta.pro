QMAKE_CXXFLAGS += -std=gnu++0x

QT       += core gui
QT       += network

QT_PLUGIN += qsvg

android {
    LIBS += -L"/home/chucky/src/tidy-html5-android/libs/armeabi"
}

LIBS += -L/usr/lib/ -ltidy

#INCLUDEPATH += /usr/include

# Add more folders to ship with the application, here
folder_01.source = qml/titta
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

android {
    rtmpdump.files=/home/chucky/src/rtmpdump-android-static-polarssl1.1.4/rtmpgw
    rtmpdump.path=/assets/
    INSTALLS += rtmpdump
}


# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    tidynetworkreply.cpp \
    tidynetworkaccessmanager.cpp \
    networkaccessmanagerfactory.cpp \
    rtmphandler.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    android/AndroidManifest.xml \
    android/version.xml \
    android/res/values-fr/strings.xml \
    android/res/values-et/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-de/strings.xml \
    android/res/drawable/icon.png \
    android/res/drawable/logo.png \
    android/res/values-id/strings.xml \
    android/res/values-rs/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/drawable-ldpi/icon.png \
    android/res/layout/splash.xml \
    android/res/values-ru/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-es/strings.xml \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-hdpi/icon.png \
    android/res/values-nb/strings.xml \
    android/res/values-el/strings.xml \
    android/res/values/libs.xml \
    android/res/values/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-nl/strings.xml \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/src/org/kde/necessitas/origo/QtActivity.java

HEADERS += \
    tidynetworkreply.h \
    tidynetworkaccessmanager.h \
    networkaccessmanagerfactory.h \
    rtmphandler.h
