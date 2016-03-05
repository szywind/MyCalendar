//
//  Event.swift
//  MyTutorial
//
//  Created by ShenZhenyuan on 3/4/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import Foundation

class Event: NSObject, NSCoding {
    var title: String
    var date: NSDate
    var time: NSDate
    var duration: Int
    var location: String
    var detail: String
    
    init (_title: String, _date: NSDate, _time: NSDate, _duration: Int, _location: String, _detail: String){
        self.title = _title
        self.date = _date
        self.time = _time
        self.duration = _duration
        self.location = _location
        self.detail = _detail
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "eventTitle")
        aCoder.encodeObject(self.date, forKey: "eventDate")
        aCoder.encodeObject(self.time, forKey: "eventTime")
        aCoder.encodeObject(self.duration, forKey: "eventDuration")
        aCoder.encodeObject(self.location, forKey: "eventLocation")
        aCoder.encodeObject(self.detail, forKey: "eventDetail")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let storedTitle = aDecoder.decodeObjectForKey("eventTile") as? String
        let storedDate = aDecoder.decodeObjectForKey("eventDate") as? NSDate
        let storedTime = aDecoder.decodeObjectForKey("eventTime") as? NSDate
        let storedDuration = aDecoder.decodeIntegerForKey("eventDuration")
        let storedLocation = aDecoder.decodeObjectForKey("eventLocation") as? String
        let storedDetail = aDecoder.decodeObjectForKey("eventDetail") as? String
        
        guard storedTitle != nil && storedDate != nil && storedTime != nil && storedLocation != nil && storedDetail != nil else {
            return nil
        }
        self.init(_title: storedTitle!, _date: storedDate!, _time: storedTime!, _duration: storedDuration, _location: storedLocation!, _detail: storedDetail!)
        
        
    }
}