import Foundation
import Alamofire

class DraftOrderViewModel {
    
    var draftOrders : [DraftOrders]?
    var lineItems : [LineItems]?
    var network : NetworkProtocol!
    var bindDraftOrdersToViewControllers : (()->())?
    
    
    init(network:NetworkProtocol){
        self.network = network
    }
    
    func getDraftOrders(draftOrderId:Int){
        
        network.get(endPoint: .getASingleDraftOrder(draftOrderId: draftOrderId), completionHandeler: { (response: MyDraftOrder?, error) in
            guard response != nil else {
                print ("No response")
                return
            }
            self.lineItems = self.filterASingleDraftOrders(orders: response!, draftOrderId: draftOrderId) //self.filterDraftOrders(orders: response?.draftOrders ?? [],draftOrderId: draftOrderId )
            MyCartItems.cartItemsCodableObject = self.lineItems
            self.bindDraftOrdersToViewControllers!()
            print("count...\(String(describing: self.draftOrders?[0].lineItems?.count))")
        })
        
    }
    
    func retriveAnOrder(index:Int) -> LineItems{
        
        return (MyCartItems.cartItemsCodableObject?[index])!//?? LineItems()//self.lineItems?[index] ?? LineItems()
        
    }
    func getDrftOrdersCount()->Int{
        
        return MyCartItems.cartItemsCodableObject?.count ?? 0 //lineItems?.count ?? 0
    }
    
    func filterDraftOrders(orders:[DraftOrders], draftOrderId:Int) -> [LineItems]{
        
        let result = orders.filter({$0.id == draftOrderId && $0.note == "cart"
        }).first?.lineItems ?? []
        
        return result
        
    }
    func filterASingleDraftOrders(orders:MyDraftOrder, draftOrderId:Int) -> [LineItems]{
        
        let result = orders.draft_order?.lineItems?.filter({$0.title !=  "Dress"
        }) ?? []
        
        return result
        
    }
    
    func deleteItem(index:Int,draftOrderId:Int,customer:Customer){
        
        var listOfCartItems = MyCartItems.cartItemsCodableObject
        listOfCartItems?.remove(at: index)
        let params:Parameters = encodeToJson(objectClass: createDraftOrder(draftOrderId: draftOrderId, lineItems: listOfCartItems!,customer: customer))!
        
        if listOfCartItems?.count ?? 0 > 1{
            network.update(endPoint: .modifieDraftOrder(draftOrderId: draftOrderId), params: params) {(response:MyDraftOrder?, error )in
                guard let result = response?.draft_order else{
                    print(error ?? "there is an errror while deleting an item from your cart")
                    return}
                MyCartItems.cartItemsCodableObject = result.lineItems
                
            }
        }
        else{
            network.delete(endPoint: .deleteDraftOrder(draftOrderId: draftOrderId), params: params)
            setDraftOrderId(draftOrderId: 0)
        }
        
    }
    
    func convertCurrency(){
        
    }
    
    func updateDraftOrder(draftOrderId:Int,customer:Customer,listOfCartItems:[LineItems]){
        let params:Parameters = encodeToJson(objectClass: createDraftOrder(draftOrderId: draftOrderId, lineItems: listOfCartItems,customer: customer))!
        network.update(endPoint: .modifieDraftOrder(draftOrderId: draftOrderId), params: params) {(response:MyDraftOrder?, error )in
            guard let result = response?.draft_order else{
                print(error ?? "there is an errror while updating  your cart")
                return}
            MyCartItems.cartItemsCodableObject = result.lineItems
            
        }
        
    }
    
}





