//
//  ViewController.swift
//  YHFPSStatus
//
//  Created by apple on 23/3/17.
//  Copyright © 2017年 于欢. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLb.layer.cornerRadius = 3
        self.titleLb.layer.masksToBounds = true
    }

    @IBAction func pushBtn(_ sender: Any) {
        self.navigationController?.pushViewController(UIViewController.init(), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

