//
//  MockOrderService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockOrderService: OrderServiceType {
    
    private let childClothesSizes = ["3 - 4 years (Size 0)", "5 - 6 years (Size 1)", "7 - 8 years (Size 1b)", "9 - 10 years (Size 2)", "11 - 13 years (Size 3a)", "Adult Small (Size 3)", "Adult Medium (Size 4)"]
    private let childShoeSizes = ["5", "6", "7", "8", "9", "9.5", "10", "10.5"]
    private let adultClothesSizes = ["Small", "Medium", "Large", "Extra Large"]
    private let adultShoeSizes = ["4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5"]
    private let sockSizes = ["6 - 8.5", "9 - 12", "12.5 - 3"]
    
    func getUniformOrderItems() -> [(String, [(String, String, [String])])] {
        // Children's clothes
        return [
            ("Order children's clothes", [
                ("child_turquoise_skirted_leotard", "Turquoise skirted leotard", childClothesSizes),
                ("child_turquoise_leggings", "Turquoise leggings", childClothesSizes),
                ("child_turquoise_skirt", "Turquoise skirt", childClothesSizes),
                ("child_dance_trix_branded_hoodie", "Dance Trix branded hoodie", childClothesSizes),
                ("child_dance_trix_branded_tshirt", "Dance Trix branded t-shirt", childClothesSizes),
                ("child_black_high_neck_leotard", "Black high neck leotard", childClothesSizes)
            ]),
            ("Order children's shoes", [
                ("child_shoes_tap_white", "White tap shoes", childShoeSizes),
                ("child_shoes_tap_black", "Black tap shoes", childShoeSizes),
                ("child_pink_ballet_shoes", "Pink ballet shoes", childShoeSizes)
            ]),
            ("Order adult's clothes", [
                ("adult_dance_trix_hoodie", "Dance Trix branded hoodie", adultClothesSizes),
                ("adult_dance_trix_tshirt", "Dance Trix branded t-shirt", adultClothesSizes)
            ]),
            ("Order adult's shoes", [
                ("adult_shoes_tap", "Tap shoes", adultShoeSizes),
                ("adult_shoes_ballet", "Ballet shoes", adultShoeSizes)
            ]),
            ("Order other items", [
                ("pink_ballet_socks", "Pink ballet socks", sockSizes),
                ("child_ballet_bag", "Child's ballet bag", []),
                ("adult_ballet_bag", "Adult's ballet bag", []),
                ("child_ballet_purse", "Child's ballet purse", []),
                ("exam_headband", "Exam headband", [])
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
                      orderItems: [String : String?],
                      successHandler: @escaping () -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock uniform order...")
            
            orderItems.forEach { (arg: (key: String, value: String?)) in
                let (key, size) = arg
                
                log.info(String(format: "    %@ - size: %@",
                                key,
                                size ?? "N/A"))
            }
            
            sleep(2)
            
            log.info("...uniform order complete")
            
            successHandler()
        }
    }
    
}
