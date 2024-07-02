//
//  ViewController.swift
//  Moya_practice
//
//  Created by 이현호 on 2023/08/10.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var MusicTrackList: [MusicTrack] = []
    var audioPlayer: AVPlayer?
    @IBOutlet var albumCoverImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setArtwork()
        GetMusicTrack.share.getTrack(completionHandler: {[weak self] result in
            switch result{
            case let .success(result):
                DispatchQueue.main.async {
                    let musicURL = URL(string: result.results[0].previewUrl)!
                    self?.playMusic(url: musicURL)
                    let albumImage = self?.getImage(url: URL(string: result.results[0].artworkUrl100)!)
                    self?.albumCoverImageView.image = albumImage
                }
            case let .failure(error):
                debugPrint("통신 실패ㅠㅠ \(error)")
            }
        })

    }
    
    func playMusic(url: URL){
        self.audioPlayer = AVPlayer(url: url)
        self.audioPlayer?.play()
    }
    

    
    func setArtwork(){
        albumCoverImageView.layer.cornerRadius = albumCoverImageView.frame.size.width/2
        albumCoverImageView.clipsToBounds = true
        
        //앨범 커버 360도 돌리기
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2) // 360도 회전 (2 * π 라디안)
        rotationAnimation.duration = 5.0 // 애니메이션 지속 시간 (초)
        rotationAnimation.repeatCount = .infinity // 무한 반복
        albumCoverImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    //url기반 이미지 반환 코드
    func getImage(url: URL)-> UIImage{
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {return image}
        }else{
            return UIImage()
        }
        return UIImage()
    }
    
                                
                                      
                                      


}

