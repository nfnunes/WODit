//
//  goWODprotocol.swift
//  WODit
//
//  Created by Nuno on 24/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import Foundation

protocol goWODControllerDelegate: class {
    func setGoWODForTime(_ wodName: String, _ wodExercises: [String])
}
