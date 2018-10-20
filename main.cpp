#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QPixmap>
#include <QGeoLocation>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
