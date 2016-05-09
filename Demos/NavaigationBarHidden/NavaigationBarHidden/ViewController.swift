//
//  ViewController.swift
//  NavaigationBarHidden
//
//  Created by ByRongInvest on 15/12/29.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.fd_viewControllerBasedNavigationBarAppearanceEnabled = false;
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

//    override func viewDidDisappear(animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        super.viewDidDisappear(animated)
//    }
}

