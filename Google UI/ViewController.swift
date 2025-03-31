//
//  ViewController.swift
//  Google UI
//
//  Created by Swagat Kumar Bisoyi on 28/03/25.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    private var collectionHeight: CGFloat = 100 // Default height

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
        
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // One expandable cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCollectionViewCellType2.identifier, for: indexPath) as? ExpandableCollectionViewCellType2 else {
            return UITableViewCell()
        }
        
        cell.onHeightChange = { [weak self] newHeight in
            self?.collectionHeight = newHeight
//            self?.tableView.reloadData() // Keep it floating, no animation issues
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return collectionHeight + 130 + 20 // Keep floating height in real-time
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
