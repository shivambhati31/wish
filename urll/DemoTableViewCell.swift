//
//  DemoTableViewCell.swift
//  urll
//
//  Created by Ritesh Harihar on 15/02/22.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

    @IBOutlet var myLabel : UILabel!
    @IBOutlet var myImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
