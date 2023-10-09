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
    
    /// Change the table name here
    let goalTableName: String = "GoalsTable"
    
    let footprintTableName = "CarbonFootprintThree"
    
    private init() {
        print("DBController initialized")
        db = openDatabase()
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
    
    public func deleteAllData(from tableName: String) {
        let deleteQuery = "DELETE FROM \(tableName);"
        var deleteStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted all data from the table")
            } else {
                print("Could not delete data from the table")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }

        sqlite3_finalize(deleteStatement)
    }
    
    // MARK: - Deinit
    deinit {
        print("DBController deinitialized")
        sqlite3_close(db)
    }
}

// MARK: - Goal table operations
extension DBController {
    /// CRUD operations for goal table
    // MARK: - Create
    public func createGoalsTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS \(goalTableName) (
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
    
    // MARK: - Read
    func fetchGoals(completion: @escaping([Goal]?, Error?) -> Void) {
        let queryStatementString: String = "SELECT * FROM \(self.goalTableName);"
        var queryStatement: OpaquePointer?
        var goals: [Goal] = []
        
        if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let uuidString = String(cString: sqlite3_column_text(queryStatement, 0))
                let target = sqlite3_column_int(queryStatement, 1)
                let targetLeft = sqlite3_column_int(queryStatement, 2)
                let progress = sqlite3_column_int(queryStatement, 3)
                let description = String(cString: sqlite3_column_text(queryStatement, 4))
                // uncommet these print statements when it is necessary
                /*print("UUID String: \(uuidString)")
                 print("Target: \(target)")*/
                
                if let uuid = UUID(uuidString: uuidString) {
                    let goal = Goal(uuid: uuid, target: Int(target), targetLeft: Int(targetLeft), progress: Int(progress), description: description)
                    goals.append(goal)
                    
                    /*print("Query result:")
                     print("\(uuidString) | \(target) | \(targetLeft) | \(progress) | \(description)")*/
                } else {
                    let error = NSError(domain: "com.yoda.Carbony", code: 0, userInfo: [NSDebugDescriptionErrorKey: "Falied to convert uuidDtring to UUID"])
                    completion(nil, error)
                    
                    return
                }
            }
            
            sqlite3_finalize(queryStatement)
            completion(goals, nil)
        } else {
            let error = NSError(domain: "NVM", code: 0, userInfo: [NSDebugDescriptionErrorKey: "SELECT statement could not be prepared"])
            completion(nil, error)
        }
    }
    
    func fetchGoalsCounts(completion: @escaping (Int, Int) -> Void) {
        var totalGoalsCount: Int = 0
        var completedGoalsCount: Int = 0
        
        let totalGoalsQuery = "SELECT COUNT(*) from \(goalTableName)"
        let completedGoalsQuery = "SELECT COUNT(*) FROM \(goalTableName) WHERE progress = 100;"
        
        var totalGoalsStatement: OpaquePointer?
        var completedGoalsStatement: OpaquePointer?
        
        guard sqlite3_prepare_v2(db, totalGoalsQuery, -1, &totalGoalsStatement, nil) == SQLITE_OK,
              sqlite3_prepare_v2(db, completedGoalsQuery, -1, &completedGoalsStatement, nil) == SQLITE_OK else {
            print("Error preparing the statement!")
            completion(totalGoalsCount, completedGoalsCount)
            return
        }
        
        // Execute the queries and return the counts
        if sqlite3_step(totalGoalsStatement) == SQLITE_ROW {
            totalGoalsCount = Int(sqlite3_column_int(totalGoalsStatement, 0))
        }
        
        if sqlite3_step(completedGoalsStatement) == SQLITE_ROW {
            completedGoalsCount = Int(sqlite3_column_int(completedGoalsStatement, 0))
        }
        
        sqlite3_finalize(totalGoalsStatement)
        sqlite3_finalize(completedGoalsStatement)
        
        completion(totalGoalsCount, completedGoalsCount)
    }


    
    func displayGoals() {
        let queryStatementString = "SELECT * FROM \(goalTableName);"
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
    
    // MARK: - Update
    public func insertIntoGoalTable(uuid: String, target: Int, targetLeft: Int, progress: Int, description: String) {
        let insertQuery = """
            INSERT INTO \(goalTableName) (uuid, target, targetLeft, progress, description)
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
    
    /// This method updates the goal.
    /// Also keep in mind that while passsing the values to this method calculate and have the new values to be updated
    /// - Parameters:
    ///     - uuid: Provide UUID srtring `UUID.uuidString`
    ///     - newProgress: Provide new progress
    ///     - newTargetLeft: Provide the target left
    /// - SeeAlso: `updateGoal(for goal: Goal, with reducedEmissionValue: Int) -> Goal`
    public func updateGoal(uuid: String, newProgress: Int, newTargetLeft: Int) {
        let updateQuery = """
                UPDATE \(goalTableName)
                SET progress = \(newProgress), targetLeft = \(newTargetLeft)
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
    
    // MARK: - Delete

    
    // TODO: Method for deleting specific goals
}

// MARK: - Footprint table operation
extension DBController {
    /// CRUD operations for footprint table
    // MARK: - Create
    public func createFootprintTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS \(footprintTableName) (
            uuid TEXT,
            emissionValue REAL,
            footprintType TEXT,
            date TEXT
        );
        """
        
        var createTableStatment: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatment, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatment) == SQLITE_DONE {
                print("Footprint table created successfully")
            } else {
                print("Footprint table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared")
        }
        
        sqlite3_finalize(createTableStatment)
    }
    
    // MARK: - Read
    // Method to display the rows of footprint table in console
    public func printFootprintTableRows() {
        let queryStatementString = "SELECT * FROM \(footprintTableName);"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let uuidString = String(cString: sqlite3_column_text(queryStatement, 0))
                let emissionValue = sqlite3_column_double(queryStatement, 1)
                let footprintType = String(cString: sqlite3_column_text(queryStatement, 2))
                let dateTimestamp = String(cString: sqlite3_column_text(queryStatement, 3))
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // ISO 8601 format
                
                if let formattedDate = dateFormatter.date(from: dateTimestamp),
                   let uuid = UUID(uuidString: uuidString) {
                    print("UUID: \(uuid)")
                    print("Emission Value: \(emissionValue)")
                    print("Footprint Type: \(footprintType)")
                    print("Date: \(String(describing: formattedDate))")
                    
                    print("-------------")
                } else {
                    print("Unable to convert date for date string!")
                }
            }
        } else {
            print("SELECT statement for the CarbonFootprint table could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
    }
    
    func fetchFootprints(completion: @escaping([CarbonFootprint]?, Error?) -> Void){
        var footprints: [CarbonFootprint] = []
        let queryStatementString = "SELECT * FROM \(self.footprintTableName);"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let uuidString = String(cString: sqlite3_column_text(queryStatement, 0))
                let emissionValue = sqlite3_column_double(queryStatement, 1)
                let footprintType = String(cString: sqlite3_column_text(queryStatement, 2))
                let dateTimestamp = String(cString: sqlite3_column_text(queryStatement, 3))
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // ISO 8601 format
                
                if let formattedDate = dateFormatter.date(from: dateTimestamp),
                   let uuid = UUID(uuidString: uuidString) {
                    let carbonFootprint = CarbonFootprint(uuid: uuid, emissionValue: emissionValue, footprintType: footprintType, date: formattedDate)
                    footprints.append(carbonFootprint)
                } else {
                    let error = NSError(domain: "I don't have any error domian", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to convert date for date string!"])
                    completion(nil, error)
                    
                    return
                }
            }
            
            sqlite3_finalize(queryStatement)
            completion(footprints, nil)
            
        } else {
            let error = NSError(domain: "No idea about domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "SELECT statement for the CarbonFootprint table could not be prepared"])
            completion(nil, error)
        }
    }
    
    func getTotalFootprint(completion: @escaping(Double) -> Void) {
        var totalEmission: Double = 0.0
        let findSumQuery = "SELECT SUM(emissionValue) FROM \(footprintTableName);"
        
        var queryStatement: OpaquePointer?
        
        guard sqlite3_prepare_v2(db, findSumQuery, -1, &queryStatement, nil) == SQLITE_OK else {
            print("Unable to prepare the statement!")
            completion(totalEmission)
            return
        }
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let totalEmissionValue = sqlite3_column_double(queryStatement, 0)
            totalEmission = totalEmissionValue
            print("Total emission: \(totalEmission)")
        }
        completion(totalEmission)
        sqlite3_finalize(queryStatement)
    }


    
    // MARK: - Update
    func insertIntoFootprintTable(uuid: UUID, emissioValue: Double, footprintType: String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // ISO 8601 format
        
        let formattedDate = dateFormatter.string(from: date)
        print("DEBUG INFO: Formatted date = \(formattedDate)")
        
        let insertQuery = """
        INSERT INTO \(footprintTableName) (uuid, emissionValue, footprintType, date)
        VALUES ('\(uuid.uuidString)', \(emissioValue), '\(footprintType)', '\(formattedDate)');
        """
        
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row \(insertQuery)!")
            } else {
                print("Error inserting row! Check the insert statement :(")
            }
        } else {
            print("INSERT_QUERY: `\(insertQuery)` could not be prepared!")
        }
        
        sqlite3_finalize(insertStatement)
    }
    
    
    // MARK: - Delete
    // TODO: write method for deleting rows from the footprint table
}

   
