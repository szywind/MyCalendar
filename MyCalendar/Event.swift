//
//  Event.swift
//  MyTutorial
//
//  Created by ShenZhenyuan on 3/4/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import Foundation

class Event: NSObject, NSCoding {
    
    // MARK: Properties
    var title: String
    var date: NSDate
    var time: NSDate
    var duration: Int
    var location: String?
    var detail: String?
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("eventFile.plist")
    
    // MARK: Types
    struct PropertyKey {
        static let titleKey = "eventTitle"
        static let dateKey = "eventDate"
        static let timeKey = "eventTime"
        static let durationKey = "eventDuration"
        static let locationKey = "eventLocation"
        static let detailKey = "eventDetail"
    }
    
    // MARK: Initialization
    init?(_title: String, _date: NSDate, _time: NSDate, _duration: Int, _location: String?, _detail: String?){
        self.title = _title
        self.date = _date
        self.time = _time
        self.duration = _duration
        self.location = _location
        self.detail = _detail
        super.init()
        
        if _title.isEmpty{
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(self.date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(self.time, forKey: PropertyKey.timeKey)
        aCoder.encodeInteger(duration, forKey: PropertyKey.durationKey)
        aCoder.encodeObject(self.location, forKey: PropertyKey.locationKey)
        aCoder.encodeObject(self.detail, forKey: PropertyKey.detailKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let storedTitle = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let storedDate = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        let storedTime = aDecoder.decodeObjectForKey(PropertyKey.timeKey) as! NSDate
        let storedDuration = aDecoder.decodeIntegerForKey(PropertyKey.durationKey)
        
        // use conditional cast for optional properties of Event
        let storedLocation = aDecoder.decodeObjectForKey(PropertyKey.locationKey) as? String
        let storedDetail = aDecoder.decodeObjectForKey(PropertyKey.detailKey) as? String
        
//        guard storedTitle != nil && storedDate != nil && storedTime != nil && storedLocation != nil && storedDetail != nil else {
//            return nil
//        }
        
        self.init(_title: storedTitle, _date: storedDate, _time: storedTime, _duration: storedDuration, _location: storedLocation!, _detail: storedDetail!)
        
        
    }
}