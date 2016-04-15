//
//  MealTableViewCell.swift
//  Buzz Movie iOS
//
//  Created by localadmin on 4/14/16.
//  Copyright © 2016 2b||!2b. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ratingControl: TableRatingControl!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
