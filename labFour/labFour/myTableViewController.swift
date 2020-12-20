//
//  myTableViewController.swift
//  labFour
//
//  Created by yzh on 2020/12/11.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {

    var memoList:[memo]=[memo]()
    var testIfExit:[memo]=[memo]()
    
    
    func saveMemos(){
        let success=NSKeyedArchiver.archiveRootObject(memoList, toFile: memo.userPath)
    }
    
    func ifExit(){
        if let memos=NSKeyedUnarchiver.unarchiveObject(withFile: memo.userPath) as?[memo]{
            testIfExit=memos
            print(" file exit")
        }
    }
    
    func loadMemos(){
        if let memos=NSKeyedUnarchiver.unarchiveObject(withFile: memo.userPath) as?[memo]{
            memoList=memos
            print("load file successful")
        }
    }
    
    func loadInfo() -> Void{
        self.memoList.append(memo(title: "这是一个备忘录", date: "2020/12/11",content:nil,location:"周启麟心里"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //////////////////添加监控
        UIDevice.current.beginGeneratingDeviceOrientationNotifications(); NotificationCenter.default.addObserver(self,selector:#selector(myTableViewController.receivedRotation),name: UIDevice.orientationDidChangeNotification, object: nil);
        
        ///////////////////
        tableView.rowHeight=100
        ifExit();
        if(testIfExit.count==0){
            loadInfo();}
        else
        {loadMemos();}
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //////////////////////////
    //通知监听触发的方法
    @objc func receivedRotation(){
        let device = UIDevice.current
        switch device.orientation{
      
        case .faceDown:
            print("设备平放，Home键朝下")
            UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
        case .unknown:
            print("设备 ")
        case .portrait:
            print("设备 ")
        case .portraitUpsideDown:
            print(" 设备")
        case .landscapeLeft:
            print("设备 ")
        case .landscapeRight:
            print("设备")
        case .faceUp:
            print(" 设备")
        }
    }
    //////////////
    @IBAction func saveTolList(segue:UIStoryboardSegue){
        if let sourceVC=segue.source as?dataViewController,let memo=sourceVC.memoForEdit{
            if let selectedIndex=tableView.indexPathForSelectedRow{
                memoList[selectedIndex.row]=memo
                tableView.reloadRows(at: [selectedIndex], with: UITableView.RowAnimation.automatic)
                
            }
            else  {
                memoList.append(memo)
                //                tableView.reloadData()
                let indexPath = IndexPath(row: memoList.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
            saveMemos();
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath)as! myDataViewCell
        
        //         Configure the cell...
        cell.titleLabel?.text=memoList[indexPath.row].title
        cell.dateLabel?.text=memoList[indexPath.row].date
        cell.locationLabel?.text=memoList[indexPath.row].location
//        cell.firstImg?.image=memoList[indexPath.row].avatar;
//        cell.firstImg?.image=nil;
        return cell;
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the row from the data source
            memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveMemos();
        } else if editingStyle == .insert {
            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC=segue.destination as?
            dataViewController{
            if let selectedIndex=tableView.indexPathForSelectedRow{
                destVC.memoForEdit=memoList[selectedIndex.row]
            }
        }
    }
    

}
