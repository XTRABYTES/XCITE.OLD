#ifndef URLOBJECT_HPP
#define URLOBJECT_HPP

#include <QObject>
#include <QtNetwork>
#include <QtCore>

class URLObject:public QObject {
  QUrl url;
  QMap<QString,QVariant> properties;


public:

    URLObject() {}
    URLObject(QUrl url){
        this->url = url;
    }
  // Setter
  void setUrl(QUrl url) {
    this->url = url;
  }
  void addProperty(QString key, QVariant value){
      properties.insert(key,value);
  }
  bool hasProperty(QString key){
      if (properties.contains(key)){
          return true;
      }else{
          return false;
      }
  }
  void removeProperty(QString key){
      if (properties.contains(key)){
          properties.remove(key);
      }
  }


  // Getter
  QUrl getUrl() {
    return url;
  }
  QMap<QString,QVariant> getProperties(){
      return properties;
  }
  QVariant getProperty(QString key){
      if (properties.contains(key)){
          return properties.value(key);
      }else{
          return "Property does not exist";
      }
  }
};


#endif // URLOBJECT_HPP
