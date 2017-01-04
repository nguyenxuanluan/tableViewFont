//
//  FavoriteFontViewController.swift
//  TestTableView
//
//  Created by LuanNX on 1/4/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class FavoriteFontViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var FavoriteTableView: UITableView!
    
    var fontsFavorite = UserDefaults.standard.stringArray(forKey: "fontsFavorite")
    var selectedFont:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteTableView.dataSource = self
        FavoriteTableView.delegate = self
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "responToSwipe:")
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//        self.view.addGestureRecognizer(swipeLeft)
        //deleteButton.isHidden = true
        // Do any additional setup after loading the view.
    }
//    func responToSwipe(gesture: UISwipeGestureRecognizer){
//        deleteButton.isHidden = false
//        
//    }
    @IBAction func touchDeleteButton(_ sender: UIButton) {
        
        guard let superView = sender.superview else {
            return
        }
        guard let cell = superView.superview as? UITableViewCell else {
            return
        }
        let index = self.FavoriteTableView.indexPath(for: cell)
        fontsFavorite?.remove(at: index!.row)
        if (fontsFavorite?.isEmpty)! {
            fontsFavorite = [""]
        }
            FavoriteTableView.reloadData()
        UserDefaults.standard.set(fontsFavorite, forKey: "fontsFavorite")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (fontsFavorite?.isEmpty)! || fontsFavorite?[0] == ""{
            return 0
        }
        else {
            return (fontsFavorite?.count)!
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCelll", for: indexPath)
        if fontsFavorite?[0] == "" {
            
            return cell
        } else {
            let label = cell.contentView.viewWithTag(105) as! UILabel
            label.text = fontsFavorite?[indexPath.row]
            label.font = UIFont.init(name: "\(fontsFavorite?[indexPath.row])", size: 20)
//            let button=cell.contentView.viewWithTag(106) as! UIButton
//            button.isHidden = true
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFont = fontsFavorite?[indexPath.row]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "favorite" {
            let subTableView = segue.destination as! InsideCellViewController
            subTableView.delegate = self
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FavoriteFontViewController:Share2 {
    func getStyle() -> String {
        return self.selectedFont
    }
}
