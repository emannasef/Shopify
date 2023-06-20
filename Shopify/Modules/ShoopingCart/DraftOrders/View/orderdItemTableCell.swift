import UIKit
import Reachability
class orderdItemTableCell: UITableViewCell {
    
    @IBOutlet weak var increaseBtn: UIButton!
    @IBOutlet weak var decreaseBtn: UIButton!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemsNum: UILabel!
    @IBOutlet weak var menuItem: UIButton!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    
    var deleteitem : () ->() = {}
    var increaseQuantity:() ->() = {}
    var decreaseQuantity:() ->() = {}
    var itemsCount = 0
    var menu : UIMenu!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func increaseItemsBtn(_ sender: Any) {
        
        self.itemsCount += 1
        self.itemsNum.text = String(self.itemsCount)
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            let reachability = try! Reachability()
            if reachability.connection != .unavailable{
                if (itemsCount > 1){
                    self.itemsCount += 1 //(Int(self.itemsNum.text ?? "") ?? 0) - 1
                      self.didQuantityIncreased()
                }
                self.itemsNum.text = String(self.itemsCount)
            }
            else{
                createToastMessage(message: "Connect to network to update your cart", view: superview!.self)
            }
            
        }
        else{
            createToastMessage(message: "Connect to network to update your cart", view: superview!.self)
        }
    }

    @IBAction func decreaseItemBtn(_ sender: Any) {
      
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            if (itemsCount > 1){
                  self.itemsCount -= 1 //(Int(self.itemsNum.text ?? "") ?? 0) - 1
                  self.didQuantityDccreased()
            }
            self.itemsNum.text = String(self.itemsCount)
        }
        else{
            createToastMessage(message: "Connect to netwoork to update your cart", view: superview!.self)
        }
        
    }

    @objc func didQuantityIncreased() {
        increaseQuantity()
    }
    @objc func didQuantityDccreased() {
        decreaseQuantity()
    }
    
    @objc func didTapDelete() {
        deleteitem()
    }
    
    func setMenuItem(){
        
        let addItemTofav = UIAction(title: "Add to favourite") { (action) in
            
            print("add to favourite")
        }
        
        let adeleteItem = UIAction(title: "Delete item") { (action) in
            
            print("Delete item")
            self.didTapDelete()
            
        }
 
        menu = UIMenu(title: "", options: .displayInline, children: [addItemTofav,adeleteItem])
        menuItem.menu = menu
        menuItem.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func displayMenuItem(_ sender: Any) {
        setMenuItem()
        
    }
}
