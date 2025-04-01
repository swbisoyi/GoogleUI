//
//  ExpandableCollectionViewCellType2.swift
//  Google UI
//
//  Created by Swagat Kumar Bisoyi on 28/03/25.
//

import UIKit

class ExpandableCollectionViewCellType2: UITableViewCell,UIScrollViewDelegate, UICollectionViewDelegate {
    
    static let identifier = "ExpandableCollectionViewCell"

    var collectionView: UICollectionView!
    var height: CGFloat = 100 // Initial height
    var panGesture: UIPanGestureRecognizer!
    var layout: UICollectionViewFlowLayout!
    var isExpanded = "-1"
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
        self.addItemsInsideIt()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isExpanded == "0"{
            self.collectionView.contentOffset.x = 0
            self.expandCollectionView()
            self.isExpanded = "1"
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        updateItemSize(for: height)
        
        collectionView = UICollectionView(frame: CGRect(x: UIScreen.main.bounds.width - 100 - 50, y: 10, width: UIScreen.main.bounds.width - 40, height: height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.addSubview(collectionView)
        delay(0.5) {
            self.isExpanded = "0"
        }
    }
    func addItemsInsideIt(){
        self.parentOfAllLabel.frame = CGRect(x: 0, y: height + 10, width: UIScreen.main.bounds.width, height: 130)
        contentView.addSubview(self.parentOfAllLabel)
        
        label1.frame = CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 40, height: 20)
        label1.text = "Label1"
        self.parentOfAllLabel.addSubview(label1)

        label2.frame = CGRect(x: 20, y: 30, width: UIScreen.main.bounds.width - 40, height: 20)
        label2.text = "label2"
        self.parentOfAllLabel.addSubview(label2)

        label3.frame = CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 20)
        label3.text = "label3"
        self.parentOfAllLabel.addSubview(label3)

        label4.frame = CGRect(x: 20, y: 70, width: UIScreen.main.bounds.width - 40, height: 20)
        label4.text = "label4"
        self.parentOfAllLabel.addSubview(label4)

        label5.frame = CGRect(x: 20, y: 90, width: UIScreen.main.bounds.width - 40, height: 20)
        label5.text = "label5"
        self.parentOfAllLabel.addSubview(label5)

    }
    func frameAdjust(){
        self.parentOfAllLabel.frame = CGRect(x: 0, y: height + 10, width: UIScreen.main.bounds.width, height: 130)
    }
    
      private func expandCollectionView() {
//          guard height < 200 else { return } // Prevent further expansion
          self.collectionView.isUserInteractionEnabled = false
          self.collectionView.isScrollEnabled = false
          UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut) {
              self.height = 200
              self.collectionView.frame = CGRect(x: 20, y: 10, width: UIScreen.main.bounds.width - 40, height: self.height)
              self.collectionView.frame.size.height = self.height
              self.updateItemSize(for: self.height)
              self.onHeightChange?(self.height)
              self.collectionView.reloadData()
              self.frameAdjust()
          }
          delay(1) {
              self.collectionView.isScrollEnabled = true
              self.collectionView.isUserInteractionEnabled = true

          }
      }

      private func collapseCollectionView() {
          guard height > 100 else { return } // Prevent further shrinking
          
          UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut) {
              self.height = 100
              self.collectionView.frame.size.height = self.height
              self.updateItemSize(for: self.height)
              self.onHeightChange?(self.height)
              self.collectionView.reloadData()
          }

          // Re-add swipe gestures after shrinking
      }
    private func updateItemSize(for height: CGFloat) {
        let newSize = height  // Adjust item size dynamically
        layout.itemSize = CGSize(width: newSize, height: newSize)
    }

}
// MARK: - UICollectionView DataSource
extension ExpandableCollectionViewCellType2: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Example number of cells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
