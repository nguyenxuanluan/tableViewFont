//
//  InsideCellViewController.swift
//  TestTableView
//
//  Created by LuanNX on 1/3/17.
//  Copyright © 2017 LuanNX. All rights reserved.
//

import UIKit

class InsideCellViewController: UIViewController {
    var size:CGFloat = 30
    var beginValue:CGFloat = 0.5
    weak var delegate: Share2?
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textView: UITextView!
    var style:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        style = delegate?.getStyle()
        textView.font = UIFont.init(name: "\(style!)", size: size)
        // Do any additional setup after loading the view.
    }
    @IBAction func changeValue(_ sender: UISlider) {
        
        size = size*CGFloat(sender.value)/beginValue
        textView.font = UIFont.init(name: "\(style!)", size: size)
        beginValue = CGFloat(sender.value)
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

