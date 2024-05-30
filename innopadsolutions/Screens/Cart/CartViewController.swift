//
//  CartViewController.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 31/05/24.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func configUI(){
        cartTableView.register(UINib.init(nibName: TABLE_VIEW_CELL.CartProductTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.CartProductTableViewCell.rawValue)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

//MARK: - TableView DataSource and Delegate Methods
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Cart.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.CartProductTableViewCell.rawValue, for: indexPath) as? CartProductTableViewCell
        else { return UITableViewCell() }
        
        let product = Cart.shared.products[indexPath.row]
        let url = URL(string: product.image ?? "")
        cell.productImg.sd_setImage(with: url , placeholderImage: UIImage(named: "docImg.png"))
        cell.name.text = product.title
        cell.price.text = "$\(product.price ?? 0.0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
