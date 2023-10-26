//
//  ViewCodeProtocol.swift
//  viewCodePractice
//
//  Created by 이현호 on 2023/10/26.
//

import Foundation

public protocol ViewCodeProtocol {
    func buildViewHierachy()
    func setUpConstraint()
    func congigureView()
}

public extension ViewCodeProtocol {
    
    func applyViewCode(){
        buildViewHierachy()
        setUpConstraint()
        congigureView()
    }
    
    func configureView() {
        
    }
}
