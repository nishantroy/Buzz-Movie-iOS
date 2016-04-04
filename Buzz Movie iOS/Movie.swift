//
//  Movie.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/3/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit

class Movie : NSObject, NSCoding {
    //MARK: Properties
    
    var name: String
    var rating: Int
    var image: UIImage?



    init?(name: String, rating: Int, image: UIImage?) {
        self.name = name
        self.rating = rating
        self.image = image
        super.init()
        
        if (name.isEmpty || rating < 0) {
            return nil
        }
        
        
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("movies")
    
    //MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let imageKey = "image"
        static let ratingKey = "rating"
    }
    
    
    //MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        self.init(name: name, rating: rating, image: image)
    }
}



