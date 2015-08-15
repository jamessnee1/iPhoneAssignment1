//
//  CinemaDetailViewController.swift
//  SwiftAssignment1
//
//  Created by James Snee on 31/03/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation

class CinemaDetailViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet var cinemaDesc: UILabel!
    @IBOutlet var cinemaAddress: UILabel!
    @IBOutlet var playing: UILabel!
    @IBOutlet var moviePicker: UIPickerView!
    @IBOutlet var numTicketsLabel: UILabel!
    @IBOutlet var numTicketsSentence: UILabel!
    @IBOutlet var ticketsStepper: UIStepper!
    
    //sound for buttons
    var click = AVAudioPlayer()

    var movieSelected = String()
    
    var cinemaDescText = String()
    var cinemaAddressText = String()
    var cinemaSelected = String()
    var currNumOfTickets = 1
    var moviesPlaying = [String]()
    
    var itemSelected = String()
    
    
    //pickerview methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        
        return moviesPlaying.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView) -> UIView! {
        
        //set picker view font and font size
        var pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.grayColor()
        pickerLabel.font = UIFont(name:"Helvetica", size: 10)
        pickerLabel.text = moviesPlaying[row]
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        itemSelected = moviesPlaying[row]
        println("Current item: \(itemSelected)")
        //update the global cinema selected and time selected for booking information
        movieSelected = moviesPlaying[row]
        
        
    }
    

    @IBAction func bookMovieButton(sender: UIButton) {
        
        click.prepareToPlay()
        click.play()
        
        //create new dialog box with our information in it
        var booked = UIAlertController(title: "Booking", message: "Successfully booked movie with the following:\nMovie: \(movieSelected)\nCinema: \(cinemaSelected)\nNumber of tickets: \(currNumOfTickets)", preferredStyle: UIAlertControllerStyle.Alert)
        booked.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(booked, animated: true, completion: nil)

        
        
    }
    
    @IBAction func numTicketsStepper(sender: UIStepper) {
        
        click.prepareToPlay()
        click.play()
        
        numTicketsLabel.text = Int(sender.value).description
        //assign the currNumOfTickets
        currNumOfTickets = Int(sender.value)
        println(currNumOfTickets)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numTicketsLabel.text = String(currNumOfTickets)
        
        //set initial pickerview item to first one in array
        itemSelected = moviesPlaying[0]
        movieSelected = moviesPlaying[0]

        
        //sound URL
        var clickSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click", ofType: "aif")!)
        click = AVAudioPlayer(contentsOfURL:clickSound, error: nil)
        
        //set passed in variables to the labels
        cinemaDesc.text = cinemaDescText
        cinemaAddress.text = "Address: \(cinemaAddressText)"
        cinemaDesc.alpha = 0.0
        cinemaAddress.alpha = 0.0
        playing.alpha = 0.0
        moviePicker.alpha = 0.0
        numTicketsLabel.alpha = 0.0
        numTicketsSentence.alpha = 0.0
        ticketsStepper.alpha = 0.0
        
        cinemaSelected = self.title!
        currNumOfTickets = 1
        
        UIView.animateWithDuration(1.0, animations: { ()->Void  in
            self.cinemaDesc.alpha = 1.0
            self.numTicketsSentence.alpha = 1.0
            self.numTicketsLabel.alpha = 1.0
        })
        
        UIView.animateWithDuration(1.5, animations: { ()->Void  in
            self.cinemaAddress.alpha = 1.0
            self.moviePicker.alpha = 1.0
            self.ticketsStepper.alpha = 1.0
        })
        
        UIView.animateWithDuration(2.0, animations: { ()->Void  in
            self.playing.alpha = 1.0
        })



        
        
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
    
}
