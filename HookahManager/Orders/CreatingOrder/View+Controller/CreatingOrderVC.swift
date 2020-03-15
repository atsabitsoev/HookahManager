//
//  CreatingOrderVC.swift
//  HookahManager
//
//  Created by Ацамаз Бицоев on 10.03.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class CreatingOrderVC: UIViewController {
    
    
    //MARK: UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewSelectDateTime: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var labTitleSelectDateTime: UILabel!
    @IBOutlet weak var labSelectedDay: UILabel!
    @IBOutlet weak var butConfirmDateTime: UIButton!
    @IBOutlet weak var butChooseDateTime: ButtonNext!
    
    var tapRecognizer: UITapGestureRecognizer!
            
    
    var availableDays: [Int]?
    
    var availableTableSizes: [TableSize]?
    var selectedTableSizeIndex: Int? {
        didSet {
            let tables = availableTables.filter { (table) -> Bool in
                guard let selectedTableSizeIndex = selectedTableSizeIndex,
                    let allSizes = availableTableSizes else { return false }
                return table.size == allSizes[selectedTableSizeIndex]
            }
            tablesWithSelectedSize = tables
        }
    }
    
    var availableTables: [Table] = [] {
        didSet {
            var sizes = [TableSize]()
            for table in availableTables {
                guard let size = table.size else { continue }
                if sizes.contains(size) {
                    continue
                } else {
                    sizes.append(size)
                }
            }
            availableTableSizes = sizes
        }
    }
    var tablesWithSelectedSize: [Table] = []
    var selectedTableIndex: Int? {
        didSet {
            if let index = selectedTableIndex {
                let selectedTable = tablesWithSelectedSize[index]
                self.order?.table = selectedTable
            } else {
                self.order?.table = nil
            }
        }
    }
    
    var order: Order?
    
    
    var availableFullDates: [Int] = []
    var shouldShowTimes: Bool {
        get {
            return !availableFullDates.isEmpty
        }
    }
    

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTapRecognizer()
        configureViewSelectDateTime()
        setDelegates()
        setEmptyOrder()
        
        availableTables = [Table(id: "jfsdsdf",
                                 size: TableSize(id: "sfdoii", name: "Маленький", maxCount: 2),
                                 options: ["У окна", "С PlayStation"]),
                           Table(id: "dfgfgsfg",
                                 size: TableSize(id: "4gsffg", name: "Средний", maxCount: 4),
                                 options: ["Мягкие сидения"]),
                           Table(id: "gterggeregr",
                                 size: TableSize(id: "4gsffg", name: "Средний", maxCount: 4),
                                 options: ["У окна", "С PlayStation"])]
        checkButChooseDateTime()
    }


    //MARK: Set Delegates
    private func setDelegates() {
        pickerView.delegate = self
        pickerView.dataSource = self
        tapRecognizer.delegate = self
    }
    
    
    //MARK: Configurations
    private func configureTapRecognizer() {
        tapRecognizer = UITapGestureRecognizer(target: self,
                                               action: #selector(viewTapped))
        tapRecognizer.isEnabled = false
        tabBarController?.view.addGestureRecognizer(tapRecognizer)
    }
    
    private func configureViewSelectDateTime() {
        tabBarController?.view.addSubview(viewSelectDateTime)
        viewSelectDateTime.frame = CGRect(x: 0,
                                          y: UIScreen.main.bounds.maxY,
                                          width: UIScreen.main.bounds.width,
                                          height: 352)
        viewSelectDateTime.layer.cornerRadius = 16
        viewSelectDateTime.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    
    //MARK: Gesture Recognizer
    @objc private func viewTapped() {
        hideViewSelectDateTime()
        availableFullDates = []
    }
    
    
    //MARK: EMPTY ORDER
    private func setEmptyOrder() {
        order = Order(id: nil,
                      number: nil,
                      table: nil,
                      dateTime: nil,
                      orderStatus: .approved,
                      customerName: nil)
    }
    
    
    //MARK: View Select Date Time
    private func showViewSelectDateTime() {
        
        reloadViewSelectDateTime()
        navigationController?.view.isUserInteractionEnabled = false
        
        tapRecognizer.isEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.view.alpha = 0.5
            self.viewSelectDateTime.frame = CGRect(x: 0,
                                                   y: self.viewSelectDateTime.frame.minY - self.viewSelectDateTime.bounds.height,
                                                   width: self.viewSelectDateTime.bounds.width,
                                                   height: self.viewSelectDateTime.bounds.height)
        }
    }
    
    private func hideViewSelectDateTime() {

        navigationController?.view.isUserInteractionEnabled = true
        
        tapRecognizer.isEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.view.alpha = 1
            self.viewSelectDateTime.frame = CGRect(x: 0,
                                                   y: self.viewSelectDateTime.frame.minY + self.viewSelectDateTime.bounds.height,
                                                   width: self.viewSelectDateTime.bounds.width,
                                                   height: self.viewSelectDateTime.bounds.height)
        }
        
    }
    
    private func hideAndShowViewSelectDateTime() {
        UIView.animate(withDuration: 0.15,
                       animations: {
                        self.viewSelectDateTime.frame = CGRect(x: 0,
                                                               y: self.viewSelectDateTime.frame.minY + self.viewSelectDateTime.bounds.height,
                                                               width: self.viewSelectDateTime.bounds.width,
                                                               height: self.viewSelectDateTime.bounds.height)
        }) { (_) in
            self.reloadViewSelectDateTime()
            UIView.animate(withDuration: 0.15) {
                self.viewSelectDateTime.frame = CGRect(x: 0,
                                                       y: self.viewSelectDateTime.frame.minY - self.viewSelectDateTime.bounds.height,
                                                       width: self.viewSelectDateTime.bounds.width,
                                                       height: self.viewSelectDateTime.bounds.height)
            }
        }
    }
    
    
    private func reloadViewSelectDateTime() {
        pickerView.reloadAllComponents()
        labTitleSelectDateTime.text = shouldShowTimes ? "Выбрать время" : "Выбрать день"
        labSelectedDay.text = shouldShowTimes ? availableDays?[pickerView.selectedRow(inComponent: 0)].getDateStringFromSeconds(dateFormat: "dd/MM/yyyy") : ""
        let butTitle = shouldShowTimes ? "Забронировать" : "Подтвердить"
        let butColor = shouldShowTimes ? UIColor.systemGreen : UIColor.systemBlue
        butConfirmDateTime.setTitle(butTitle, for: .normal)
        butConfirmDateTime.backgroundColor = butColor
    }
    
    
    //MARK: Check ButChooseDateTime
    private func checkButChooseDateTime() {
        let enable = !(order?.customerName?.isEmpty ?? true) && order?.table != nil
        butChooseDateTime.isEnabled = enable
        butChooseDateTime.backgroundColor = enable ? UIColor.systemBlue : UIColor.systemBlue.withAlphaComponent(0.5)
    }
    
    
    //MARK: API Work
    private func getAvailableFullDates() {
        availableFullDates = [1583589600, 1583591400, 1583600400, 1583609400]
        hideAndShowViewSelectDateTime()
    }
    
    
    private func createOrder() {
        hideViewSelectDateTime()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: IBActions
    @IBAction func butChooseDateTime(_ sender: Any) {
        showViewSelectDateTime()
    }
    
    
    @IBAction func butConfirmDateTimeTapped(_ sender: Any) {
        if shouldShowTimes {
            createOrder()
        } else {
            getAvailableFullDates()
        }
    }
    
    
}


