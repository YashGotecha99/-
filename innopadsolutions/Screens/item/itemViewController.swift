//
//  itemViewController.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 30/05/24.
//

import UIKit

class itemViewController: UIViewController {

    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var product : Products?
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        updateToggleCartButton()
        // Do any additional setup after loading the view.
    }
    
    func configUI(){
        let url = URL(string: product?.image ?? "")
        itemImg.sd_setImage(with: url , placeholderImage: UIImage(named: "docImg.png"))
        nameLbl.text = product?.title ?? ""
        descriptionLbl.text = product?.description ?? ""
        priceLbl.text = "$\(product?.price ?? 0.0)"
    }
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addToCartBtn(_ sender: Any) {
        if let product = product {
            Cart.shared.toggleCartStatus(product: product)
            updateToggleCartButton()
        }
    }
    
    @IBAction func shareBtn(_ sender: Any) {
        guard let imageUrl = product?.image, let url = URL(string: imageUrl) else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    @IBAction func cartBtn(_ sender: Any) {
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: Storyboard_ID.CartViewController.rawValue) as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func updateToggleCartButton() {
        if let product = product, Cart.shared.contains(product: product) {
            addToCartBtn.setTitle("Remove from Cart", for: .normal)
        } else {
            addToCartBtn.setTitle("Add to Cart", for: .normal)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
