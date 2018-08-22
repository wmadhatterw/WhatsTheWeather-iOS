//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Seth Walton on 8/21/18.
//  Copyright © 2018 Seth Walton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    
    @IBAction func submit(_ sender: Any) {
        let city = String(textField.text!).replacingOccurrences(of: " ", with: "")
        //let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        if city == ""{
            
            label.text = "Please enter a City Name Please."
            
        } else {
            
            
            if let url = URL(string: "https://www.weather-forecast.com/locations/" + city + "/forecasts/latest"){
            
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                
                data, response, error in
                
                var message = " "
                
                if error != nil {
                    
                    print(error)
                    
                } else {
                    if let unwrappedData = data{
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        var stringSeperator = "Weather Today </h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeperator){
                            
                            if contentArray.count > 1 {
                                
                                stringSeperator = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                                
                                if newContentArray.count > 1{
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                }
                                
                            }
                        }
                    }
                }
                if message == ""{
                    message = "The weather there couldn't be found please try again!"
                }
                DispatchQueue.main.sync(execute: {
                    self.label.text = message
                })
            }
            task.resume()
            }else {
                label.text = "The weather there couldn't be found please try again!"
            }
        
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

