
import Foundation
import Alamofire
class ProductInfoViewModel{
    
    var bindingProductInfo:(()->()) = {}
    var cartItems:[LineItems]? = MyCartItems.cartItemsCodableObject
    
    var product : ProductInfo? {
        didSet {
            bindingProductInfo()
        }
    }
    
    var network:NetworkProtocol!
    init(network: NetworkProtocol!) {
        self.network = network
    }
    
    
    func getProductDetails(productId:Int){
        
        network.get(endPoint: .productDetails(id: productId)) {  [weak self] (retrivedProduct:ProductInfo?, err) in
            self?.product = retrivedProduct
        }
        
    }
    
    func addToCart(draftOrdrId:Int,product:Product){
        
        let params : Parameters = encodeToJson(objectClass: createADraftOrder(draftOrdrId: draftOrdrId, product: product)) ?? [:]
        if MyCartItems.cartItemsCodableObject != nil ||  MyCartItems.cartItemsCodableObject?.count == 0{
            network.update(endPoint: .modifieDraftOrder(draftOrderId: draftOrdrId), params: params) { (response:MyDraftOrder?, error )in
                guard let result = response?.draft_order else{
                    print(error ?? "there is an errror while adding a new item to your cart")
                    return}
                MyCartItems.cartItemsCodableObject = result.lineItems
            }
        }
        else {
            network.post(endPoint: .createDraftOrder, params: params) { (response:MyDraftOrder?, error )in
                guard let result = response?.draft_order else{
                    print(error ?? "there is an errror while adding a new item to your cart")
                    return}
                MyCartItems.cartItemsCodableObject = result.lineItems
                setDraftOrderId(draftOrderId: result.id!)
            }
            
        }
    }
    
    func addItem(product:Product){
        let proVarient = product.variants?[0]
        _ = proVarient?.id
        let title = product.title
        let variTitle = proVarient?.title
        let price = proVarient?.price
        let properties = [Properties(name: "url_image", value: product.images?[0].src ?? "")]
        let item = LineItems(/*varientId: varientId ?? 0,*/ title: title ?? "", varientTitle: variTitle ?? "", price: price ?? "", properties: properties)
        
        
        cartItems?.append(item)
        
    }
    
    func createADraftOrder(draftOrdrId:Int,product:Product) -> MyDraftOrder{
        addItem(product: product)
        _ = LineItems( title: "oo" , varientTitle: "lll" , price: "99" , properties: [Properties()])
        _ = cartItems
        
        return createDraftOrder(draftOrderId: draftOrdrId, lineItems: cartItems ?? [] )
        
    }
}
