import UIKit

class orderdItemTableCell: UITableViewCell {
 
    @IBOutlet weak var increaseBtn: UIButton!
    @IBOutlet weak var decreaseBtn: UIButton!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemsNum: UILabel!
    @IBOutlet weak var menuItem: UIButton!    
    @IBOutlet weak var itemColor: UILabel!
    @IBOutlet weak var itemsize: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    
    var deleteitem : () ->() = {}
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
    }
    
    @IBAction func decreaseItemBtn(_ sender: Any) {
        
        if (itemsCount > 0){
            self.itemsCount -= 1
        }
        self.itemsNum.text = String(self.itemsCount)
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
