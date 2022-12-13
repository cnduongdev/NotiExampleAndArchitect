//
//  UseCase.swift
//  NotiExample
//
//  Created by Cao Nam Duong on 13/12/2022.
//

import Foundation


protocol UseCase {
    
    associatedtype EM
    associatedtype PM
    
    func execute(params: PM) -> EM
}

protocol UseCaseWithoutParams {
    
    associatedtype EM
    
    func execute() -> EM
}
