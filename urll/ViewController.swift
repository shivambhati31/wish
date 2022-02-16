//
//  ViewController.swift
//  urll
//
//  Created by Ritesh Harihar on 14/02/22.
//


import UIKit
import SwiftSoup

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    private let table : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    //frgtnhfn
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib (nibName: "DemoTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        table.delegate = self
        table.dataSource = self
        title = "WishList"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new to do list item!", preferredStyle: .alert)
        alert.addTextField {field in field.placeholder = "Enter Url.."}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self]
            (_) in
            if let field = alert.textFields?[0] {
                if let text = field.text, !text.isEmpty {
                    print(text)
                    DispatchQueue.main.async {
                        self?.urlArray.append(text)
                        self?.table.reloadData()
                    }
                }
            }
        }))
            present(alert, animated: true)
    }
    func getProductImage(url: URL)-> String {
        var result = ""
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
           // print(html)
            let doc: Document = try SwiftSoup.parseBodyFragment(html)
          //  let title: String = try
           // let headerTitle = try doc.title()
            //print("Header title: \(headerTitle)"
            let img: Element = try doc.select(".image-size-wrapper.fp-image-wrapper.image-block-display-flex img").first()!
           let src  = try img.attr("src")

            if src.contains("data:image/gif;base64"){
                
                let dataMidresReplacement  = try img.attr("data-midres-replacement")
                print("dataMidresReplacement: \(dataMidresReplacement)")
                result = dataMidresReplacement
                
            } else {
                result = src
            }
        }
        catch {
            print(error)
        }
        print ("Imageeeeee   \(result)")
        return result
    }

    func getProductTitle(url: URL)-> String {
        var headerTitle=""
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
        
            let doc: Document = try SwiftSoup.parseBodyFragment(html)
             headerTitle = try doc.title()
        }
        catch {
            print(error)
        }
        
        return headerTitle
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell", for: indexPath) as! DemoTableViewCell
        
        print("URLLLLLL   \(urlArray[indexPath.row])")
        
        guard let tempUrl = URL( string : urlArray[indexPath.row] ) else {
            fatalError(" URL not found!!!")
        }
        print ("Titleeee  \(getProductTitle(url : tempUrl))")
        print ("Imageeeeee   \(getProductImage( url : tempUrl ))")
        cell.myLabel.text = getProductTitle(url : tempUrl)
        
        let tempImg = getProductImage( url : tempUrl )
        

        let urlImage = URL(string : tempImg )!

            // Fetch Image Data
            if let data = try? Data(contentsOf: urlImage) {
                // Create Image and Update Image View
                cell.myImageView.image = UIImage(data: data)
            }
        cell.myImageView.backgroundColor = .gray

        return cell
    }


}
    




