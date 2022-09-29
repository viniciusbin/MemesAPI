//
//  CustomTableViewCell.swift
//  APImemes
//
//  Created by Vinicius on 20/09/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var apiImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
