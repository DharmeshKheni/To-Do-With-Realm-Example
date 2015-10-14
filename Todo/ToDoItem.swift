//
//  ToDoItem.swift
//  Todo
//
//  Created by Anil on 12/10/15.
//  Copyright © 2015 ABBS COMPUTERS. All rights reserved.
//

import Foundation
import Realm // [1]

class ToDoItem: RLMObject { // [2]
    dynamic var name = "" // [3]
    dynamic var finished = false
}