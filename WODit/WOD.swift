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
    
    var name: String{
        return _name
    }
    
    init(name: String){
        
        _name = name
    }
}
