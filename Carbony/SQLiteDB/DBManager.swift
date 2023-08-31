//
//  DBManager.swift
//  Carbony
//
//  Created by doss-zstch1212 on 22/08/23.
/// do release the memory
/// we are dealing with C API here, kindly do the memory management.

import Foundation
import SQLite3

class DBManager {
    
    public static let shared = DBManager()
    
    var database: OpaquePointer?
    
    private init() {
        print("DBManager initialized")
        initializeDB()
    }
    
    // MARK: - Public methods
    // Execute a non-query SQL statement (INSERT, UPDATE, DELETE)
    public func executeNonQuery(query: String) -> Bool {
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) != SQLITE_OK {
            sqlite3_finalize(statement)
            print("Error parsing statement")
            return false
        }

        /*if sqlite3_step(statement) != SQLITE_OK {
            print(statement!)
            print("Error executing statement")
            sqlite3_finalize(statement)
            return false
        }*/
        
        sqlite3_finalize(statement)
        return true
    }
    
    // Execute a query and return a result set
    public func executeQuery(query: String) -> [[String: Any]] {
        var resultArray = [[String: Any]]()
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) != SQLITE_OK {
            print("Error parsing data")
            sqlite3_finalize(statement)
            return resultArray
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            var row = [String: Any]()
            
            for i in 0..<sqlite3_column_count(statement) {
                let columnName = String(cString: sqlite3_column_name(statement, i))
                let columnType = sqlite3_column_type(statement, i)
                
                switch columnType {
                case SQLITE_TEXT:
                    if let value = sqlite3_column_text(statement, i) {
                        row[columnName] = String(cString: value)
                    }
                case SQLITE_INTEGER:
                    let value = sqlite3_column_int(statement, i)
                    row[columnName] = Int(value)
                case SQLITE_FLOAT:
                    let value = sqlite3_column_double(statement, i)
                    row[columnName] = Double(value)
                default:
                    break
                }
            }
            
            resultArray.append(row)
        }
        
        // releasing memory
        sqlite3_finalize(statement)
        return resultArray
    }
    
    // MARK: - Private methods
    private func initializeDB() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("CFDatabase.sqlite")
        print("File URL: \(fileURL)")
        if sqlite3_open(fileURL.path, &database) != SQLITE_OK {
            print("Error opening database")
        }
        print("Database open in location: \(fileURL.path)")
    }
    
    // MARK: - Deinitializer
    deinit {
        print("DBManager class deinitialized")
        sqlite3_close(database)
    }
}

