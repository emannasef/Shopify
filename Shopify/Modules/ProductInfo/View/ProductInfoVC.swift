//
//  ProductInfoVC.swift
//  ShopifyUser
//
//  Created by Mac on 09/06/2023.
//

import UIKit
import Kingfisher

class ProductInfoVC: UIViewController{
    
    
    //    @IBOutlet weak var discriptionTxt: UITextView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var sizeLB: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var slider: UIPageControl!
    @IBOutlet weak var imsgesCollectionView: UICollectionView!
    @IBOutlet weak var productName: UILabel!
    var productId = 8360376402229
    var viewModel:ProductInfoViewModel = ProductInfoViewModel(network: Network())
    var wishListViewModel = WishListViewModel(myCoreData: MyCoreData.sharedInstance)
    var myProduct:MyProduct!
    var timer : Timer?
    var currentIndex = 0
    var proImages:[ProductImage] = []
    var favPro:FavProduct = FavProduct()
    
    let revierImages = ["person1","person2","person3"]
    let revierText = ["I Love This","Meduim quality Product","It's pretty much and I liked it"]
    
    
    override func viewDidAppear(_ animated: Bool) {
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        scrollview.contentSize = CGSize(width: 400, height: 2300)
        imsgesCollectionView.dataSource = self
        imsgesCollectionView.delegate = self
        startTimer()
        
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        registerTableCell(tableView: reviewsTableView)
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(addToFav(_:)))
        favImg.addGestureRecognizer(tab)
        favImg.isUserInteractionEnabled = true
        
       
        
        viewModel.bindingProductInfo = { [weak self] in
            DispatchQueue.main.async {
                self?.myProduct = self?.viewModel.product?.product
                self?.productName.text = self?.myProduct?.title
                self?.price.text = self?.myProduct?.variants?[0].price
                self?.sizeLB.text = self?.myProduct?.variants?[0].title
                self?.descriptionLbl.text = self?.myProduct?.description
                self?.slider.numberOfPages = self?.myProduct?.images?.count ?? 0
                self?.proImages = self?.myProduct?.images ?? []
                self?.imsgesCollectionView.reloadData()
                self?.favPro = FavProduct(id: self?.myProduct.id,title: self?.myProduct.title,rate: 3.5, price: "500", image: self?.myProduct.image?.src)
                self?.check()
                
            }
        }
        viewModel.getProductDetails(productId: productId)
        
        
    }
    
    func check (){
        if  wishListViewModel.isProductExist(product:favPro)  {
            favImg.image = UIImage(named: "filled.png")
            print("Will Appear",favPro)
            
        }else{
            favImg.image = UIImage(named: "outlined.png")
            print("Will Apear",favPro)

        }
    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        
        viewModel.addToCart(draftOrdrId:1117412819253/*getDraftOrdertId()*/, product: (viewModel.product?.product) ?? Product())
        createToastMessage(message: "new iten added to your cart",view: self.view)
        
    }
    
    @IBAction func moreBtn(_ sender: Any) {
        
        let reviewsVC = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsVC") as! ReviewsVC
        reviewsVC.modalPresentationStyle = .fullScreen
        self.present(reviewsVC, animated: true)
    }
    
    @objc func addToFav(_ sender:UITapGestureRecognizer) {
        
        if  wishListViewModel.isProductExist(product:favPro) == false {
            wishListViewModel.insertFavProduct(product: favPro)
            favImg.image = UIImage(named: "filled.png")
        }else{
            wishListViewModel.deleteFavProduct(product: favPro)
            favImg.image = UIImage(named: "outlined.png")
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
        
        return cell
    }
    
    
}
