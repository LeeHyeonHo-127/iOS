//
//  ViewController.swift
//  UIImageTest
//
//  Created by 이현호 on 2023/08/03.
//

import UIKit

class ViewController: UIViewController {
    let url = URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Music/d5/80/bd/mzi.nybhumzg.tif/60x60bb.jpg")
    
    @IBOutlet var albumCover: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = try? Data(contentsOf: url!){
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.albumCover.image = image
                }
            }
        }
    }
}
