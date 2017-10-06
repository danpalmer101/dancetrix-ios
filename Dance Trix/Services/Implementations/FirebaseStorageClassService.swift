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
        let csvName = "classes.csv"
        let classesMenuCsv = Storage.storage().reference().child(csvName)
        
        log.info("Retrieving class menu...")
        
        log.debug("    Downloading CSV from Firebase storage: \(csvName)")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        classesMenuCsv.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                log.warning(["...failed to retrieve class menu", error])
                errorHandler(error)
            } else {
                log.debug("    Downloaded CSV from Firebase storage:\(csvName)")
                
                let csvString = String(data: data!, encoding: String.Encoding.utf8)
                
                log.debug("    Parsing CSV: \(csvName)")
                let classMenu = ClassMenuParser.parse(csvString: csvString!)
                log.debug("    Parsed CSV: \(csvName)")
                
                log.info("...Retrieved class menu")
                
                successHandler(classMenu)
            }
        }
    }
    
    func getClassDates(_ classDetails: Class,
                       successHandler: @escaping ([DateInterval]) -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        let classesMenuCsv = Storage.storage().reference().child(classDetails.datesLocation)
        
        log.info("Retrieving dates for \(classDetails.name)...")
        
        log.debug("    Downloading CSV from Firebase storage: \(classDetails.datesLocation)")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        classesMenuCsv.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                log.warning(["    An error occurred downloading the CSV file: \(classDetails.datesLocation)", error])
                errorHandler(error)
            } else {
                log.debug("    Downloaded CSV from Firebase storage: \(classDetails.datesLocation)")
                
                let csvString = String(data: data!, encoding: String.Encoding.utf8)
                
                log.debug("    Parsing CSV: \(classDetails.datesLocation)")
                let dates = ClassDatesParser.parse(csvString: csvString!)
                log.debug("    Parsed CSV: \(classDetails.datesLocation)")
                
                log.info("...retrieved dates for \(classDetails.name)")
                
                successHandler(dates)
            }
        }
    }
    
    func getClassDescription(_ classDetails: Class,
                             successHandler: @escaping (String) -> Void,
                             errorHandler: @escaping (Error) -> Void) {
        let classesMenuCsv = Storage.storage().reference().child(classDetails.descriptionLocation)
        
        log.info("Retrieving description for \(classDetails.name)...")
        
        log.debug("    Downloading text from Firebase storage: \(classDetails.descriptionLocation)")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        classesMenuCsv.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                log.warning(["    An error occurred downloading the text file: \(classDetails.descriptionLocation)", error])
                errorHandler(error)
            } else {
                log.debug("    Downloaded text from Firebase storage: \(classDetails.descriptionLocation)")
                
                let descriptionText = String(data: data!, encoding: String.Encoding.utf8)
                
                successHandler(descriptionText!)
            }
        }
    }
    
}
