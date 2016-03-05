////
////  EventCollection.swift
////  MyCalendar
////
////  Created by ShenZhenyuan on 3/4/16.
////  Copyright © 2016 ShenZhenyuan. All rights reserved.
////
//
//
//import Foundation
//
//class EventCollection: NSObject, NSCoding {
//    
//    var items: [Event]?
//    
////    override init() {}
//    
//    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("eventList")
//
//    
//    init (items newItems: [Event]) {
//        self.items = newItems
//        super.init()
//    }
//    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(self.items, forKey: "feedItems")
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        
//        let storedItems = aDecoder.decodeObjectForKey("feedItems") as? [Event]
//        
//        guard storedItems != nil else {
//            return nil
//        }
//        self.init(items: storedItems!)
//        
//    }
//    
//    func save() {
//        let data = NSKeyedArchiver.archiveRootObject(self, toFile: EventCollection.ArchiveURL.path!)
//        if !data {
//            print("Failed to save meals...")
//        }
////        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "eventList")
//    }
//    
////    func clear() {
////        NSUserDefaults.standardUserDefaults().removeObjectForKey("eventList")
////    }
//    
//    class func loadSaved() -> EventCollection? {
//        if let savedEvent = NSKeyedUnarchiver.unarchiveObjectWithFile(EventCollection.ArchiveURL.path!) as? EventCollection {
//            return savedEvent
//        }else{
//            return nil
//        }
//        
//    }
//
//    func populateCourses() {
//        self.items = [Event]()
//    }
//}