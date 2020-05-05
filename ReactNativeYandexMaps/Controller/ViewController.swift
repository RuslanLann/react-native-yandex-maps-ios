import UIKit
import YandexMapKit

class ViewController: UIViewController, YMKMapObjectTapListener, YMKUserLocationObjectListener {
    
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
    let greenIcon = UIImage(named: "GreenPin")!
    let redIcon = UIImage(named: "RedPin")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.setObjectListenerWith(self)
        
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
        var icon = greenIcon
        
        if (color == "red") {
            icon = redIcon
        }
        
        let placemark = mapObjects.addPlacemark(with: location)
        placemark.opacity = 1
        placemark.setIconWith(icon, style: YMKIconStyle(
            anchor: CGPoint(x: 0.5, y: 1) as NSValue,
            rotationType: YMKRotationType.noRotation.rawValue as NSNumber,
            zIndex: 0,
            flat: false,
            visible: true,
            scale: 0.7,
            tappableArea: YMKRect(min: CGPoint(x: 0, y: 0), max: CGPoint(x: 1, y: 1))
        ))
        placemark.addTapListener(with: self)
        
        let circle = mapObjects.addCircle(
            with: YMKCircle(center: location, radius: 100),
            stroke: COLOR_OBJECTS[color]!["stroke"]!,
            strokeWidth: 1.1,
            fill: COLOR_OBJECTS[color]!["fill"]!
        )
        circle.zIndex = 100
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let placemark = mapObject as? YMKPlacemarkMapObject else { return false }
        
        let iconStyle: YMKIconStyle = YMKIconStyle()
        iconStyle.scale = 1
        iconStyle.anchor = CGPoint(x: 0.5, y: 1) as NSValue
        
        placemark.setIconStyleWith(iconStyle)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: point.latitude, longitude: point.longitude),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.4),
            cameraCallback: nil
        )
        return true
    }
    
    func onObjectAdded(with view: YMKUserLocationView) {
        view.arrow.setIconWith(UIImage(named:"UserIcon")!)
        
        let pinPlacemark = view.pin.useCompositeIcon()
        
        pinPlacemark.setIconWithName(
            "UserIcon",
            image: UIImage(named:"UserIcon")!,
            style:YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 0,
                flat: true,
                visible: true,
                scale: 0.2,
                tappableArea: nil)
        )
        
        view.accuracyCircle.fillColor = UIColor(named: "TransparentRed")!
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
        
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        
    }
}
