//
//  TableViewCellController.swift
//  tableview
//
//  Created by yzh on 2020/12/4.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class TableViewCellController: UITableViewCell {



    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
