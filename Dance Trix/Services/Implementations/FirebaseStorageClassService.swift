//
//  FirebaseStorageClassService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import FirebaseStorage

class FirebaseStorageClassService : ClassServiceType {
    
    func getClassMenu(successHandler: @escaping (ClassMenu) -> Void, errorHandler: @escaping (Error) -> Void) {
        let classesMenuCsv = Storage.storage().reference().child("classes/menu.csv")
        
        log.info("Retrieving class menu...")
        
        log.debug("    Downloading classes/menu.csv from Firebase storage")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        classesMenuCsv.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                log.warning("    An error occurred downloading the CSV file")
                errorHandler(error)
            } else {
                log.debug("    Downloaded classes/menu.csv from Firebase storage")
                
                let csvString = String(data: data!, encoding: String.Encoding.utf8)
                
                log.debug("    Parsing classes/menu.csv")
                let classMenu = ClassMenuParser.parse(csvString: csvString!)
                log.debug("    Parsed classes/menu.csv")
                
                log.info("...Retrieved class menu")
                
                successHandler(classMenu)
            }
        }
    }
    
    func getClassDates(_ classDetails: Class, successHandler: @escaping ([DateInterval]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let classesMenuCsv = Storage.storage().reference().child(classDetails.datesLocation)
        
        log.info(String(format: "Retrieving dates for %@...", classDetails.name))
        
        log.debug(String(format: "    Downloading %@ from Firebase storage", classDetails.datesLocation))
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        classesMenuCsv.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                log.warning("    An error occurred downloading the CSV file")
                errorHandler(error)
            } else {
                log.debug(String(format: "    Downloaded %@ from Firebase storage", classDetails.datesLocation))
                
                let csvString = String(data: data!, encoding: String.Encoding.utf8)
                
                log.debug("    Parsing CSV")
                let dates = ClassDatesParser.parse(csvString: csvString!)
                log.debug("    Parsed CSV")
                
                log.info(String(format: "...retrieved dates for %@...", classDetails.name))
                
                successHandler(dates)
            }
        }
    }
    
}
