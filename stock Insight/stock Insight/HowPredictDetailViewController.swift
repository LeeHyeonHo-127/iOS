//
//  HowPredictDetailViewController.swift
//  stock Insight
//
//  Created by 이현호 on 2023/05/31.
//

import UIKit
import MarkdownKit

class HowPredictDetailViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayMarkdownDocument(markdown: self.markdown, in: self.textView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func renderMarkdownDocument(markdown: String) -> NSAttributedString? {
        let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 17))
        return markdownParser.parse(markdown)
    }

    func displayMarkdownDocument(markdown: String, in textView: UITextView) {
        if let attributedString = renderMarkdownDocument(markdown: markdown) {
            textView.attributedText = attributedString
        } else {
            textView.text = "Failed to load markdown document."
        }
    }

    // Usage example
    let markdown = """
        # LSTM

        LSTM은 RNN(Recurrent Neural Network)의 일종으로, 시계열 데이터를 처리하기 위한 딥러닝 모델입니다.

        RNN은 일반적인 딥러닝 모델과는 달리, 이전 시간의 데이터를 현재 시간의 입력으로 사용하여 처리합니다. 하지만 이전 시간의 정보가 현재 시간의 입력에 반영되는 과정에서 문제가 발생할 수 있습니다. 이를 해결하기 위해 나온 것이 LSTM입니다.

        LSTM은 RNN에 비해 더 긴 시간 간격의 정보를 기억할 수 있으며, 이전 시간의 정보가 현재 시간의 입력에 얼마나 반영되어야 하는지를 조절하는 gate mechanism을 사용합니다. 이 gate mechanism은 정보를 얼마나 유지할지를 결정하는 forget gate, 현재 시간의 입력을 얼마나 반영할지를 결정하는 input gate, 그리고 다음 시간에 어떤 정보를 출력할지를 결정하는 output gate로 구성되어 있습니다.

        LSTM은 자연어 처리나 음성 인식 같은 시퀀스 데이터 처리에 많이 사용되며, 이를 통해 더 나은 성능을 얻을 수 있습니다.

        LSTM을 사용하여 주가를 예측한 방법은 다음과 같습니다.

        1. 데이터 수집 및 전처리
            - 예측하고자 하는 주식의 가격 데이터를 수집합니다.
            - 데이터를 정규화하고, 학습용 데이터와 검증용 데이터로 나눕니다.
        2. LSTM 모델 구성
            - LSTM 레이어를 적절한 수만큼 쌓습니다.
            - 출력 레이어를 추가하여 예측값을 출력합니다.
        3. 모델 학습
            - 학습용 데이터를 사용하여 모델을 학습시킵니다.
            - 검증용 데이터를 사용하여 모델의 성능을 평가합니다.
        4. 예측
            - 학습된 모델을 사용하여 예측을 수행합니다.
            - 예측 결과를 시각화하여 분석합니다.

        LSTM을 사용하여 주가 예측을 수행할 때는 데이터 전처리와 모델 구성, 학습, 예측 등의 과정이 중요합니다. 또한, 주가 예측은 불확실성이 높은 작업이므로, 예측 결과에 대한 충분한 검증이 필요합니다.

        
        """

    
    
   
    


}
