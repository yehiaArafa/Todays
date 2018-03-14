//
//  Constants.swift
//  Todays
//
//  Created by Yehia Arafa on 3/9/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import Foundation

struct CellIdentifiers {
    static let RSSFeedItemCell = "RSSFeedItemCell"
    static let loadingFeedCell = "LoadingFeedCell"
    static let WeatherCell = "WeatherCell"
    
}

struct lasCrucesRSS{
    static let general = "https://news.google.com/news/rss/search/section/q/las%20cruces%20general%20news/las%20cruces%20general%20news?hl=en&gl=US&ned=us"
   
    static let sports = "https://news.google.com/news/rss/search/section/q/las%20cruces%20sports/las%20cruces%20sports?hl=en&gl=US&ned=us"
   
    static let politics = "https://news.google.com/news/rss/search/section/q/las%20cruces%20politics%20news/las%20cruces%20politics%20news?hl=en&gl=US&ned=us"
   
    static let economics = "https://news.google.com/news/rss/search/section/q/las%20cruces%20economics/las%20cruces%20economics?hl=en&gl=US&ned=us"
    
    static let NMSU = "https://newscenter.nmsu.edu/Articles/news"
}

struct elPasoRSS{
    static let general = "https://news.google.com/news/rss/search/section/q/elpaso%20general%20news/elpaso%20general%20news?hl=en&gl=US&ned=us"
    
    static let sports = "https://news.google.com/news/rss/search/section/q/elpaso%20sports%20news/elpaso%20sports%20news?hl=en&gl=US&ned=us"
    
    static let politics = "https://news.google.com/news/rss/search/section/q/elpaso%20politics%20news/elpaso%20politics%20news?hl=en&gl=US&ned=us"
    
    static let economics = "https://news.google.com/news/rss/search/section/q/elpaso%20economics%20news/elpaso%20economics%20news?hl=en&gl=US&ned=us"
}

struct albuquerqueRSS{
    static let general = "https://news.google.com/news/rss/search/section/q/albuquerque%20general%20news/albuquerque%20general%20news?hl=en&gl=US&ned=us"
    
    static let sports = "https://news.google.com/news/rss/search/section/q/albuquerque%20sports%20news/albuquerque%20sports%20news?hl=en&gl=US&ned=us"
    
    static let politics = "https://news.google.com/news/rss/search/section/q/albuquerque%20politics%20news/albuquerque%20politics%20news?hl=en&gl=US&ned=us"
    
    static let economics = "https://news.google.com/news/rss/search/section/q/albuquerque%20economics%20news/albuquerque%20economics%20news?hl=en&gl=US&ned=us"
}



struct weatherAPI{
    static let lasCruces = "http://api.apixu.com/v1/current.xml?key=57096343fae94802969223357181203&q=Las%20Cruces"
    
    static let elPaso = "http://api.apixu.com/v1/current.xml?key=57096343fae94802969223357181203&q=El%20Paso"
    
    static let albuquerque = "http://api.apixu.com/v1/current.xml?key=57096343fae94802969223357181203&q=Albuquerque"
}

struct sideMenuContsants{
    static let firstSelection = "Local News"
    static let secondSelection = "Local Resturants"
    static let thirdSelection = "Cool Local Pics"
    static let fourthSelection = "Local Weather"
}

struct LasCrucesMapAnnotations{
    static let title = "Las Cruces"
    static let latitude = 32.3199396
    static let longitude = -106.7636538
    static let locationName = "New Mexico"
    static let discipline = "sculpture"
}

struct ElPasoMapAnnotations{
    static let title = "El Paso"
    static let latitude = 31.772543
    static let longitude = -106.460953
    static let locationName = "Texus"
    static let discipline = "sculpture"
}
struct AlbuquerqueMapAnnotations{
    static let title = "Albuquerque"
    static let latitude = 35.113281
    static let longitude = -106.621216
    static let locationName = "New Mexico"
    static let discipline = "sculpture"
}



