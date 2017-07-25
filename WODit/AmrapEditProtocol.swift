//
//  AmrapEditProtocol.swift
//  WODit
//
//  Created by Nuno on 18/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import Foundation

protocol EditAmrapControllerDelegate: class {
    func editAmrapTime(_ minutes: Int, _ seconds: Int)
}
