//
//  ViewController.swift
//  Google UI
//
//  Created by Swagat Kumar Bisoyi on 28/03/25.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    var arrayItem : [sliderModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpandableCollectionViewCellType2.self, forCellReuseIdentifier: ExpandableCollectionViewCellType2.identifier)
        tableView.separatorStyle = .none
        let item1 = sliderModel(dt: ["name1":"name1-1","name2":"name1-2","name3":"name1-3","name4":"name1-4","name5":"name1-5","name6":"name1-6"])
        let item2 = sliderModel(dt: ["name1":"name2-1","name2":"name2-2","name3":"name2-3","name4":"name2-4","name5":"name2-5","name6":"name2-6"])
        let item3 = sliderModel(dt: ["name1":"name3-1","name2":"name3-2","name3":"name3-3","name4":"name3-4","name5":"name3-5","name6":"name3-6"])
        arrayItem.append(item1)
        arrayItem.append(item2)
        arrayItem.append(item3)
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayItem.count // One expandable cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCollectionViewCellType2.identifier, for: indexPath) as? ExpandableCollectionViewCellType2 else {
            return UITableViewCell()
        }
        
        cell.onHeightChange = { [weak self] newHeight in
            self?.arrayItem[indexPath.row].openStatus = 1
            self?.arrayItem[indexPath.row].collectionHeight = newHeight
//            self?.tableView.reloadData() // Keep it floating, no animation issues
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.arrayItem[indexPath.row].collectionHeight + 130 + 20 // Keep floating height in real-time
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
struct sliderModel{
    var name1: String
    var name2: String
    var name3: String
    var name4: String
    var name5: String
    var openStatus = 0
    var collectionHeight : CGFloat = 100
    init(dt:[String:Any]) {
        if dt["name1"] != nil {
            name1 = dt["name1"] as! String
        } else {
            name1 = ""
        }
        if dt["name2"] != nil {
            name2 = "\(dt["name2"]!)"
        } else {
            name2 = ""
        }
        if dt["name3"] != nil {
            name3 = "\(dt["name3"]!)"
        } else {
            name3 = ""
        }
        if dt["name4"] != nil {
            name4 = "\(dt["name4"]!)"
        } else {
            name4 = ""
        }

        if dt["name5"] != nil {
            name5 = "\(dt["name5"]!)"
        } else {
            name5 = ""
        }
        
    }
}
