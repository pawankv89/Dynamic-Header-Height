//
//  ViewController.swift
//  Dynamic Header Height
//
//  Created by Pawan kumar on 30/04/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import UIKit

struct HeaderItem {
    let title : String
    var items : [ListItem]
}

struct ListItem {
    let id : String
    let title : String
}

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var listArray = [HeaderItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
         //Latest Hindi Movies
        
        
        let list1 = [
        
            ListItem.init(id: "Code Name Abdul", title: "Tanishaa Mukerji, Deepak Ravella, Akku Kulhari, Ashok Chaudhary,"),
            ListItem.init(id: "Ludo", title: "Abhishek Bachchan, Rajkummar Rao, Aditya Roy Kapur, Pankaj Tripathi, Sanya Malhotra, Fatima Sana Sheikh"),
            ListItem.init(id: "Gunjan Saxena: The Kargil Girl", title: "Janhvi Kapoor, Pankaj Tripathi, Angad Bedi, Manav Vij, Vicky Ahuja,"),
            ListItem.init(id: "Lootcase", title: "Ranvir Shorey, Kunal Khemu, Rasika Dugal, Gajraj Rao, Vijay Raaz,"),
            ListItem.init(id: "Darbaan", title: "Sharib Hashmi, Sharad Kelkar, Rasika Dugal, Flora Saini, Harsh Chhaya"),
            ListItem.init(id: "Angrezi Medium", title: "Irrfan Khan, Kareena Kapoor, Pankaj Tripathi, Radhika Madan,")
        ]

        self.listArray = [
            
            HeaderItem.init(title: "Code Name Abdul - Tanishaa Mukerji, Deepak Ravella, Akku Kulhari, Ashok Chaudhary,", items: list1),
            HeaderItem.init(title: "Ludo - Abhishek Bachchan, Rajkummar Rao, Aditya Roy Kapur, Pankaj Tripathi, Sanya Malhotra, Fatima Sana Sheikh", items: list1),
            HeaderItem.init(title: "Gunjan Saxena: The Kargil Girl - Janhvi Kapoor, Pankaj Tripathi, Angad Bedi, Manav Vij, Vicky Ahuja,", items: list1),
            HeaderItem.init(title: "Lootcase - Ranvir Shorey, Kunal Khemu, Rasika Dugal, Gajraj Rao, Vijay Raaz,", items: list1),
            HeaderItem.init(title: "Darbaan - Sharib Hashmi, Sharad Kelkar, Rasika Dugal, Flora Saini, Harsh Chhaya", items: list1),
            HeaderItem.init(title: "Angrezi Medium - Irrfan Khan, Kareena Kapoor, Pankaj Tripathi, Radhika Madan,", items: list1)
        
        ]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // For Row Change Height at Run Time
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50 // Always Greater than 0
        
        // For Section Header Change Height at Run Time
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 50 // Always Greater than 0
        
        // Refresh List
        self.reload_list()
    }

    func reload_list() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
    
    var headerCell: HeaderCell? = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as? HeaderCell

        if (headerCell == nil) {
            let nib: Array = Bundle.main.loadNibNamed(HeaderCell.identifier, owner: self, options: nil)!
            headerCell = nib[0] as? HeaderCell
        }
    
        let header = self.listArray[section]
        
        //Set Values
        headerCell?.titleLabel.text = header.title
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let header = self.listArray[section]
        return header.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ListCell? = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell
        if (cell == nil)
        {
            let nib: Array = Bundle.main.loadNibNamed(ListCell.identifier, owner: self, options: nil)!
            cell = nib[0] as? ListCell
        }
        
        let header = self.listArray[indexPath.section]
        let list = header.items[indexPath.row]
    
        //Set Values
        cell!.titleLabel.text = list.title
        
        return cell!
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //list
        let list = self.listArray[indexPath.row]
        print("list ", list.title)
    }
}



