//
//  IndexViewController.swift
//  voz4rum ios
//
//  Created by BAULOC on 7/14/16.
//  Copyright © 2016 BAU LOC. All rights reserved.
//

import UIKit
import PullToMakeFlight


class IndexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leftMenuButton: UIBarButtonItem!
    @IBOutlet weak var rightMenuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var viewAds: UIView!
    @IBOutlet weak var tableIndex: UITableView!
    @IBOutlet weak var viewControl: UIView!
    
    var list_record = [IndexRecord]()
    var index_record = IndexRecord()

    var refreshControl = UIRefreshControl()

    
    @IBOutlet weak var lblTest: UILabel!

    override func viewDidLoad() {
        
        setupSideMenu()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //fetchDataIndexPage()
        
//        tableIndex.estimatedRowHeight = 30
//        tableIndex.rowHeight = UITableViewAutomaticDimension
        
        refreshControl.attributedTitle = NSAttributedString(string: "Xin chờ, đừng ném gạch...", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor() ])
        refreshControl.addTarget(self, action: #selector(IndexViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableIndex.addSubview(refreshControl)
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSideMenu() {
        
        if revealViewController() != nil {
            
            leftMenuButton.target = revealViewController()
            leftMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.navigationController?.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        refreshControl.attributedTitle = NSAttributedString(string: "Xin chờ, đừng ném gạch...", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor() ])
        fetchDataIndexPage()
    }
    
    func fetchDataIndexPage() {
        
        ForumClient.getIndexPage { (result, httpCode, error) in
            
            self.refreshControl.endRefreshing()
            
            if result != nil {
                let record = result as! [IndexRecord]
                self.list_record = record
                self.tableIndex.reloadData()
            }
        }
        
    }
    
    //MARK: - Tableview Datasource
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return list_record.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let selected_view = UIView()
        selected_view.backgroundColor = UIColor.lightGrayColor()
        let info = list_record[indexPath.row]
        let cell_id = info.is_header == true ? "index.cell.header": "index.cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cell_id, forIndexPath: indexPath) as! IndexViewControllerCell
        
        cell.selectedBackgroundView = selected_view
        cell.configure(info)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let info = list_record[indexPath.row]
        if info.is_header {
            return 30
        } else {
            return 50
        }
    }
    
    //MARK: - Tableview Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        index_record = list_record[indexPath.row]
        self.performSegueWithIdentifier("app.screen.subforum", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        if segue.identifier == "app.screen.subforum" {
            let destinationVC = segue.destinationViewController as! SubIndexViewController
            destinationVC.index_record = index_record
        }
    }
}
