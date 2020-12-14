//
//  myTableViewController.swift
//  tableview
//
//  Created by yzh on 2020/11/20.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {
    var contactList:[contact]=[contact]()
    var testIfExit:[contact]=[contact]()
    func saveContacts(){
        let success=NSKeyedArchiver.archiveRootObject(contactList, toFile: contact.userPath)
    }
    
    func ifExit(){
        if let contacts=NSKeyedUnarchiver.unarchiveObject(withFile: contact.userPath) as?[contact]{
            testIfExit=contacts
            print("load file successful")
        }
    }
    
    func loadContacts(){
        if let contacts=NSKeyedUnarchiver.unarchiveObject(withFile: contact.userPath) as?[contact]{
            contactList=contacts
            print("load file successful")
        }
    }
    
    func loadInfo() -> Void{
        self.contactList.append(contact(name: "xiaoming", phone: "18911111111",avatar:nil))
        self.contactList.append(contact(name: "xiaozhang", phone: "1891111222",avatar:nil))
        self.contactList.append(contact(name: "xiaohao", phone: "18911111131",avatar:nil))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=80
        ifExit();
        if(testIfExit.count==0){
            loadInfo();}
        else
        {loadContacts();}
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func saveTolList(segue:UIStoryboardSegue){
        if let sourceVC=segue.source as?dataViewController,let contact=sourceVC.contactForEdit{
            if let selectedIndex=tableView.indexPathForSelectedRow{
                contactList[selectedIndex.row]=contact
                tableView.reloadRows(at: [selectedIndex], with: UITableView.RowAnimation.automatic)
            }
            else  {
                contactList.append(contact)
//                tableView.reloadData()
                let indexPath = IndexPath(row: contactList.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
            saveContacts();
        }
    }
    @IBAction func exiteTolList(segue:UIStoryboardSegue){}
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.contactList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)as! TableViewCellController
        
//         Configure the cell...
        cell.nameLabel?.text=contactList[indexPath.row].name
        cell.phoneLabel?.text=contactList[indexPath.row].phone;
        cell.avatarImage?.image=contactList[indexPath.row].avatar;
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
     //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             //Delete the row from the data source
            contactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveContacts()
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

    
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC=segue.destination as?
            dataViewController{
            if let selectedIndex=tableView.indexPathForSelectedRow{
                destVC.contactForEdit=contactList[selectedIndex.row]
            }
        }
    }


}
