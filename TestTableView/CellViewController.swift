//
//  CellViewController.swift
//  TestTableView
//
//  Created by LuanNX on 1/2/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class CellViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    let fonts = UIFont.familyNames
    var fontStyle:[String]!
    var selectedStyle:String!
    weak var delegate: Share1?
    var fontsFavorite: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        subTableView.delegate = self
        subTableView.dataSource = self
        let index = delegate?.selectedFont()
        fontStyle = UIFont.fontNames(forFamilyName: fonts[index!])
        fontsFavorite = UserDefaults.standard.stringArray(forKey: "fontsFavorite")
    }
        @IBAction func addToFavorite(_ sender: UIButton) {
            let alert = UIAlertController(title: "", message: "Add to favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Add", style: .default,
                                          handler: { action in
                                            guard let superview = sender.superview else {
                                                return }
                                            let cell = superview.superview as! UITableViewCell
                                            let index = self.subTableView.indexPath(for: cell)?.row
                                            let selectedFont = self.fontStyle[index!]
                                            let arr = self.checkFont(array: self.fontsFavorite, font: selectedFont)
                                            
                                            UserDefaults.standard.set(arr, forKey: "fontsFavorite")
                                            self.fontsFavorite = arr
                                            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    @IBOutlet weak var subTableView: UITableView!
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontStyle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subTableView.dequeueReusableCell(withIdentifier: "subcell" , for: indexPath)
        let label = cell.contentView.viewWithTag(103) as! UILabel
        label.text = "\(fontStyle[indexPath.row])"
        label.font = UIFont.init(name: "\(fontStyle[indexPath.row])", size: 15)
        let button = cell.contentView.viewWithTag(104) as! UIButton
        button.restorationIdentifier = "\(indexPath.row)"
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStyle = fontStyle[indexPath.row]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next2" {
            let cellView = segue.destination as! InsideCellViewController
            cellView.delegate = self
        }
    }
    func checkFont(array: [String],font: String) -> [String]{
        var newArr = array
        
        for arr in array {
            if arr == font {
                return newArr
            }
        }
        if newArr.isEmpty {
            newArr = [""]
        }
        if newArr[0] == "" {
            newArr[0] = font
        } else {
            newArr.append(font)
        }
        
        return newArr
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
protocol Share2: class {
    func getStyle() -> String
}
extension CellViewController:Share2 {
    func getStyle() -> String {
        return self.selectedStyle
    }
}

