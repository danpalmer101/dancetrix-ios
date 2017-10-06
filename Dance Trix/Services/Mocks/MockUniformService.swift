//
//  MockUniformService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockUniformService: UniformServiceType {
    
    private let childClothesSizes = ["3 - 4 years (Size 0)", "5 - 6 years (Size 1)", "7 - 8 years (Size 1b)", "9 - 10 years (Size 2)", "11 - 13 years (Size 3a)", "Adult Small (Size 3)", "Adult Medium (Size 4)"]
    private let childShoeSizes = ["5", "6", "7", "8", "9", "9.5", "10", "10.5"]
    private let adultClothesSizes = ["Small", "Medium", "Large", "Extra Large"]
    private let adultShoeSizes = ["4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5"]
    private let sockSizes = ["6 - 8.5", "9 - 12", "12.5 - 3"]
    
    func getUniformOrderItems() -> [UniformGroup] {
        // Children's clothes
        return [
            UniformGroup(name: "Order children's clothes", items: [
                UniformItem(key: "child_turquoise_skirted_leotard", name: "Turquoise skirted leotard", sizes: childClothesSizes),
                UniformItem(key: "child_turquoise_leggings", name: "Turquoise leggings", sizes: childClothesSizes),
                UniformItem(key: "child_turquoise_skirt", name: "Turquoise skirt", sizes: childClothesSizes),
                UniformItem(key: "child_dance_trix_branded_hoodie", name: "Dance Trix branded hoodie", sizes: childClothesSizes),
                UniformItem(key: "child_dance_trix_branded_tshirt", name: "Dance Trix branded t-shirt", sizes: childClothesSizes),
                UniformItem(key: "child_black_high_neck_leotard", name: "Black high neck leotard", sizes: childClothesSizes)
            ]),
            UniformGroup(name: "Order children's shoes", items: [
                UniformItem(key: "child_shoes_tap_white", name: "White tap shoes", sizes: childShoeSizes),
                UniformItem(key: "child_shoes_tap_black", name: "Black tap shoes", sizes: childShoeSizes),
                UniformItem(key: "child_pink_ballet_shoes", name: "Pink ballet shoes", sizes: childShoeSizes)
            ]),
            UniformGroup(name: "Order adult's clothes", items: [
                UniformItem(key: "adult_dance_trix_hoodie", name: "Dance Trix branded hoodie", sizes: adultClothesSizes),
                UniformItem(key: "adult_dance_trix_tshirt", name: "Dance Trix branded t-shirt", sizes: adultClothesSizes)
            ]),
            UniformGroup(name: "Order adult's shoes", items: [
                UniformItem(key: "adult_shoes_tap", name: "Tap shoes", sizes: adultShoeSizes),
                UniformItem(key: "adult_shoes_ballet", name: "Ballet shoes", sizes: adultShoeSizes)
            ]),
            UniformGroup(name: "Order other items", items: [
                UniformItem(key: "pink_ballet_socks", name: "Pink ballet socks", sizes: sockSizes),
                UniformItem(key: "child_ballet_bag", name: "Child's ballet bag", sizes: []),
                UniformItem(key: "adult_ballet_bag", name: "Adult's ballet bag", sizes: []),
                UniformItem(key: "child_ballet_purse", name: "Child's ballet purse", sizes: []),
                UniformItem(key: "exam_headband", name: "Exam headband", sizes: [])
            ])
        ]
    }
    
    func orderUniform(name: String,
                      studentName: String,
                      email: String,
                      package: String?,
                      paymentMade: Bool,
                      paymentMethod: String,
                      additionalInfo: String?,
                      orderItems: [UniformItem : String?],
                      successHandler: @escaping () -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock uniform order...")
            
            orderItems.forEach { (arg: (key: UniformItem, value: String?)) in
                let (key, size) = arg
                
                log.info("    \(key.name) - size: \(size ?? "N/A")")
            }
            
            sleep(2)
            
            log.info("...uniform order complete")
            
            successHandler()
        }
    }
    
}
