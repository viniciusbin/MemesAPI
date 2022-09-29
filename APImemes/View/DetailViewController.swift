//
//  DetailViewController.swift
//  APImemes
//
//  Created by Vinicius on 21/09/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var memeNameDetail: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    
    var meme: MemeObj?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeNameDetail.text = meme?.name
        imageDetail.downloaded(from: meme?.url ?? "")
        
    }
    

}
