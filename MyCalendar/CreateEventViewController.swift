//
//  CreateEventViewController.swift
//  MyCalendar
//
//  Created by ShenZhenyuan on 3/3/16.
//  Copyright © 2016 ShenZhenyuan. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    var event:Event?
    
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var durationText: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var whereText: UITextField!
    @IBOutlet weak var whatText: UITextField!
    @IBOutlet weak var detailText: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    func createEvent(){
        let time = datePicker.calendar
        let duration = Int(durationText.text!)
        let location = whereText.text
        let title = whatText.text
        let detail = detailText.text
        event = Event(_title: title!, _date: "abc", _time: time, _duration: duration!, _location: location!,_detail:  detail!)
    }
    
    @IBAction func onFinished(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Notification", message: "Do you want to finish creating event.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
            self.createEvent()
        }
        alertController.addAction(OKAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func onChangeValue(sender: UISlider) {
        let intensity = Int(round(slider.value))
        durationText.text = String(intensity)
    }

    @IBAction func onChangeText(sender: UITextField) {
        if let intensity = Float(durationText.text!){
            slider.value = intensity
        }
    }
}
