//
//  HowPredictViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/31.
//

import UIKit

class HowPredictViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func LSTMDetailButtonTapped(_ sender: Any) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HowPredictDetailViewController") as? HowPredictDetailViewController else {return}
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func sentimentAnalysisDetailButtonTapped(_ sender: Any) {
    }
    
    @IBAction func movingAverageDetailButtonTapped(_ sender: Any) {
    }
}


