//
//  DB_Manager.swift
//  PicSum Image Gallery
//
//  Created by Amin Pourgol on 9/14/23.
//

import Foundation
import SQLite

class DBManager {
    private var db: Connection! // SQLite instance

    private var data: Table! //table instance

    //column instances
    private var id: Expression<String>!
    private var url: Expression<String>!
    private var name: Expression<String>!

    init() {
        do {
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""

            db = try Connection("\(path)/data.sqlite3") // create DB connection

            data = Table("data") // create the table object

            // create instances of each column
            id = Expression<String>("id")
            url = Expression<String>("url")
            name = Expression<String>("name")

            if !UserDefaults.standard.bool(forKey: "isDBCreated") {

                try db.run(data.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(url, unique: true)
                    t.column(name)
                })

                UserDefaults.standard.set(true, forKey: "isDBCreated")
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    public func addData(idValue: String, urlValue: String, nameValue: String) {
        do {
            try db.run(data.insert(id <- idValue, url <- urlValue, name <- nameValue))
        } catch {
            print(error.localizedDescription)
        }
    }

}
