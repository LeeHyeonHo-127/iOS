//
//  RoundButton.swift
//  Calculator
//
//  Created by 이현호 on 2023/01/03.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var isRound: Bool = false{
        didSet{
            if isRound{
                self.layer.cornerRadius = self.frame.height / 2 //정사각형은 원이 된다
            }
        }
    }

}
