//
//  ReviewsVC.swift
//  ShopifyCustomer
//
//  Created by Mac on 11/06/2023.
//

import UIKit

class ReviewsVC: UIViewController {
    @IBOutlet weak var myReviewsTable: UITableView!
    let revierImages = ["person1","person2","person3","person4","person5"]
    
    let revierText = ["I Love This","Meduim quality Product","It's pretty much and I liked it","low quality I hate it","Nicen I think I'll buy it again"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myReviewsTable.delegate = self
        myReviewsTable.dataSource = self
        registerTableCell(tableView: myReviewsTable)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
}
extension ReviewsVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell", for: indexPath) as! ReviewsCell
        cell.reviewerText.text = revierText[indexPath.row]
        cell.reviewerImg.image = UIImage(named: revierImages[indexPath.row])
        return cell
    }
 
    
}
