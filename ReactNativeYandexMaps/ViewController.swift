import UIKit
import Foundation
import YandexMapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: YMKMapView!
    
    let TARGET_LOCATION = YMKPoint(latitude: 55.751992, longitude: 37.622537)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         mapView.mapWindow.map.move(
               with: YMKCameraPosition(target: TARGET_LOCATION, zoom: 14, azimuth: 0, tilt: 0),
               animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
               cameraCallback: nil)
    }
}
