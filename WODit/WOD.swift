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
    private var _timer: String!
    private var _time: Int!
    
    var name: String{
        return _name
    }
    
    var score: [String]{
        return _score
    }
    
    var exercise: [String]{
        return _exercise
    }
    
    var timer: String{
        return _timer
    }
    
    var time: Int{
        return _time
    }
    
    init(name: String, score: [String], exercise: [String], timer: String, time: Int){
        
        _name = name
        _score = score
        _exercise = exercise
        _timer = timer
        _time = time
    }
}
