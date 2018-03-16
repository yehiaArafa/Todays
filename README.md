# Todays

## ios app for New Mexico local residents especially Las Cruces

### How it Works: 

(1) **First** the user has to choose hise desired city; Las Cruces, El Paso, or Albuquerque from a the map.    
(2) Then hew will need to choose either local news, local resturatns or local weather. For Las Cruces, the user can also check NMSU news.   
(3) The news section are devided into sections. 

## Tools used: 

- [Google Rss Feed News](https://news.google.com/news/?ned=us&gl=US&hl=en) are used to get the todays headlines for each city, The feed API return XML response. The app parse that response and populate a table view with the headlines. From there the user can select any headline he/she want and the app will take him to the full article detail, All on the same app, the app will not redirect him/her to Safari or Chrome. Also NMSU has its own [RSS feed](https://newscenter.nmsu.edu/).   
- [Yelp Fusion API](https://www.yelp.com/developers) is used to get local buissness in each city. The API returns JASON response and the app parse that response by confirming to [Codable](https://developer.apple.com/documentation/swift/codable) protocol and populate nice table view with all the data.   
- [Apixu](https://www.apixu.com/) API is used to have todays weather for each city, Apixu provides a complete Weather API solution.
