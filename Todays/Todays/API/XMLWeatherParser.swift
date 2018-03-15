//
//  XMLWeatherParser.swift
//  Todays
//
//  Created by Yehia Arafa on 3/12/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import Foundation

import Foundation


class XMLWeatherParser: NSObject, XMLParserDelegate{
    
    var weatherItem = WeatherCityResult()
    var currentElement = ""
    
    var name = ""
    var tempC = ""
    var tempF = ""
    var conditionText = ""
    var iconLink = ""
    
    var parserCompletionHandler: ((WeatherCityResult) -> Void)?
    
    var task: URLSessionDataTask?
    
    //Networking will be refactored to the Network class
    func parseWeather(url: URL, CompletionHandler: ((WeatherCityResult) -> Void)? ){
        
        self.parserCompletionHandler = CompletionHandler
        task?.cancel()
        //let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        task = urlSession.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                if let error = error{
                    print (error.localizedDescription)
                }
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task?.resume()
    }
    
    
    // MARK: - XML Parser Delegate
    
    /*This function gets called when the opening tag gets parsed*/
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if (currentElement == "location") {
            name = ""
        }
        else if(currentElement == "current"){
            tempC = ""
            tempF = ""
        }
        else if(currentElement == "text"){
            conditionText = ""
        }
        else if(currentElement == "icon"){
            iconLink = ""
        }
        
    }
    
    /*This function gets called when the data inside the tag gets parsed*/
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement{
        case "name" : name += string
        case "temp_c" : tempC += string
        case "temp_f" : tempF += string
        case "text" : conditionText += string
        case "icon" : iconLink += string
        default: break
        }
    }
    
    /*This method gets called when the ending tag gets parsed*/
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName == "location"){
            weatherItem.cityName = name
        }
        else if (elementName == "current"){
            weatherItem.temperature_c = tempC
            weatherItem.temperature_f = tempF
            weatherItem.weatherCondition = conditionText
            weatherItem.iconLink = parseIconLink(iconLink: iconLink)
        }
        
    }
    
    /*This method get called when the parser finish parsing*/
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(weatherItem)
    }
    
    /* Error */
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
    func parseIconLink(iconLink: String)-> String{
        var words = iconLink.components(separatedBy: " ")
        words[0].removeFirst(2)
        return String(describing: words)
    }
    
    
}
