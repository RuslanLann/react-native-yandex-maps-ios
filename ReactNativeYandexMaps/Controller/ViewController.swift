import UIKit
import YandexMapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: YMKMapView!
    
    let RESTAURANT_LOCATION = YMKPoint(latitude: 55.676265, longitude: 37.519503)
    let ORDER_LOCATION = YMKPoint(latitude: 55.681648, longitude: 37.516156)
    let COLOR_OBJECTS = [
        "red": [
           "stroke": UIColor(named: "Red")!,
           "fill": UIColor(named: "TransparentRed")!
        ],
        "green": [
           "stroke": UIColor(named: "Green")!,
           "fill": UIColor(named: "TransparentGreen")!
        ]
    ]
    let MARKERS_ARRAY = [
        ["lat": 55.676265, "lon": 37.519503, "color": "red"],
        ["lat": 55.681648, "lon": 37.516156, "color": "green"],
        ["lat": 55.679270, "lon": 37.516027, "color": "green"],
        ["lat": 55.677204, "lon": 37.528154, "color": "green"],
        ["lat": 55.676998, "lon": 37.523178, "color": "green"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
         mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: RESTAURANT_LOCATION, zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.4),
            cameraCallback: nil
        )
        
        for point in MARKERS_ARRAY {
            createMapMarkerWithCircle(
                lat: point["lat"] as! Double,
                lon: point["lon"] as! Double,
                color: point["color"] as! String
            )
        }
    }
    
    func createMapMarkerWithCircle (lat: Double, lon: Double, color: String) {
        let mapObjects = mapView.mapWindow.map.mapObjects

        let location = YMKPoint(latitude: lat, longitude: lon)
        var iconName = "RedPin"

        if (color == "green") {
            iconName = "GreenPin"
        }

        let placemark = mapObjects.addPlacemark(with: location)
        placemark.opacity = 1
        placemark.setIconWith(UIImage(named: iconName)!, style: YMKIconStyle(
            anchor: CGPoint(x: 0.5, y: 1) as NSValue,
            rotationType: YMKRotationType.noRotation.rawValue as NSNumber,
            zIndex: 0,
            flat: false,
            visible: true,
            scale: 0.8,
            tappableArea: nil
        ))

        let circle = mapObjects.addCircle(
           with: YMKCircle(center: location, radius: 100),
           stroke: COLOR_OBJECTS[color]!["stroke"]!,
           strokeWidth: 1.1,
           fill: COLOR_OBJECTS[color]!["fill"]!
        )
        circle.zIndex = 100
    }
}
