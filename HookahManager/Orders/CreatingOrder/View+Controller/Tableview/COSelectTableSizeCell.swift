//
//  COSelectTableSizeCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 15.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


protocol COSelectTableSizeCellDelegate {
    
    func sizeSelected(sizeIndex: Int, selected: Bool)
}


class COSelectTableSizeCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: COSelectTableSizeCellDelegate?
    
    private var sizes: [TableSize]?
    private var selectedSizeIndex: Int?
    
    
    func configure(sizes: [TableSize], selectedSizeIndex: Int?) {
        
        self.sizes = sizes
        self.selectedSizeIndex = selectedSizeIndex
        collectionView.reloadData()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension COSelectTableSizeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COTableSizeCell", for: indexPath) as! COTableSizeCell
        guard let currentSize = sizes?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(size: currentSize, selected: indexPath.row == selectedSizeIndex)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        if indexPath.row == selectedSizeIndex {
            self.selectedSizeIndex = nil
            collectionView.reloadItems(at: [indexPath])
            delegate?.sizeSelected(sizeIndex: indexPath.row, selected: false)
        } else {
            let itemsToReload = selectedSizeIndex == nil ? [indexPath] : [indexPath, IndexPath(row: selectedSizeIndex!, section: 0)]
            self.selectedSizeIndex = indexPath.row
            print(itemsToReload)
            collectionView.reloadItems(at: itemsToReload)
            delegate?.sizeSelected(sizeIndex: indexPath.row, selected: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height,
                      height: collectionView.bounds.height)
    }
    
}
