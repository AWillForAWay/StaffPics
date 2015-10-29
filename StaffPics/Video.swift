//
//  Video.swift
//  StaffPics
//
//  Created by Austin Williams on 9/12/15.
//  Copyright (c) 2015 Austin Willimas. All rights reserved.
//

import Foundation
import UIKit

class Video {
    
    var name: String? = ""
    var duration: String?
    var imageURLString: String? = ""
    
    init(dictionary: Dictionary<String,AnyObject>) {
        
        self.name = dictionary["name"] as? String
        
        let duration = dictionary["duration"] as? Int ?? 0
        self.duration = self.formattedDuration(duration)
        
        //TODO optimize image selection process 
        let pictures = dictionary["pictures"] as? Dictionary<String, AnyObject>
        if let constPictures = pictures
        {
            let sizes = constPictures["sizes"] as? Array<Dictionary<String,AnyObject>>
            
            if let constSizes = sizes
            {
                if constSizes.count > 0
                {
                    let screenWidth = UIScreen.mainScreen().bounds.size.width * UIScreen.mainScreen().scale
                    
                    let variableSizes = constSizes.filter({$0["width"] as? CGFloat >= screenWidth })
                    
                    let selectedSize = variableSizes.count > 0 ? variableSizes[0] : constSizes.last
                    self.imageURLString = selectedSize?["link"] as? String
                    
                }
            }
        }
    }
    
    func formattedDuration(duration: Int) -> String{
    
        let minutes = duration / 60
        
        _ = duration % 60
        
        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        
        let secondsString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        
        return minutesString + ":" + secondsString
    }
    
}