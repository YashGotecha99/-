//
//  HomeViewController.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 30/05/24.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var productsArray : [Products] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        hitGetAllUsersApi()
        // Do any additional setup after loading the view.
        configUI()
    }
    
    func configUI() {
        productsCollectionView.register(UINib(nibName: COLLECTION_VIEW_CELL.ProductsCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: COLLECTION_VIEW_CELL.ProductsCollectionViewCell.rawValue)
        
    }
    @IBAction func cartBtn(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: Storyboard_ID.CartViewController.rawValue) as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: - CollectionView Delegate & Datasource
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: COLLECTION_VIEW_CELL.ProductsCollectionViewCell.rawValue, for: indexPath) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = productsArray[indexPath.row]
        let url = URL(string: product.image ?? "")
        cell.productImg.sd_setImage(with: url , placeholderImage: UIImage(named: "docImg.png"))
        cell.productNameLbl.text = product.title
        cell.productPriceLbl.text = "$\(product.price ?? 0.0)"
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
         
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
 
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: Double(size), height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: Storyboard_ID.itemViewController.rawValue) as! itemViewController
        vc.product = productsArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: All Api's
extension HomeViewController {
        
    func hitGetAllUsersApi() -> Void {
        HomeViewModel.shared.getAllProductsApi() { [self] obj in
            print(obj)
            self.productsArray = obj
            self.productsCollectionView.reloadData()
        }
    }
}
