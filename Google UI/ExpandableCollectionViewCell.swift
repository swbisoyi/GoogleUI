//
//  ExpandableCollectionViewCell.swift
//  Google UI
//
//  Created by Swagat Kumar Bisoyi on 28/03/25.
//

import UIKit

class ExpandableCollectionViewCell: UITableViewCell {
    
    static let identifier = "ExpandableCollectionViewCell"

    var collectionView: UICollectionView!
    var height: CGFloat = 300 // Initial height
    var panGesture: UIPanGestureRecognizer!
    var layout: UICollectionViewFlowLayout!

    var onHeightChange: ((CGFloat) -> Void)? // Callback to notify height changes
    var label1 : UILabel = UILabel()
    var label2 : UILabel = UILabel()
    var label3 : UILabel = UILabel()
    var label4 : UILabel = UILabel()
    var label5 : UILabel = UILabel()
    var parentOfAllLabel = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        addPanGesture()
        self.addItemsInsideIt()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        updateItemSize(for: height)
        
        collectionView = UICollectionView(frame: CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 40, height: height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self

        contentView.addSubview(collectionView)
    }
    func addItemsInsideIt(){
        self.parentOfAllLabel.frame = CGRect(x: 0, y: height + 10, width: UIScreen.main.bounds.width, height: 130)
        contentView.addSubview(self.parentOfAllLabel)
        
        label1.frame = CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 40, height: 20)
        label1.text = "Label1"
        self.contentView.addSubview(label1)

        label2.frame = CGRect(x: 20, y: 30, width: UIScreen.main.bounds.width - 40, height: 20)
        label2.text = "label2"
        self.contentView.addSubview(label2)

        label3.frame = CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 20)
        label3.text = "label3"
        self.contentView.addSubview(label3)

        label4.frame = CGRect(x: 20, y: 70, width: UIScreen.main.bounds.width - 40, height: 20)
        label1.text = "label4"
        self.contentView.addSubview(label4)

        label5.frame = CGRect(x: 20, y: 90, width: UIScreen.main.bounds.width - 40, height: 20)
        label1.text = "label5"
        self.contentView.addSubview(label5)

    }
    private func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        collectionView.addGestureRecognizer(panGesture)
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: contentView)

        switch gesture.state {
        case .changed:
            let newHeight = max(300, min(600, height - translation.y))
            height = newHeight
            collectionView.frame.size.height = height
            updateItemSize(for: height) // Adjust cell size
            onHeightChange?(height)
            collectionView.reloadData() // Refresh UI
            
        case .ended:
            let finalHeight: CGFloat = height > 450 ? 600 : 300
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.height = finalHeight
                self.collectionView.frame.size.height = finalHeight
                self.updateItemSize(for: finalHeight) // Adjust cell size
                self.onHeightChange?(finalHeight)
                self.collectionView.reloadData() // Refresh UI
            }

        default:
            break
        }

        gesture.setTranslation(.zero, in: contentView)
    }
    private func updateItemSize(for height: CGFloat) {
        let newSize = height / 6  // Adjust item size dynamically
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: newSize)
    }

}
// MARK: - UICollectionView DataSource
extension ExpandableCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Example number of cells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
