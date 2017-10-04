//
//  MockClassService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockClassService: ClassServiceType {
    
    var classMenuCache: ClassMenu?
    var datesCache = [Class : [DateInterval]]()
    var descCache = [Class : String]()
    
    func getClassMenu(successHandler: @escaping (ClassMenu) -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock class menu retrieval...")
            
            var menu = self.classMenuCache
            
            if (menu == nil) {
                sleep(1)
                
                log.debug("    Generating menu")
                
                if let path = Bundle.main.path(forResource: "classes", ofType: "csv") {
                    let csvString = try! String(contentsOfFile: path)
                    menu = ClassMenuParser.parse(csvString: csvString)
                }
                
                self.classMenuCache = menu
            }
            
            if (menu == nil) {
                log.warning("...Unable to load mock classes")
                errorHandler(ClassesError.noClasses)
            } else {
                log.info("...mock class menu retrieved")
                successHandler(menu!)
            }
        }
    }
    
    func getClassDates(_ classDetails: Class,
                       successHandler: @escaping ([DateInterval]) -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info(String(format: "Mock class date retrieval for %@...", classDetails.name))
            
            var dates = self.datesCache[classDetails]
            
            if (dates == nil) {
                sleep(1)
                
                log.debug(String(format: "    Generating dates for %@", classDetails.name))
                
                if let path = Bundle.main.path(forResource: classDetails.datesLocation, ofType: "csv") {
                    let csvString = try! String(contentsOfFile: path)
                    dates = ClassDatesParser.parse(csvString: csvString)
                }
                
                self.datesCache[classDetails] = dates
            }
            
            if (dates == nil) {
                log.warning("...Unable to load mock class dates")
                errorHandler(ClassesError.noClassDates(classDetails: classDetails))
            } else {
                log.info(String(format: "...mock dates retrieved for %@", classDetails.name))
                successHandler(dates!)
            }
        }
    }
    
    func getClassDescription(_ classDetails: Class,
                             successHandler: @escaping (String) -> Void,
                             errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info(String(format: "Mock class date retrieval for %@...", classDetails.name))
            
            var desc = self.descCache[classDetails]
            
            if (desc == nil) {
                sleep(1)
                
                log.debug(String(format: "    Reading description for %@", classDetails.name))
                
                if let path = Bundle.main.path(forResource: classDetails.descriptionLocation, ofType: "txt") {
                    desc = try! String(contentsOfFile: path)
                }
                
                self.descCache[classDetails] = desc
            }
            
            if (desc == nil) {
                log.warning("...Unable to load mock class description")
                errorHandler(ClassesError.noClassDescription(classDetails: classDetails))
            } else {
                log.info(String(format: "...mock description retrieved for %@", classDetails.name))
                successHandler(desc!)
            }
        }
    }
    
}
