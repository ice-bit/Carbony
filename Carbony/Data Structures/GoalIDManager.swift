//
//  GoalIDManager.swift
//  Carbony
//
//  Created by doss-zstch1212 on 31/08/23.
//

import Foundation

class GoalIDManager {
    public static let shared = GoalIDManager()
    
    private var currentID: Int = 0
    
    private init() {}
    
    func getNextID() -> Int {
        currentID += 1
        return currentID
    }
}
