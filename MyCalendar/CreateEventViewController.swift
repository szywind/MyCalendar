//
//  CreateEventViewController.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/3/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var event:Event?
    
    var eventList = [Event]()
    
    var date: NSDate?
    
    let placeHolderText = "Enter event descriptions ..."
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var durationText: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var whatText: UITextField!
    @IBOutlet weak var whereText: UITextField!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    func createEvent(){
        
        let time = datePicker.date
        let duration = Int(durationText.text!)
        let title = whatText.text
        let detail = detailText.text
        var location = whereText.text
        
        // combine picked date and chosen time
        let startDate = combineDateWithTime(self.date!, time: time)
        
        if location == ""{
            location = "NA"
        }
        event = Event(_title: title!, _date: startDate!, _duration: duration!, _location: location, _detail:  detail!)
    }
    
//    func saveEvent(){
//        var eventList = loadEvents()
//        if (eventList != nil){
//            print("number of events:", eventList!.count)
//            eventList?.append(event!)
//            saveEvents(eventList!)
//        } else {
//            // Create a new Course List
//            //let eventList: EventCollection = EventCollection(items: [event!])
//            var events = [Event]()
//            events.append(event!)
//            saveEvents(events)
//        }
//        
//    }
    
    @IBAction func onFinished(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Notification", message: "Do you want to finish creating event.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
            self.createEvent()
            self.eventList.append(self.event!)
            self.saveEvents()
            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.saveEvents()
//            })
            
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
            
            self.navigationController!.popToRootViewControllerAnimated(true)
            
            
            //self.view.window!.rootViewController!.navigationController!.popViewControllerAnimated(true)  // for push/show
            //self.dismissViewControllerAnimated(true, completion:nil) // for modal
        }
        alertController.addAction(OKAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let savedEvents = loadEvents() {
            eventList += savedEvents
        }
        
        checkValidEventInfo()
        
        detailText.layer.borderColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).CGColor
        detailText.layer.borderWidth = 0.5
        detailText.layer.cornerRadius = 5.0
        detailText.text = placeHolderText
        detailText.textColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
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

    // dismiss input keyboard when pressing return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.view.frame.origin.y -= 150
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        self.view.frame.origin.y += 150
        return true
    }


    // text view delegate
//    func keyboardWasShown(aNotifcation: NSNotification) {
//        
//        let info = aNotifcation.userInfo as NSDictionary?
//        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
//        let rect = rectValue.CGRectValue()
//        
//        let contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0)
//        detailText.contentInset = contentInsets
//        detailText.scrollIndicatorInsets = contentInsets
//        
//        // optionally scroll
//        var aRect = detailText.superview!.frame
//        aRect.size.height -= kbSize.height
//        let targetRect = CGRectMake(0, 0, 10, 10) // get a relevant rect in the text view
//        if !aRect.contains(targetRect.origin) {
//            detailText.scrollRectToVisible(targetRect, animated: true)
//        }
//    }
    
    func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let rect = rectValue.CGRectValue()

        
                let contentInsets = UIEdgeInsetsMake(0, 0, rect.height, 0)
                detailText.contentInset = contentInsets
                detailText.scrollIndicatorInsets = contentInsets
        
                // optionally scroll
                var aRect = detailText.superview!.frame
                aRect.size.height -= rect.height
                let targetRect = CGRectMake(0, 0, 10, 10) // get a relevant rect in the text view
                if !aRect.contains(targetRect.origin) {
                    detailText.scrollRectToVisible(targetRect, animated: true)
                }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let rect = rectValue.CGRectValue()
        var frame = detailText.frame;
        frame.origin.y = frame.origin.y + rect.height;
        detailText.frame = frame;
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        self.view.frame.origin.y -= 150
        //NSNotificationCenter.defaultCenter().postNotificationName("keyboardWillShow", object: nil)
        detailText.textColor = UIColor.blackColor()
        
        if(detailText.text == placeHolderText) {
            detailText.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.view.frame.origin.y += 150
        //NSNotificationCenter.defaultCenter().postNotificationName("keyboardWillHide", object: nil)
        if(textView.text == "") {
            detailText.text = placeHolderText
            detailText.textColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        }
    }
    

    @IBAction func onChangeValue(sender: UISlider) {
        let intensity = Int(round(slider.value))
        durationText.text = String(intensity)
    }

    @IBAction func onChangeText(sender: UITextField) {
        if let intensity = Float(durationText.text!){
            slider.value = intensity
        }
    }
    
    func checkValidEventInfo() {
        // Disable the Save button if the text field is empty.
        let text = whatText.text ?? ""
        doneButton.enabled = !text.isEmpty
    }
    
    func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(eventList, toFile: Event.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save events...")
        }
    }
    
    
    func loadEvents() -> [Event]? {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("events")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidEventInfo()
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
        
}
