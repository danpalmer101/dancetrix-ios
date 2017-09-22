//
//  Dance_Trix_Tests.swift
//  Dance Trix Tests
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import XCTest

class Dance_Trix_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClassMenuParser() {
        let classMenu = ClassMenuParser.parse(serviceNames: ["Hello|World|1","Hello|World|2","Hello|Earth"])
        
        assert(classMenu.name == "Classes")
        assert(classMenu.classDetails == nil)
        assert(classMenu.children?.count == 1)
        assert(classMenu.children?[0].name == "Hello")
        assert(classMenu.children?[0].children?[0].name == "Earth")
        assert(classMenu.children?[0].children?[1].name == "World")
        assert(classMenu.children?[0].children?[1].children?[0].name == "1")
        assert(classMenu.children?[0].children?[1].children?[1].name == "2")
    }

}
