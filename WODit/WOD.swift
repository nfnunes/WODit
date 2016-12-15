//
//  WOD.swift
//  WODit
//
//  Created by Nuno on 06/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import Foundation

class WOD {
    private var _name: String!
    private var _score: [String]!
    private var _exercise: [String]!
    
    var name: String{
        return _name
    }
    
    var score: [String]{
        return _score
    }
    
    var exercise: [String]{
        return _exercise
    }
    
    init(name: String, score: [String], exercise: [String]){
        
        _name = name
        _score = score
        _exercise = exercise
    }
}
