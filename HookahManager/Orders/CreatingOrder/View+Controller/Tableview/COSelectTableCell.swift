//
//  COSelectTableCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 15.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


protocol COSelectTableCellDelegate {
    
    func tableSelected(tableIndex: Int, selected: Bool)
}


class COSelectTableCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var tables: [Table] = []
    var selectedTableIndex: Int?
    
    
    var delegate: COSelectTableCellDelegate?
    
    
    func configure(tables: [Table], selectedTableIndex: Int?) {
        self.tables = tables
        self.selectedTableIndex = selectedTableIndex
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


extension COSelectTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tables.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentTable = tables[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COTableCell",
                                                      for: indexPath) as! COTableCell
        cell.configure(options: currentTable.options, selected: indexPath.row == selectedTableIndex)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        if indexPath.row == selectedTableIndex {
            self.selectedTableIndex = nil
            collectionView.reloadItems(at: [indexPath])
            delegate?.tableSelected(tableIndex: indexPath.row, selected: false)
        } else {
            let itemsToReload = selectedTableIndex == nil ? [indexPath] : [indexPath, IndexPath(row: selectedTableIndex!, section: 0)]
            self.selectedTableIndex = indexPath.row
            print(itemsToReload)
            collectionView.reloadItems(at: itemsToReload)
            delegate?.tableSelected(tableIndex: indexPath.row, selected: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height,
                      height: collectionView.bounds.height)
    }
    
}
