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
    
    var name: String{
        return _name
    }
    
    var score: [String]{
        return _score
    }
    
    init(name: String, score: [String]){
        
        _name = name
        _score = score
    }
}
