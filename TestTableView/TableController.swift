//
//  ViewController.swift
//  TestTableView
//
//  Created by LuanNX on 1/2/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let fonts = UIFont.familyNames
    var selecteFont:Int = 0
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //let fontstyle = UIFont.fontNames(forFamilyName: font.first!)
   
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return fonts.count
        } else {
            return count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            let label = cell.contentView.viewWithTag(101) as! UILabel
            label.text = "\(indexPath.row + 1 )"+".\(fonts[indexPath.row])"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            let label = cell.contentView.viewWithTag(102) as! UILabel
            label.text = "Style Font"
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selecteFont = indexPath.row
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ALL MY FONTS"
        } else {
            return "ALL MY FAVORITE FONTS"
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next1" {
            let subView = segue.destination as! CellViewController
            subView.delegate = self
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
protocol Share1: class {
    func selectedFont() -> Int
}
extension  TableController:Share1 {
    func selectedFont() -> Int {
        print(self.selecteFont)
        return self.selecteFont
    }
}

