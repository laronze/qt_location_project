import QtQuick 2.9
import QtQuick.Window 2.2
import QtLocation 5.9
import QtPositioning 5.11


Window {

    visible: true

    PositionSource {
        id: src
        updateInterval: 10000
        active: true

        onPositionChanged: {
            var coord = src.position.coordinate;
            console.log("Coordinate:", coord.longitude, coord.latitude);
            map.center = coord;
            me.coordinate = coord;

            /*var jamkPlace = GeocodeModel.query = "Piippukatu 2, 40100 Jyväskylä, Finland"*/
        }
    }

    Plugin {
        id: osmPlugin
        allowExperimental: true
        preferred: ["osm"]
    }


    Map {
        id: map
        anchors.fill: parent
        plugin: osmPlugin
        zoomLevel: 15



       MapQuickItem {
            id: jamk

            anchorPoint.x: image.width/2
            anchorPoint.y: image.height
            sourceItem: Image {
                width: 100; height: 100
                id: image
                source: "images/art3.png"

            }
        }
       MapItemView {
       model: routeModel
       delegate: Component {
           MapRoute {
               route: routeData
               line.color: "blue"
               line.width: 4
                }
             }
       }

       MapQuickItem {
            id: me
            coordinate:  PositionSource.position.coordinate
            anchorPoint.x: image.width/2
            anchorPoint.y: image.height
            sourceItem: Image {
                width: 100; height: 100
                id: imageMe
                source: "images/crabik.png"
            }
        }
      GeocodeModel {
           plugin: map.plugin
           query: " Piippukatu 2, Jyväskylä"
           onLocationsChanged:
            {
                if (count) {
                    jamk.coordinate = get(0).coordinate
                    console.log("Coordinate jamk :",  jamk.coordinate);
                }
            }
           Component.onCompleted: update()
       }
       RouteModel {
            id: routeModel
            plugin: map.plugin
            query: RouteQuery {id: routeQuery}
            Component.onCompleted: {
                routeQuery.addWaypoint(QtPositioning.coordinate(62.221052, 25.704212));
                routeQuery.addWaypoint(QtPositioning.coordinate(62.241623, 25.758852));
                update();
            }

       }

    }



}
