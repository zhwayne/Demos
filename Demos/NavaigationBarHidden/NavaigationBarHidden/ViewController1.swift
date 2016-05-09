//
//  ViewController1.swift
//  NavaigationBarHidden
//
//  Created by ByRongInvest on 15/12/29.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
