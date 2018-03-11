//
//  DownloadImages.swift
//  Todays
//
//  Created by Yehia Arafa on 3/10/18.
//  Copyright © 2018 Yehia Arafa. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
   
    func getImage(url: URL) -> URLSessionDownloadTask {
        
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
                if error == nil, let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                   
                    DispatchQueue.main.async {
                        if let weakSelf = self {
                            weakSelf.image = image
                        }
                    }
                }
        })
      
        downloadTask.resume()
        return downloadTask
    }



}

