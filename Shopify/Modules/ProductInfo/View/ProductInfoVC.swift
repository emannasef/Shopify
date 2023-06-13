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
    var productId = 8326804767029
    var viewModel:ProductInfoViewModel = ProductInfoViewModel(network: MyNetwork())
    var timer : Timer?
    var currentIndex = 0
    var proImages:[ProductImage] = []
    
    let revierImages = ["person1","person2","person3"]
    
    let revierText = ["I Love This","Meduim quality Product","It's pretty much and I liked it"]
    
    override func viewDidAppear(_ animated: Bool) {
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollview.contentSize = CGSize(width: 400, height: 2300)
//        let userDefultId =  UserDefaults.standard.integer(forKey:"customerId")
//        let userDefaultsName = UserDefaults.standard.string(forKey: "customerName")
//        let isLogedIn = UserDefaults.standard.bool(forKey: "isLogin")
        
//        print("ID in Home\(userDefultId)\n")
//        print("Name in Home \(String(describing: userDefaultsName)) \n")
//        print("Is Logined in Home \(isLogedIn) ")
        
        imsgesCollectionView.dataSource = self
        imsgesCollectionView.delegate = self
        startTimer()
        
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        registerTableCell(tableView: reviewsTableView)
        
        viewModel.getProductDetails(productId: productId)
        
        viewModel.bindingProductInfo = { [weak self] in
            DispatchQueue.main.async {
                let myProduct = self?.viewModel.product?.product
                self?.productName.text = myProduct?.title
                self?.price.text = myProduct?.variants?[0].price
              //  self?.sizeLB.text = myProduct?
                self?.descriptionLbl.text = myProduct?.description
                self?.slider.numberOfPages = myProduct?.images?.count ?? 0
                self?.proImages = myProduct?.images ?? []
                self?.imsgesCollectionView.reloadData()
            }
            
        }
      
    }
    
    @IBAction func addToCart(_ sender: Any) {
    }
    
    @IBAction func moreBtn(_ sender: Any) {
        
        let reviewsVC = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsVC") as! ReviewsVC
        
        self.present(reviewsVC, animated: true)
        
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
