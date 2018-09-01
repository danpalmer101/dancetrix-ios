//
//  UniformParserTest.swift
//  Dance Trix Tests
//
//  Created by Daniel Palmer on 01/09/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import XCTest
import SwiftyBeaver

let log = SwiftyBeaver.self

class UniformParserTest: XCTestCase {
    
    func testParse() {
        let expectedGroup = [UniformGroup(name: "test",
                                         items: [
                                            UniformItem(key: "a", name: "b", sizes: ["1", "2", "3", "4"]),
                                            UniformItem(key: "c", name: "d", sizes: [])
                                            ])]
        
        let parsedGroup = UniformParser.parse(
            csvString: "Format,Section,ID,Name,Sizes\nV1,test,a,b,1|2|3|4\nV1,test,c,d,")
        
        assert(parsedGroup == expectedGroup, "Parsed group does not equal expected group")
    }

}
