//
//  SQLiteOperationController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 30/08/23.
//

import Foundation
import SQLite3

public final class SQLiteOperationController {
    
    public static let shared = SQLiteOperationController()
    
    private var sqliteDBPointer: OpaquePointer?
    
    private init() {
        initializeDB()
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    private func initializeDB() {
//        if var directoryURL = 
    }
}
