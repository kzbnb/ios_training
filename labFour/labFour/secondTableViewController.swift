//
//  secondTableViewController.swift
//  labFour
//
//  Created by yzh on 2020/12/18.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class secondTableViewController: UITableViewController {
    var remindList:[remind]=[remind]()

    func saveReminds(){
        let success=NSKeyedArchiver.archiveRootObject(remindList, toFile: remind.userPath)
    }
    
    func loadReminds(){
        if let reminds=NSKeyedUnarchiver.unarchiveObject(withFile: remind.userPath) as?[remind]{
            remindList=reminds
            print("load file successful")
        }
    }
    
    @IBAction func saveTolList2(segue:UIStoryboardSegue){
        if let sourceVC=segue.source as?secondDataController,let remind=sourceVC.remindForEdit{
            
            if let selectedIndex=tableView.indexPathForSelectedRow{
                remindList[selectedIndex.row]=remind
                tableView.reloadRows(at: [selectedIndex], with: UITableView.RowAnimation.automatic)
                print("call1",remind.backimg)
            }
            else  {
                remindList.append(remind)
                //                tableView.reloadData()
                let indexPath = IndexPath(row: remindList.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                print("call2")
            }
            print("call3")
            saveReminds()
        }
    }
    
    
    @IBAction func saveTolList(segue:UIStoryboardSegue){
        if let sourceVC=segue.source as?thirdViewController,let remind=sourceVC.remindForEdit{
            
            if let selectedIndex=tableView.indexPathForSelectedRow{
                remindList[selectedIndex.row]=remind
                tableView.reloadRows(at: [selectedIndex], with: UITableView.RowAnimation.automatic)
               
            }
            else  {
                remindList.append(remind)
                //                tableView.reloadData()
                let indexPath = IndexPath(row: remindList.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                
            }
            
            saveReminds()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=100

        loadReminds()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.remindList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindCell", for: indexPath)as! mySecondDataViewCell
        
        //         Configure the cell...
        cell.titleLabel?.text=remindList[indexPath.row].title
        cell.dateLabel?.text=remindList[indexPath.row].date
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

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the row from the data source
            remindList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveReminds();
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
            secondDataController{
            if let selectedIndex=tableView.indexPathForSelectedRow{
                destVC.remindForEdit=remindList[selectedIndex.row]
            }
        }
    }
    

}
