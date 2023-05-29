import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    var denied = false
    
    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗しました: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        // ユーザーが位置情報を選択してない場合
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        // ペアレンタルコントロールなどの制限がかかっている場合
        case .restricted:
            manager.requestLocation()
        // ユーザーが設定から位置情報を許可してない場合
        case .denied:
            manager.requestWhenInUseAuthorization()
            denied = true
        // ユーザーが位置情報を許可している場合
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            fatalError()
        }
    }
}
