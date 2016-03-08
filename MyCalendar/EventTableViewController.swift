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
   
    var tmp_events = [Event]()
        
    func setEditButton(){
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        historyView.dataSource = self
//        historyView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        setEditButton()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:", name:"load", object: nil)
        
        // Try loading a saved version first
        if let savedEvents = loadEvents() {
//            events += savedEvents
            events = savedEvents
            tmp_events = filterTodayEvent(events)
            
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
        return tmp_events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as? EventTableViewCell
        // Configure the cell...
        // let currentEvent = events[indexPath.row]
        
        //let tmp_events = filterTodayEvent(events)
        
        var sortedEvents = tmp_events.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedDescending })
        let currentEvent = sortedEvents[indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        //dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC");
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        let startDate = currentEvent.date
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let shortDate = dateFormatter.stringFromDate(startDate)
       
        dateFormatter.dateFormat = "HH:mm"
        let shortTime = dateFormatter.stringFromDate(startDate)
        
        let endDate = startDate.dateByAddingTimeInterval(Double(currentEvent.duration) * 60.0)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let endDateString = dateFormatter.stringFromDate(endDate)
        
        cell!.startTime.text = shortTime
        cell!.startDate.text = shortDate
        cell!.title.text = currentEvent.title
        cell!.end.text = endDateString
        cell!.location.text = currentEvent.location
        
        let now = NSDate()
        
        let timeToStart = NSCalendar.currentCalendar().compareDate(now, toDate: startDate,
            toUnitGranularity: .Minute)
        
        let timeToEnd = NSCalendar.currentCalendar().compareDate(now, toDate: endDate,
            toUnitGranularity: .Minute)
        
        if timeToStart != .OrderedDescending{
            cell!.backgroundColor = UIColor(colorLiteralRed: 0, green: 0xFF, blue: 0, alpha: 0.5)
        } else if(timeToEnd != .OrderedDescending){
            cell!.backgroundColor = UIColor(colorLiteralRed: 0xFF, green: 0xFF, blue: 0, alpha: 0.5)
        } else{
            cell!.backgroundColor = UIColor(colorLiteralRed: 0xFF, green: 0, blue: 0, alpha: 0.5)
        }
        
//        switch timeToStart {
//        case .OrderedDescending:
//            print("DESCENDING")
//        case .OrderedAscending:
//            print("ASCENDING")
//        case .OrderedSame:
//            print("SAME")
//        }
        
        
        
        
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
            tmp_events.removeAtIndex(indexPath.row)
            events.removeAtIndex(indexPath.row)
            saveEvents()
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
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
    
    
    func loadList(notification: NSNotification){
        //load data here
        events = loadEvents()!
        tmp_events = filterTodayEvent(events)

        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        events = loadEvents()!
        tmp_events = filterTodayEvent(events)
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func filterTodayEvent(allEvents: [Event])->[Event]{
        
        return allEvents
    }
    
}
