//
//  COOrderOptionCell.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 10.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


protocol COOrderOptionCellDelegate {
    func addOption(option: OrderOption)
    func deleteOption(option: OrderOption)
}


class COOrderOptionCell: UITableViewCell {
    
    
    @IBOutlet weak var labTItle: UILabel!
    @IBOutlet weak var switchInclude: UISwitch!
    
    
    var delegate: COOrderOptionCellDelegate?
    
    
    var option: OrderOption!
    
    
    func fill(with option: OrderOption, isIncluded: Bool) {
        self.option = option
        labTItle.text = option.name
        switchInclude.setOn(isIncluded, animated: false)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        
    @IBAction func switchIncludeChanged(_ sender: UISwitch) {
        sender.isOn ? delegate?.addOption(option: option) : delegate?.deleteOption(option: option)
    }
    

}
