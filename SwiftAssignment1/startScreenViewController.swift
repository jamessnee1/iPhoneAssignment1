//
//  startScreenViewController.swift
//  SwiftAssignment1
//
//  Created by James Snee on 14/03/2015.
//  Copyright (c) 2015 James Snee and Heather Ingram. All rights reserved.
//

import UIKit
import AVFoundation

class startScreenViewController: UIViewController {
    
    //Create an array of movie structs. This will hold movies
    var movies = [Movie]()
    
    //create an array of cinema structs. This will hold cinemas
    var cinemas = [Movie]()
    
    //sound variables
    var blank = AVAudioPlayer()
    var click = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        //blank sound. This is because AVAudioPlayer takes a second to buffer the sound (possible bug) so as soon as the app loads,
        //it will play a blank sound in the background to alleviate this problem.
        var blankSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("1sec", ofType: "mp3")!)
        blank = AVAudioPlayer(contentsOfURL: blankSound, error: nil)
        blank.prepareToPlay()
        blank.play()
        
        //mouse click sound
        var clickSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click", ofType: "aif")!)
        click = AVAudioPlayer(contentsOfURL:clickSound, error: nil)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //play sound of buttons here
    @IBAction func searchByCinema(sender: AnyObject) {
        
        click.prepareToPlay()
        click.play()

    }
    
    @IBAction func searchByMovie(sender: AnyObject) {
        
        click.prepareToPlay()
        click.play()
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
