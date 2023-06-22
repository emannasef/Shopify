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
    let fullName = name
    let fullNameArr =  fullName.components(separatedBy: "|")  //split(fullName) {$0 == "|"}
    let brand: String = fullNameArr[0]
    let title: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
    return (brand,title)
}

func splitFullName(name:String) -> (String?,String?){
    let fullName = name
    let fullNameArr =  fullName.components(separatedBy: " ")  //split(fullName) {$0 == "|"}
    let firstName: String = fullNameArr[0]
    let lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
    return (firstName,lastName)
}
func DateFormate(date:String) -> String{

   // let string = "20:32 Wed, 30 Oct 2019"
    let formatter4 = DateFormatter()
    formatter4.dateFormat = "HH:mm E, d MMM y"
    let dateString = formatter4.date(from: date)
   // print(formatter4.date(from: date) ?? "Unknown date")
    
    return "\(String(describing: dateString) )"
}

