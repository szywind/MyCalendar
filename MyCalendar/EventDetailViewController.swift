//
//  EventDetailViewController.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/4/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    var currentEvent: Event?
    
    @IBOutlet weak var detail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detail.layer.borderColor = UIColor.lightGrayColor().CGColor
        detail.layer.borderWidth = 1.0
        detail.layer.cornerRadius = 5.0
        detail.text = currentEvent!.detail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
