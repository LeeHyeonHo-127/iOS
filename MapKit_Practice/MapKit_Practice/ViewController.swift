//
//  ViewController.swift
//  MapKit_Practice
//
//  Created by 이현호 on 2023/07/31.
//

import UIKit
import MapKit

enum AnnotationGenre: String, CaseIterable{
    case hiphop = "HipHop"
    case balad = "Balad"
    case rock = "Rock"
    case classic = "Classic"
    case pop = "Pop"
}

class CustomAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var genre: AnnotationGenre

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, genre: AnnotationGenre) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.genre = genre
        super.init()
    }
}

class ViewController: UIViewController {
    
    
    @IBOutlet var mapkit: MKMapView!
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var centerMainTitle: UILabel!
    @IBOutlet var centerSubTitle: UILabel!
    let locationManager = CLLocationManager()
    var annotations: [CustomAnnotation] = []
    
    var runTimeInterval: TimeInterval? // 마지막 작업을 설정할 시간
    let mTimer: Selector = #selector(Tick_TimeConsole) // 위치 확인 타이머

    override func viewDidLoad() {
        super.viewDidLoad()
        mapkit.delegate = self
        locationManager.delegate = self
        makeLocation()
    
        // 정확도 설정 - 최고로 높은 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 데이터 승인 요구
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트 시작
        locationManager.startUpdatingLocation()
        // 사용자 위치 보기 설정
        mapkit.showsUserLocation = true
            
        // 줌 가능 여부
        // mapKit.zoomEnabled = false
        // 스크롤 가능 여부
        // mapKit.scrollEnabled = false
        // 회전 가능 여부
        // mapKit.rotateEnabled = false
        // 각도 가능 여부
        // mapKit.pitchEnabled = false
        
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: mTimer, userInfo: nil, repeats: true)

    }
    
    
    @IBAction func changeValue(_ sender: UISegmentedControl) {
        // "현재 위치" 선택 - 현재 위치 표시
        if sender.selectedSegmentIndex == 0 {
            self.mainTitle.text = ""
            self.subTitle.text = ""
            // 사용자의 현재 위치
            locationManager.startUpdatingLocation()

        // 특정 위치 선택 - 애플 가로수길 표시
        } else if sender.selectedSegmentIndex == 1 {
            moveLocation(latitudeValue: 37.5207945, longtudeValue: 127.0204729, delta: 0.01)
            setAnnotation(latitudeValue: 37.5207945, longitudeValue: 127.0204729, delta: 0.01, title: "가로수길 서비스 센터", subtitle: "서울 강남구 가로수길 43")
            annotations.forEach{
                mapkit.addAnnotation($0)
            }
            self.mainTitle.text = "보고 계신 위치"
            self.subTitle.text = "가로수길 서비스 센터"
        }
    }
    
    //해당 지역으로 이동
    func moveLocation(latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, delta span: Double) {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue) //위치
        let pSpanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) //지도 영역의 높이와 너비
        let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue) //위도 경도와 이를 눌러싼 사각형의 값을 가진 구조체
        mapkit.setRegion(pRegion, animated: true) //MKCoordinateRegion으로 이동
    }
    
    
    
    //annnotation 생성
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubTitle:String) {
        mapkit.removeAnnotations(mapkit.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mapkit.addAnnotation(annotation)
    }
    
    @objc func Tick_TimeConsole() {
            
        guard let timeInterval = runTimeInterval else { return }
            
        let interval = Date().timeIntervalSinceReferenceDate - timeInterval
            
        if interval < 0.25 { return }
            
        let coordinate = mapkit.centerCoordinate
//        print(coordinate.latitude)
//        print(coordinate.longitude)
            
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        // 지정된 위치의 지오 코드 요청
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let pm: CLPlacemark = placemarks?.first {
                let address: String = "\(pm.country ?? "") \(pm.administrativeArea ?? "") \(pm.locality ?? "") \(pm.subLocality ?? "") \(pm.name ?? "")"
                self.centerMainTitle.text = "화면 중앙 위치"
                self.centerSubTitle.text = address
            } else {
                self.centerMainTitle.text = ""
                self.centerSubTitle.text = ""
            }
        }
        runTimeInterval = nil
    }
    
    
    //dummy location 생성 및 dummy Annotation 생성
    func makeLocation(){
        for _ in 0...30{
            let lat = Double.random(in: 37.389829539...37.615316721)
            let log = Double.random(in: 126.636638281...127.1903882771)
            let loc = CLLocationCoordinate2DMake(lat, log)
            let genre: AnnotationGenre = AnnotationGenre.allCases.randomElement()!
            annotations.append(CustomAnnotation(coordinate: loc, title: genre.self.rawValue, subtitle: genre.rawValue, genre: genre))
        }
    }
}

extension ViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    
    //새로운 위치데이터 사용 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        moveLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longtudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: { (placemarks, error) -> Void in
            if let pm: CLPlacemark = placemarks?.first {
                let address: String = "\(pm.locality ?? "") \(pm.name ?? "")"
  
                self.mainTitle.text = "내 위치"
                self.subTitle.text = address
            }
        })
        locationManager.stopUpdatingLocation()
    }
    
    //지도가 보이는 곳이 달라지면 알리는 함수
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        runTimeInterval = Date().timeIntervalSinceReferenceDate
    }
    
    //mapkit.addAnnotation 으로 들어있는 annotation들을 이 함수에서 MKAnnotationView로 생성
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //유저의 위치와 annotation이 같다면 return -> 유저의 현재 위치를 띄우기 위해서.
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true}
        else {
            annotationView?.annotation = annotation
        }
                    
        let miniButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        miniButton.setImage(UIImage(systemName: "airpodsmax"), for: .normal)


        // Set the marker color based on the custom annotation's color property
        
        if let customAnnotation = annotation as? CustomAnnotation {
            switch customAnnotation.genre {
            case .hiphop:
                annotationView?.markerTintColor = .red
                annotationView?.glyphTintColor = .red
                miniButton.tintColor = .red
                annotationView?.rightCalloutAccessoryView = miniButton
            case .balad:
                annotationView?.markerTintColor = .blue
                annotationView?.glyphTintColor = .blue
                miniButton.tintColor = .blue
                annotationView?.rightCalloutAccessoryView = miniButton
            case .classic:
                annotationView?.markerTintColor = .green
                annotationView?.glyphTintColor = .green
                miniButton.tintColor = .green
                annotationView?.rightCalloutAccessoryView = miniButton
            case .pop:
                annotationView?.markerTintColor = .purple
                annotationView?.glyphTintColor = .purple
                miniButton.tintColor = .purple
                annotationView?.rightCalloutAccessoryView = miniButton
            case .rock:
                annotationView?.markerTintColor = .orange
                annotationView?.glyphTintColor = .orange
                miniButton.tintColor = .orange
                annotationView?.rightCalloutAccessoryView = miniButton

            // Add more cases for other colors as needed
            }
        }
        return annotationView
    }
}


//위도는 37.61531672176502, 경도는 126.63663828106317 : 젤 왼쪽
//위도는 37.58977407623971, 경도는 127.19038827710527 : 젤 오른쪽
//위도는 37.713901949033634, 경도는 126.98529021290555 : 젤 위쪽
// 위도는 37.38982953973665, 경도는 126.97668121034702 : 젤 아래쪽

//위도 37.38982953973665 ~ 37.61531672176502
//경도 126.6366382810 ~ 127.19038827710
