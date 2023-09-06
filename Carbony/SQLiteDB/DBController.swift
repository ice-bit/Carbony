//
//  DBController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 30/08/23.
//

import Foundation
import SQLite3

public final class DBController {
    public static let shared = DBController()
    
    var db: OpaquePointer?
    
    let tableName: String = "GoalsTable"
    
    private init() {
        print("DBController initialized")
        db = openDatabase()
    }
    
    // MARK: - Public methods
    public func createGoalsTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS \(tableName) (
                uuid TEXT,
                target INTEGER,
                targetLeft INTEGER,
                progress INTEGER,
                description TEXT
            );
            """
        
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Created goals table")
            } else {
                print("Goals table could not be created!")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    public func insertInto(uuid: String, target: Int, targetLeft: Int, progress: Int, description: String) {
        let insertQuery = """
            INSERT INTO \(tableName) (uuid, target, targetLeft, progress, description)
            VALUES ('\(uuid)', \(target), \(targetLeft), \(progress), '\(description)');
            """
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row")
            } else {
                print("Could not insert row")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        sqlite3_finalize(insertStatement)
    }
    
    func readGoalTable() -> [Goal] {
        let queryStatementString: String = "SELECT * FROM \(tableName);"
        var queryStatement: OpaquePointer? 
        var goals: [Goal] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let uuidString = String(cString: sqlite3_column_text(queryStatement, 0))
                let target = sqlite3_column_int(queryStatement, 1)
                let targetLeft = sqlite3_column_int(queryStatement, 2)
                let progress = sqlite3_column_int(queryStatement, 3)
                let description = String(cString: sqlite3_column_text(queryStatement, 4))
                print("UUID String: \(uuidString)")
                print("Target: \(target)")
                
                if let uuid = UUID(uuidString: uuidString) {
                    let goal = Goal(uuid: uuid, target: Int(target), targetLeft: Int(targetLeft), progress: Int(progress), description: description)
                    goals.append(goal)
                    
                    print("Query result:")
                    print("\(uuidString) | \(target) | \(targetLeft) | \(progress) | \(description)")
                } else {
                    print("Error converting uuidString value into UUID")
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return goals
    }
    
    func printAllDetailsFromDatabase() {
        let queryStatementString = "SELECT * FROM \(tableName);"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let uuidString = String(cString: sqlite3_column_text(queryStatement, 0))
                let target = sqlite3_column_int(queryStatement, 1)
                let targetLeft = sqlite3_column_int(queryStatement, 2)
                let progress = sqlite3_column_int(queryStatement, 3)
                let description = String(cString: sqlite3_column_text(queryStatement, 4))
                
                print("UUID: \(uuidString)")
                print("Target: \(target)")
                print("Target Left: \(targetLeft)")
                print("Progress: \(progress)")
                print("Description: \(description)")
                
                print("-------------")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
    }
    
    public func updateGoal(uuid: String, newProgress: Int, newTarget: Int) {
        let updateQuery = """
                UPDATE \(tableName)
                SET progress = \(newProgress), target = \(newTarget)
                WHERE uuid = '\(uuid)';
                """
        
        var updateStatment: OpaquePointer?
        
        if sqlite3_prepare_v2(db, updateQuery, -1, &updateStatment, nil) == SQLITE_OK {
            if sqlite3_step(updateStatment) == SQLITE_DONE {
                print("Successfully updated goal with UUID: \(uuid)")
            } else {
                print("Could not update goal with UUID: \(uuid)")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        
        sqlite3_finalize(updateStatment)
    }

    
    // MARK: - Private methods
    private func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        
        if sqlite3_open(getFileURL().path(), &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(getFileURL().path())")
            return db
        } else {
            print("Unable to open database")
        }
        
        return nil
    }
    
    private func getFileURL() -> URL {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("CarbonFootprintDatabase.sqlite")
        return fileURL
    }
    
    deinit {
        print("DBController deinitialized")
        sqlite3_close(db)
    }
}
