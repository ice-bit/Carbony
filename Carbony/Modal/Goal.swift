//
//  Goal.swift
//  Carbony
//
//  Created by doss-zstch1212 on 21/08/23.
//

import Foundation

class Goal: Hashable {
    let uuid: UUID
    let target: Int
    let targetLeft: Int
    let progress: Int
    let description: String
    
    init(uuid: UUID, target: Int, targetLeft: Int, progress: Int, description: String) {
        self.uuid = uuid
        self.target = target
        self.targetLeft = targetLeft
        self.progress = progress
        self.description = description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: Goal, rhs: Goal) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
