//
//  FirstViewController.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/3/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import UIKit
import FSCalendar
class FirstViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Calendar")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if (segue.identifier == "createEvent"){
            if let destination = segue.destinationViewController as? CreateEventViewController{
                destination.date = calendar.selectedDate ?? NSDate()
            }
        }
    }


}

