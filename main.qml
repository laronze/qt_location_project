import QtQuick 2.9
import QtQuick.Window 2.2
import QtLocation 5.9
import QtPositioning 5.11


Window {

    visible: true

    PositionSource {
        id: src
        updateInterval: 1000
        active: true

        onPositionChanged: {
            var coord = src.position.coordinate;
            console.log("Coordinate:", coord.longitude, coord.latitude);
            map.center = coord;
            me.coordinate = coord;
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
            id: marker
            coordinate:  QtPositioning.coordinate(62.241857, 25.759745) // jamk
            anchorPoint.x: image.width/2
            anchorPoint.y: image.height
            sourceItem: Image {
                width: 100; height: 100
                id: image
                source: "images/art3.png"

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
       MapPolyline {
               line.width: 10
               line.color: 'green'
               path: [
                   { latitude: -27, longitude: 153.0 },
                   { latitude: -27, longitude: 154.1 },
                   { latitude: -28, longitude: 153.5 },
                   { latitude: -29, longitude: 153.5 }
               ]
    }

}

}
