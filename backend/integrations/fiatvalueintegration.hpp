#ifndef FIATVALUEINTEGRATION_HPP
#define FIATVALUEINTEGRATION_HPP

#include <QObject>
#include <QtNetwork/QHostInfo>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

class FiatValueIntegration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString fiatValue READ fiatValue WRITE setFiatValue NOTIFY fiatValueChanged)
public:
    explicit FiatValueIntegration(QObject *parent = nullptr);

    void setFiatValue(const QString &a) {
        if (a != m_fiatValue) {
            m_fiatValue = a;
            emit fiatValueChanged();
        }
    }
    QString fiatValue() const {
        return m_fiatValue;
    }

signals:
    void fiatValueChanged();
public slots:
    void findXBYValue();
    void onFinished(QNetworkReply* reply);
private:
    QString m_fiatValue;
};

#endif // FIATVALUEINTEGRATION_HPP
