//
//  ViewController.swift
//  SwiftDefaultProject
//
//  Created by Alexluan on 2018/10/22.
//  Copyright © 2018年 Alexluan. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var imageV: UIImageView!
    var s:String?
    var url:URLRequestConvertible?;
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlstr = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541140178548&di=5036311b7eb69c3d83ce054b1ee73ad7&imgtype=0&src=http%3A%2F%2Fwww.sucaitianxia.com%2FPhoto%2Fpic%2F201001%2Fgefnegs04.jpg"
        let urlstr0 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541162520108&di=4d0475ef3b8cd487ef1dd061d9e46acc&imgtype=0&src=http%3A%2F%2Fpic19.nipic.com%2F20120210%2F7827303_221233267358_2.jpg"
        guard let url:URL = URL.init(string: urlstr) else{
            return
        }
        guard let url0:URL = URL.init(string: urlstr0) else{
            return
        }
        let fetchImage = URLSession.shared.dataTask(.promise, with: url).compactMap{ UIImage(data: $0.data) }
        
        let fetchLocation = URLSession.shared.dataTask(.promise, with: url0 ).compactMap { (arg0) -> UIImage? in
            
            let (data, _) = arg0
            let image = UIImage.init(data: data)
            return image
        }
        print("this is firstly")
        firstly {
                when(fulfilled: fetchImage, fetchLocation)
            }.done { image, location in
                
                self.imageView.image = image
                self.imageV.image = location
                self.label.text = "this is location"
                print("this is done")
            }.ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print("this is ensure")
            }.catch { error in
                print(error)
            }
        print("this is start")
    }
    

}

