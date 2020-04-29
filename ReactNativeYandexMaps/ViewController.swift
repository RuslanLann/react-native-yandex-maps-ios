import UIKit
import Foundation
import YandexMapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: YMKMapView!
    
    let TARGET_LOCATION = YMKPoint(latitude: 55.676265, longitude: 37.519503)

    override func viewDidLoad() {
        super.viewDidLoad()
        
         mapView.mapWindow.map.move(
               with: YMKCameraPosition(target: TARGET_LOCATION, zoom: 15, azimuth: 0, tilt: 0),
               animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.4),
               cameraCallback: nil)
        
        createMapObjects()
    }
    
    func createMapObjects() {
        let mapObjects = mapView.mapWindow.map.mapObjects
        
        let placemark = mapObjects.addPlacemark(with: TARGET_LOCATION)
        placemark.opacity = 1
        placemark.setIconWith(UIImage(named:"Mark")!, style: YMKIconStyle(
            anchor: CGPoint(x: 0.5, y: 1) as NSValue,
            rotationType: YMKRotationType.noRotation.rawValue as NSNumber,
            zIndex: 0,
            flat: false,
            visible: true,
            scale: 0.8,
            tappableArea: nil
        ))

    }
}
