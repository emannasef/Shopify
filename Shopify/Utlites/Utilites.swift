import Foundation
import UIKit
class Utilites{
    

}
extension String {
var isPasswordContainsLettersAndNumbers: Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: self)
        return isMatched
    }
}

func registerTableCell (tableView: UITableView){
    let nib = UINib(nibName: "ReviewsCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "ReviewsCell")
}

func splitProductName(name:String) -> (String?,String?){
    var fullName = name
    var fullNameArr =  fullName.components(separatedBy: "|")  //split(fullName) {$0 == "|"}
    var brand: String = fullNameArr[0]
    var title: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
    return (brand,title)
}
