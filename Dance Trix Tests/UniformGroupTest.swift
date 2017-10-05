//
//  UniformGroupTest.swift
//  Dance Trix Tests
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import XCTest
import SwiftyBeaver

let log = SwiftyBeaver.self

class UniformGroupTest: XCTestCase {
    
    func testJsonInitializer() {
        let expectedGroup = UniformGroup(name: "test",
                                         items: [
                                            UniformItem(key: "a", name: "b", sizes: ["1", "2", "3", "4"]),
                                            UniformItem(key: "c", name: "d", sizes: [])
                                            ])
        
        let parsedGroup = UniformGroup(json: [
                                        "name" : "test",
                                        "items" : [
                                            [ "key" : "a", "name" : "b", "sizes" : ["1", "2", "3", "4"] ],
                                            [ "key" : "c", "name" : "d" ]
                                        ]
                                    ])
        
        assert(parsedGroup == expectedGroup, "Parsed group does not equal expected group")
    }

}
