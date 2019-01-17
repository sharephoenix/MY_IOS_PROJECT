//
//  PinLayoutController.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/12/28.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class PinLayoutController: UIViewController {

    private let contentView: YSPinLayoutView = YSPinLayoutView()

    @IBOutlet weak var web: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let aaa = String.init(cString: "http://baidu.org/我的/a/b", encoding: .utf8)
//        let relative = "/我的/a/b"
        _ = NSURL.init(string: aaa ?? "")//URL.init(string: <#T##String#>, relativeTo: <#T##URL?#>)
        var urlString = ""//"https://cn.bing.com/search?q=好的#"
        var url: URL?
        url = URL.init(string: urlString)
        if url == nil {
            urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            url = URL.init(string: urlString)
//            addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        if let url = url {
            web.load(URLRequest.init(url: url))
            web.reload()
        } else {
            do {
                let pagePath = Bundle.main.path(forResource: "empty", ofType: "html")!
                let pageHtml = try String(contentsOfFile: pagePath, encoding: .utf8)
                let baseURL = URL(fileURLWithPath: pagePath)
                web.loadHTMLString(pageHtml, baseURL: baseURL)
            } catch {

            }
        }

//        if let url = URL.init(string: "https://cn.bing.com/search?q=好的") {
//            web.load(URLRequest.init(url: url))
//            web.reload()
//        } else {
//            print("asdf")
//        }

        self.view.addSubview(contentView)
        contentView.backgroundColor = .yellow
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(100)
        }
    }
}
