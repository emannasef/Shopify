
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
        if draftOrdrId != 0 || MyCartItems.cartItemsCodableObject?.count == 0 {//&& MyCartItems.cartItemsCodableObject != nil ||  MyCartItems.cartItemsCodableObject?.count == 0{
            network.update(endPoint: .modifieDraftOrder(draftOrderId: draftOrdrId), params: params) { (response:MyDraftOrder?, error )in
                guard let result = response?.draft_order else{
                    print(error ?? "there is an errror while adding a new item to your cart")
                    return}
                MyCartItems.cartItemsCodableObject = result.lineItems
                setDraftOrderId(draftOrderId: result.id!)
            }
        }
        
        else  {
            network.post(endPoint: .createDraftOrder, params: params) { (response:MyDraftOrder?, error )in
                guard let result = response?.draft_order else{
                    print(error ?? "there is an errror while posting a first item to your cart")
                    return}
                MyCartItems.cartItemsCodableObject = result.lineItems
                setDraftOrderId(draftOrderId: result.id!)
            }
            
        }
    }
    
    func addItem(product:Product){
        let proVarient = product.variants?[0]
        let variantId = proVarient?.id ?? 0
        let title = product.title
        let variTitle = proVarient?.title
        let price = proVarient?.price
        let properties = [Properties(name: "url_image", value: product.images?[0].src ?? "")]
        let item = LineItems(title: title ?? "", varientTitle: variTitle ?? "", price: price ?? "", properties: properties, quantity: 1)
        
        
        MyCartItems.cartItemsCodableObject?.append(item)
        print(MyCartItems.cartItemsCodableObject?.count ?? 0)
        
    }
    
    func createADraftOrder(draftOrdrId:Int,product:Product) -> MyDraftOrder{
        
        let items = LineItems(title: "Dress" , varientTitle: "lll" , price: "99" , properties: [Properties(name: "img_url", value:"https://cdn.shopify.com/s/files/1/0767/9013/7124/products/8072c8b5718306d4be25aac21836ce16.jpg?v=1685539054")], quantity: 1)
       // MyCartItems.cartItemsCodableObject?.append(items)
        let customer = Customer(id:Int(UserDefaults.standard.integer(forKey: "customerId")))
        if MyCartItems.cartItemsCodableObject?.count == 0{
            MyCartItems.cartItemsCodableObject = [items]
        }
        addItem(product: product)
        return createDraftOrder(draftOrderId: draftOrdrId, lineItems: MyCartItems.cartItemsCodableObject ?? [],customer: customer )
        
    }
}
