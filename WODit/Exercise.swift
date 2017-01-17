//
//  Exercise.swift
//  WODit
//
//  Created by Nuno on 31/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import Foundation

class EXERCISE {
    private var _name: String!
    private var _url: String!
    
    var name: String{
        return _name
    }
    
    var url: String{
        return _url
    }
    
    init(name: String, url: String){
        
        _name = name
        _url = url
    }
}
