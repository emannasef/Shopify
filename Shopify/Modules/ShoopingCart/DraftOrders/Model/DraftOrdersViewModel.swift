import Foundation

class DraftOrderViewModel {
    
    var draftOrders : [DraftOrders]?
    var lineItems : [LineItems]?
    var network : NetworkProtocol!
    var bindDraftOrdersToViewControllers : (()->())?
    
    
    init(network:NetworkProtocol){
        self.network = network
    }
    
    func getDraftOrders(customerEmail : String){
        
        network.get(endPoint: .getDraftOrder, completionHandeler: { (response: DraftOrderResponse?, error) in
            guard response != nil else {
                print ("No response")
                return
            }
            self.lineItems = self.filterDraftOrders(orders: response?.draftOrders ?? [], customerEmail:customerEmail)
            print("email...\(String(describing: self.draftOrders?[0].lineItems?.count))")
            self.bindDraftOrdersToViewControllers!()
        })
            
        }
    
    func retriveAnOrder(index:Int) -> LineItems{
        
        return self.lineItems?[index] ?? LineItems()
        
    }
    func getDrftOrdersCount()->Int{
        
        return lineItems?.count ?? 0
    }
    
    func filterDraftOrders(orders:[DraftOrders], customerEmail : String) -> [LineItems]{
        
        let result = orders.filter({$0.id == 1117157490997 && $0.note == "cart"
        }).first?.lineItems ?? []
        
        return result
      /*  var result : DraftOrders?
        let i = 0
        while orders[i].note == "cart" && orders[i].customer?.email == customerEmail{
            result = orders[i]
        }*/
       // return result ?? DraftOrders()
    }
    }
    
    

