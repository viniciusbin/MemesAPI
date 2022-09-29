//
//  ViewController.swift
//  APImemes
//
//  Created by Vinicius on 15/09/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let service = MemeService()
    var arrayMeme = [MemeObj]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        service.getMeme { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    print(data)
                    self.arrayMeme = data.data.memes
                case let .failure(error):
                    print(error)
                }
            }
        }
        configTableView()
        
    }

    func configTableView () {
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayMeme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memecell", for: indexPath) as! CustomTableViewCell
        

        let dataAPI = arrayMeme[indexPath.row]
        cell.apiImage.downloaded(from: dataAPI.url)
        cell.imageName.text = dataAPI.name
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.meme = self.arrayMeme[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
