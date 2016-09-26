//
//  IndexViewControllerCell.swift
//  voz4rum ios
//
//  Created by BAULOC on 7/14/16.
//  Copyright © 2016 BAU LOC. All rights reserved.
//

import UIKit

class IndexViewControllerCell: UITableViewCell {
    
    @IBOutlet weak var lblHeader: UILabel?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblViewing: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure( info: IndexRecord ) {
        
        if info.is_header {
            lblHeader?.text = info.title
            
        } else {
            lblTitle?.text  = info.title
            lblViewing.text = info.viewing
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
