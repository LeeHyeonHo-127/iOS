//
//  ViewController.swift
//  MVC_Pattern
//
//  Created by 이현호 on 2023/07/30.
//

import UIKit

class ViewController: UIViewController {
    
    var storybrain = StoryBrain()
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        self.titleLabel?.numberOfLines = 0
        self.titleLabel.text = storybrain.getStoryLabelText()
        self.button1.setTitle(storybrain.getChoice1ButtonText(), for: .normal)
        self.button2.setTitle(storybrain.getChoice2ButtonText(), for: .normal)
    }
    @IBAction func button1Tapped(_ sender: Any) {
        self.storybrain.changeStoryNumber(targetNumber: storybrain.getChoice1ButtonDestination())
        self.updateUI()
    }
    @IBAction func button2Tapped(_ sender: Any) {
        self.storybrain.changeStoryNumber(targetNumber: storybrain.getChoice2ButtonDestination())
        self.updateUI()
    }
    func updateUI(){
        self.titleLabel.text = storybrain.getStoryLabelText()
        self.button1.setTitle(storybrain.getChoice1ButtonText(), for: .normal)
        self.button2.setTitle(storybrain.getChoice2ButtonText(), for: .normal)
    }
    
    
    
    func setBackgroundImage(){
        let backgroundImage = UIImage(named: "background2.png")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(backgroundImageView, at: 0)

        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

