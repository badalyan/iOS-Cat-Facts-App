//
//  ViewController.swift
//  FunFacts
//
//  Created by Alex Badalyan
//  Copyright © 2016 Alex Badalyan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    // create title variable
    @IBOutlet weak var funFactLabel: UILabel!
    
    // create button variable
    @IBAction func randomFactButton(sender: AnyObject) {
        displayRandomHttpFact()
    }
    
    // list of all random facts
    var randomFacts = ["Earth is fast, about 66,700 miles per hour",
                       "90% of all volcanic activity occurs in the oceans",
                       "Tropical rainforests are the world's oldest ecosystems",
                       "1/3 of all energy is used by people at home",
                       "Asia the world's longest coastline",
                       "Largest City: Seoul, South Korea, 10,231,217 people",
                       "It takes 90% less energy to recycle aluminum cans than to make new ones",
                       "Earth's crust is about 5 miles deep"]
    
    // list of all random colors
    var randomColors = [
        [1, 0.4, 0.4, 1.0], //red
        [1, 0.8, 0.4, 1.0], //orange
        [0.9882, 1, 0.4, 1.0], //yellow
        [0.5882, 1, 0.4, 1.0], //green
        [0.4, 0.9569, 1, 1.0], //blue
        [1, 0.4, 0.949, 1.0] //purple
    ]
    
    // finds random fact from array
    func getRandomArrayFact() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(randomFacts.count)))
        return randomFacts[randomIndex]
    }
    
    // gets random color
    func getRandomColor() -> UIColor {
        let randomIndex = Int(arc4random_uniform(UInt32(randomColors.count)))
        let randomColor = randomColors[randomIndex]
        return UIColor(red: CGFloat(randomColor[0]), green: CGFloat(randomColor[1]), blue: CGFloat(randomColor[2]), alpha: CGFloat(randomColor[3]))
        
    }
    
    // display the random array fact on screen
    func displayRandomArrayFact() {
        // create variable
        var newFact: String
        var newBackground: UIColor
        
        // ensure it isn't the current fact and current background
        repeat {
            newFact = getRandomArrayFact()
        } while (funFactLabel.text == newFact)
        
        repeat {
            newBackground = getRandomColor()
        } while (self.view.backgroundColor == newBackground)
        
        // update the text and change the color
        funFactLabel.text = newFact
        self.view.backgroundColor = newBackground
    }
    
    // display random http fact on screen
    func displayRandomHttpFact() {
        
        // http request random cat fact
        Alamofire.request(.GET, "https://catfacts-api.appspot.com/api/facts")
            .responseJSON { response in
                
                // convert result into json and print value
                let json = JSON(response.result.value!)
                let newFact = json["facts"][0]
                var newBackground: UIColor
                
                // change the color and update the text
                repeat {
                    newBackground = self.getRandomColor()
                } while (self.view.backgroundColor == newBackground)
                
                self.view.backgroundColor = newBackground
                self.funFactLabel.text = newFact.rawString()
                
        }
    }
    
    
    
    
    
    
    // on startup, here is what happens
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // generate random fact add display it on startup
        displayRandomHttpFact()
        
    }
    
    // ignore this for now
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

