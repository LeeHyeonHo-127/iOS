//
//  MainViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/15.
//

import UIKit

class MainViewController: UIViewController {

    
    var collectionViewController: UICollectionViewController?
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        // collectionView에 HomeViewController 할당
        collectionViewController = homeViewController
                
        // HomeViewController를 자식 뷰 컨트롤러로 추가
        addChild(homeViewController)
        homeViewController.view.frame = collectionView.bounds
        collectionView.addSubview(homeViewController.view)
        homeViewController.didMove(toParent: self)

    }


}
