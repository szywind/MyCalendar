//
//  EventCollection.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/4/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//


import Foundation

class EventCollection: NSObject, NSCoding {
    
    var items: [Event]?
    
//    override init() {}
    
    init (items newItems: [Event]) {
        self.items = newItems
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.items, forKey: "feedItems")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let storedItems = aDecoder.decodeObjectForKey("feedItems") as? [Event]
        
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
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("eventList") as? NSData {
            var ttt = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? EventCollection
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? EventCollection
        }
        return nil
    }

    func populateCourses() {
        self.items = [Event]()
    }
}