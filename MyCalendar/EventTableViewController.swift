//
//  EventTableViewController.swift
//  MyTutorial
//
//  Created by ShenZhenyuan on 3/4/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    var events = [Event]()
   
//    @IBOutlet var historyView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        historyView.dataSource = self
//        historyView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:", name:"load", object: nil)
        
        // Try loading a saved version first
        if let savedEvents = loadEvents() {
//            events += savedEvents
            events = savedEvents

            print("loaded Save EventList")
        }
        
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as? EventTableViewCell
        // Configure the cell...
        let currentEvent = events[indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        //dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC");
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let shortDate = dateFormatter.stringFromDate(currentEvent.date)
       
        dateFormatter.dateFormat = "HH:mm"
        let shortTime = dateFormatter.stringFromDate(currentEvent.time)
        
        
        let startDate = combineDateWithTime(currentEvent.date, time: currentEvent.time)
        let endDate = startDate!.dateByAddingTimeInterval(Double(currentEvent.duration) * 60.0)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let endDateString = dateFormatter.stringFromDate(endDate)
        
        cell!.startTime.text = shortTime
        cell!.startDate.text = shortDate
        cell!.title.text = currentEvent.title
        cell!.end.text = endDateString
        cell!.location.text = currentEvent.location
        
        print(NSDateFormatter.localizedStringFromDate(currentEvent.date, dateStyle: .FullStyle, timeStyle: NSDateFormatterStyle.FullStyle))
        return cell!
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            events.removeAtIndex(indexPath.row)
            saveEvents()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let detailScene = segue.destinationViewController as? EventDetailViewController

        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow{
            let selectedEvent = events[indexPath.row]
            detailScene?.currentEvent = selectedEvent
        }
    }
    
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save events...")
        }
    }
    
    func loadEvents() -> [Event]? {
        if let temp = NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]{
            return temp
        } else {
            return nil
        }
        
    }
    
    func combineDateWithTime(date: NSDate, time: NSDate) -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponents = calendar.components([.Year, .Month, .Day], fromDate: date)
        let timeComponents = calendar.components([.Hour, .Minute, .Second], fromDate: time)
        
        let mergedComponments = NSDateComponents()
        mergedComponments.year = dateComponents.year
        mergedComponments.month = dateComponents.month
        mergedComponments.day = dateComponents.day
        mergedComponments.hour = timeComponents.hour
        mergedComponments.minute = timeComponents.minute
        
        print("foo", timeComponents.hour, timeComponents.minute, timeComponents.second)
        print("bar", mergedComponments.hour, mergedComponments.minute, mergedComponments.second)
        mergedComponments.second = timeComponents.second
        
        return calendar.dateFromComponents(mergedComponments)
    }
    
    func loadList(notification: NSNotification){
        //load data here
        events = loadEvents()!
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        events = loadEvents()!
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
}
