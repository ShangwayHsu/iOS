//
//  DetailViewController.swift
//  Google Blog
//
//  Created by Shangway on 5/27/16.
//  Copyright © 2016 Shangway Hsu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {



    @IBOutlet var webView: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let web = self.webView {
                web.loadHTMLString(detail.valueForKey("content")!.description, baseURL: NSURL(string:"http://googleblog.blogspot.com"))
                    self.title = detail.valueForKey("title")!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

