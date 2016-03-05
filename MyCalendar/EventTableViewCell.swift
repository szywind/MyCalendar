//
//  EventTableViewCell.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/5/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var startDate: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var end: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
