//
//  ProductInfoVC.swift
//  ShopifyUser
//
//  Created by Mac on 09/06/2023.
//

import UIKit
import Kingfisher

class ProductInfoVC: UIViewController{
    
    
    
    @IBOutlet weak var sizePopButton: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var sizeLB: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var slider: UIPageControl!
    @IBOutlet weak var imsgesCollectionView: UICollectionView!
    @IBOutlet weak var productName: UILabel!
  
    var favBtn : UIBarButtonItem!
    var productId = 8360376402229
    var viewModel:ProductInfoViewModel = ProductInfoViewModel(network: Network())
    var wishListViewModel = WishListViewModel(myCoreData: MyCoreData.sharedInstance,network: Network())
    var myProduct:Product!
    var timer : Timer?
    var currentIndex = 0
    var proImages:[ProductImage] = []
    var favPro:FavProduct = FavProduct()
    let revierImages = ["person1","person2","person3"]
    let revierText = ["I love this","Meduim quality product","It's pretty much and I liked it"]
    let revierNames = ["Eman Nasef","Haidy Yasin","Manal Hamada"]
    
    let userId  =  UserDefaults.standard.string(forKey: "customerId")
    let userType =  UserDefaults.standard.string(forKey: "UserType")
    
    
    override func viewDidAppear(_ animated: Bool) {
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favBtn = self.tabBarController?.navigationItem.rightBarButtonItem
        favBtn = UIBarButtonItem(title: "", image: UIImage(systemName: "heart.fill"), target: self, action:#selector(addToFav))
       // setCarBtn()
        isItemAdded()
        //        scrollview.contentSize = CGSize(width: 400, height: 2300)
        imsgesCollectionView.dataSource = self
        imsgesCollectionView.delegate = self
        startTimer()
        
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        registerTableCell(tableView: reviewsTableView)
        
       // let tab = UITapGestureRecognizer(target: self, action: #selector(addToFav(_:)))
       // favImg.addGestureRecognizer(tab)
        //favImg.isUserInteractionEnabled = true
        
     
        
        viewModel.bindingProductInfo = { [weak self] in
            DispatchQueue.main.async {
                self?.myProduct = self?.viewModel.product?.product
                self?.productName.text = self?.myProduct?.title
                self?.price.text = self?.myProduct?.variants?[0].price
               // self?.sizeLB.text = self?.myProduct?.variants?[0].title
                self?.setUpSize(size: self?.myProduct?.variants ?? [])
                self?.descriptionLbl.text = self?.myProduct?.description
                self?.slider.numberOfPages = self?.myProduct?.images?.count ?? 0
                self?.proImages = self?.myProduct?.images ?? []
                self?.imsgesCollectionView.reloadData()
                self?.favPro = FavProduct(id: self?.myProduct.id,title: self?.myProduct.title,rate: 3.5, price: self?.myProduct.variants?[0].price, image: self?.myProduct.image?.src,userId: "\(String(describing: self?.userId))")
                self?.check()
                
            }
        }
        viewModel.getProductDetails(productId: productId)
        
        
    }
    
    func setUpSize(size: [ProductVariant]){
        var menuActions: [UIAction] = []
      
        size.forEach({ value in
            let button = UIAction (title:value.title ?? "",state: .on ,handler: { UIAction in
                self.price.text = value.price
            })
            menuActions.append(button)
        })
        
        sizePopButton.menu = UIMenu(children: menuActions)
    }
    
    func check (){
        if  wishListViewModel.isProductExist(product:favPro)  {
            favImg.image = UIImage(systemName: "heart.fill")
            
           // print("Will Appear",favPro)
            
        }else{
            favImg.image = UIImage(systemName: "heart")
          //  print("Will Apear",favPro)
            
        }
    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        if userType == "guest" {
            showLoginAlert(viewController: self)
        }else{
            if viewModel.ISAddedToCart(product: (viewModel.product?.product)!){
              //  viewModel.addToCart(draftOrdrId:getDraftOrdertId(), product: (viewModel.product?.product) ?? Product())
                //createToastMessage(message: "new item added to your cart",view: self.view)
            }
            else{
                self.cartBtn.imageView?.image = UIImage(systemName: "cart.fill")
                viewModel.addToCart(draftOrdrId:getDraftOrdertId(), product: (viewModel.product?.product) ?? Product())
                createToastMessage(message: "new item added to your cart",view: self.view)
            }
        }
    }
    
    func isItemAdded(){
        if viewModel.ISAddedToCart(product: (viewModel.product?.product) ?? Product()){
            cartBtn.imageView?.image = UIImage(systemName: "cart.fill")
        }
        else{
            cartBtn.imageView?.image = UIImage(systemName: "cart")
        }
    }
    
    @IBAction func moreBtn(_ sender: Any) {
        
        let reviewsVC = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsVC") as! ReviewsVC
        reviewsVC.modalPresentationStyle = .fullScreen
        self.present(reviewsVC, animated: true)
    }
    
    @objc func addToFav() {
        

        if userType == "guest" {
            showLoginAlert(viewController: self)
        }else{
            
            if  wishListViewModel.isProductExist(product:favPro) == false {
                wishListViewModel.insertFavProduct(product: favPro)
                favBtn.image = UIImage(systemName: "heart.fill")
            }else{
                // wishListViewModel.deleteFavProduct(product: favPro)
                // favImg.image = UIImage(systemName: "heart")
                let alert = UIAlertController(title: "Delete", message: "Do You want to remove this from your Wishlist?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    self.wishListViewModel.deleteFavProduct(product: self.favPro)
                    self.favBtn.image = UIImage(systemName: "heart")
                }))
                self.present(alert, animated: true)
                
            }
        }
        
    }
}

extension ProductInfoVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return proImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImgCell", for: indexPath) as! ProductImgCell
        
        let url = URL(string: proImages[indexPath.row].src ?? "")
        cell.productImg.kf.setImage(
            with: url,
            placeholder: UIImage(named: "cart"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imsgesCollectionView.frame.width
                      , height:  imsgesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextItem), userInfo: nil, repeats: true)
    }
    
    
    @objc func moveToNextItem(){
        
        if currentIndex < proImages.count-1{
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        
        imsgesCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        slider.currentPage = currentIndex
        
    }
    
}

extension ProductInfoVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell", for: indexPath) as! ReviewsCell
        cell.reviewerText.text = revierText[indexPath.row]
        cell.reviewerImg.image = UIImage(named: revierImages[indexPath.row])
        cell.reviewerName.text = revierNames[indexPath.row]
        return cell
    }
    
    private func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 40
    }
    
    
}
