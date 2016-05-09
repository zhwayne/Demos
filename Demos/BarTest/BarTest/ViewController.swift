//
//  ViewController.swift
//  BarTest
//
//  Created by ByRongInvest on 15/12/18.
//  Copyright © 2015年 ByRongInvest. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        
        self.tableView.dataSource = self;
        self.tableView.delegate   = self;
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let se = UIView(frame: CGRectMake(0, 0, 320, 44))
        se.backgroundColor = UIColor.orangeColor()
        self.tableView.addSubview(se)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("cell")!;
    }
}