//MARK: Extensions


//MARK: Name Cell
extension CreatingOrderVC: CONameCellDelegate {
    func nameChanged(to name: String?) {
        order?.customerName = name
        checkButChooseDateTime()
    }
}


//MARK: Picker View
extension CreatingOrderVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if shouldShowTimes {
            return availableFullDates.count
        } else {
            return availableDays?.count ?? 0
        }
    }
    
}

extension CreatingOrderVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if shouldShowTimes {
            return availableFullDates[row].getDateStringFromSeconds(dateFormat: "HH:mm")
        } else {
            return availableDays?[row].getDateStringFromSeconds(dateFormat: "d MMMM")
        }
    }
    
}


//MARK: Tap Recognizer
extension CreatingOrderVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let locationY = touch.location(in: viewSelectDateTime).y
        print(locationY)
        return locationY < 0
    }
}


//MARK: COSelectTableSizeCell
extension CreatingOrderVC: COSelectTableSizeCellDelegate {
    
    func sizeSelected(sizeIndex: Int, selected: Bool) {
        
        self.selectedTableIndex = nil
        
        if selected {
            if selectedTableSizeIndex == nil {
                self.selectedTableSizeIndex = sizeIndex
                tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            } else {
                self.selectedTableSizeIndex = sizeIndex
                tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            }
        } else {
            self.selectedTableSizeIndex = nil
            tableView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
                
    }
    
}


//MARK: COSelectTableCell
extension CreatingOrderVC: COSelectTableCellDelegate {
    
    func tableSelected(tableIndex: Int, selected: Bool) {
        
        if selected {
            self.selectedTableIndex = tableIndex
        } else {
            self.selectedTableIndex = nil
        }
        
        checkButChooseDateTime()
        
    }
    
}



