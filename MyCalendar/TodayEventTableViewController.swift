//
//  TodayEventTableViewController.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/8/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import UIKit

class TodayEventTableViewController: EventTableViewController {

    var date: NSDate?
    
    var eventsIndex = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if (segue.identifier == "createEvent2"){
            // Pass the selected object to the new view controller.
            if let destination = segue.destinationViewController as? CreateEventViewController{
                destination.date = self.date
            }
        }
    }
    
    override func filterTodayEvent(allEvents: [Event])->[Event]{
        if eventsIndex.count > 0 {
            eventsIndex = [Int]()
            assert(eventsIndex.count == 0)
        }
        var todayEvent = [Event]()
        var i = 0
        for event in allEvents{
            let isSameDay = NSCalendar.currentCalendar().isDate(event.date, inSameDayAsDate: self.date!)
            if isSameDay {
                todayEvent.append(event)
                eventsIndex.append(i)
            }
            i++
        }
        return todayEvent
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tmp_events.removeAtIndex(indexPath.row)
            events.removeAtIndex(eventsIndex[indexPath.row])
            saveEvents()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    override func setEditButton(){}
}
