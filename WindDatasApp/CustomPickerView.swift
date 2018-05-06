//
//  CustomPickerView.swift
//  WindDatasApp
//
//  Created by Erencan Evren on 29.04.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import UIKit

enum Process {
    case mod,median,min,max,stdev
}

enum SelectionType {
    case day,month,year,process,none
}

class CustomPickerView: UIView {
    
    private var years: [Int] = [11, 12]
    private var days = [Int]()
    private var months: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    private var processes: [String] = ["Min","Max","Mod","Median","STDev"]
    
    var selectedYear: String = ""
    var selectedMonth: String = ""
    var selectedDay: String = ""
    var selectedProcess: String = ""
    
    var isOpened = false
    var del: animatePickerProtocol!
    
    
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var processPicker: UIPickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        datePicker.delegate = self
        datePicker.dataSource = self
        
        monthPicker.delegate = self
        monthPicker.dataSource = self
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        processPicker.delegate = self
        processPicker.dataSource = self
        
        for i in 0..<31 {
            days.append(i)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
        datePicker.delegate = self
        datePicker.dataSource = self
        
        monthPicker.delegate = self
        monthPicker.dataSource = self
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        processPicker.delegate = self
        processPicker.dataSource = self
        
        for i in 0..<31 {
            days.append(i)
        }
    }
    
    // MARK: - setup
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    /// Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    
    @IBAction func btnCancel(_ sender: Any) {
        del.animate(SelectionType.none)
    }
    
    func setPickerFor(_ picker: UIPickerView) {
        switch picker {
        case datePicker:
            datePicker.isHidden = false
            monthPicker.isHidden = true
            yearPicker.isHidden = true
            processPicker.isHidden = true
            break
        case monthPicker:
            datePicker.isHidden = true
            monthPicker.isHidden = false
            yearPicker.isHidden = true
            processPicker.isHidden = true
            break
        case yearPicker:
            datePicker.isHidden = true
            monthPicker.isHidden = true
            yearPicker.isHidden = false
            processPicker.isHidden = true
            break
        case processPicker:
            datePicker.isHidden = true
            monthPicker.isHidden = true
            yearPicker.isHidden = true
            processPicker.isHidden = false
            break
        default:
            break
        }
    }
    
}

extension CustomPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case datePicker:
            return days.count
        case monthPicker:
            return months.count
        case yearPicker:
            return 2
        case processPicker:
            return 5
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case datePicker:
            return days[row].toString()
        case monthPicker:
            return months[row].toString()
        case yearPicker:
            return years[row].toString()
        case processPicker:
            return processes[row]
        default:
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case datePicker:
            selectedDay = days[row].toString()
            del.animate(SelectionType.day)
        case monthPicker:
            selectedMonth = months[row].toString()
            del.animate(SelectionType.month)
        case yearPicker:
            selectedYear = years[row].toString()
            del.animate(SelectionType.year)
        case processPicker:
            selectedProcess = processes[row]
            del.animate(SelectionType.process)
        default:
            break
        }
    }
}

extension Int {
    func toString() -> String {
        return String(describing: self)
    }
}

protocol animatePickerProtocol {
    func animate(_ type: SelectionType)
}

















