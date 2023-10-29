//
//  ViewCodeProtocol.swift
//  SeaFlow
//
//  Created by 이현호 on 2023/10/27.
//

import Foundation

public protocol ViewCodeProtocol {
    func buildViewHierachy()
    func setUpConstraint()
    func configureView()
}

public extension ViewCodeProtocol {
    func applyViewCode(){
        buildViewHierachy()
        setUpConstraint()
        configureView()
    }
    
    func configureView(){
        
    }
}


