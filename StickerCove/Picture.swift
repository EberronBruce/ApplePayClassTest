//
//  Picture.swift
//  StickerCove
//
//  Created by Bruce Burgess on 12/24/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class Picture {
    var name = ""
    var price = ""
    var image = UIImage()
    
    static func createPictures() -> [Picture] {
        let geisha = Picture()
        geisha.name = "No Evil Geisha"
        geisha.price = "4.99"
        if let geishaImage = UIImage(named: "geisha") {
            geisha.image = geishaImage
        }
        
        let korea = Picture()
        korea.name = "Korean Men"
        korea.price = "1.99"
        if let koreaImage = UIImage(named: "korean") {
            korea.image = koreaImage
        }
        
        let girls = Picture()
        girls.name = "Little Viet Girls"
        girls.price = "2.99"
        if let girlsImage = UIImage(named: "girls") {
            girls.image = girlsImage
        }
        
        return [geisha, korea, girls]
    }
}
