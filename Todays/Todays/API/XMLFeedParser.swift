//
//  XMLParser.swift
//  Todays
//
//  Created by Yehia Arafa on 3/9/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import Foundation


class XMLFeedParser: NSObject, XMLParserDelegate{
 
    var rssItems = [RSSFeedItemResult]()
    var currentElement = ""
    var currentTittle = ""
    var currentDescription = ""
    
    var parserCompletionHandler: (([RSSFeedItemResult]) -> Void)?
    
    var task: URLSessionDataTask?
    
    //Networking
    func parseFeed(url: URL, CompletionHandler: (([RSSFeedItemResult]) -> Void)? ){
        
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
        if currentElement == "item" {
            currentTittle = ""
            currentDescription = ""
        }
    }
    
    /*This function gets called when the data inside the tag gets parsed*/
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement{
            case "title" : currentTittle += string
            case "description" : currentDescription+=string
            default: break
        }
    }
    
    /*This method gets called when the ending tag gets parsed*/
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item"{
            
            let item = RSSFeedItemResult()
            item.title = currentTittle
            item.description = currentDescription
            self.rssItems.append(item)
        }
    }
 
    /*This method get called when the parser finish parsing*/
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    /* Error */
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
