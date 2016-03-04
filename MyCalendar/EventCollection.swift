//
//  EventCollection.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/4/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//


import Foundation

class EventCollection: NSObject, NSCoding {
    
    var items: [Event]
//    let sourceURL: NSURL
    
    init (items newItems: [Event]) {
        self.items = newItems
//        self.sourceURL = newURL
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.items, forKey: "feedItems")
//        aCoder.encodeObject(self.sourceURL, forKey: "feedSourceURL")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let storedItems = aDecoder.decodeObjectForKey("feedItems") as? [Event]
//        let storedURL = aDecoder.decodeObjectForKey("feedSourceURL") as? NSURL
        
        guard storedItems != nil else {
            return nil
        }
        self.init(items: storedItems!)
        
    }
    
    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "eventList")
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("eventList")
    }
    
    class func loadSaved() -> EventCollection? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("EventList") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? EventCollection
        }
        return nil
    }

    func populateCourses() {
        self.items = [Event]()
    }
}