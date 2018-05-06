//
//  MainVC.swift
//  WindDatasApp
//
//  Created by Erencan Evren on 29.04.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainVC: UIViewController {
    @IBOutlet weak var pickerView: CustomPickerView!
    
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnProcess: UIButton!
    @IBOutlet weak var txtData: UITextView!
    @IBOutlet weak var btnReset: UIButton!
    
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    var dic : [String: Any] = [:]
    var jsonArr: [JSON]?
    var filt = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.datePicker.reloadAllComponents()
        pickerView.monthPicker.reloadAllComponents()
        pickerView.yearPicker.reloadAllComponents()
        pickerView.processPicker.reloadAllComponents()
        
        pickerView.del = self
        readFromJsonFile()
    }
    
    private func readFromJsonFile() {
        if let path = Bundle.main.path(forResource: "datas", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               // dic = JSON(data)["array"].array
                jsonArr = JSON(data)["array"].array
            } catch {
                // handle error
            }
        }
    }
    
    @IBAction func btnDayAction(_ sender: Any) {
        pickerView.setPickerFor(pickerView.datePicker)
        animatePicker()
    }
    @IBAction func btnMonethAction(_ sender: Any) {
        pickerView.setPickerFor(pickerView.monthPicker)
        animatePicker()
    }
    @IBAction func btnYearAction(_ sender: Any) {
        pickerView.setPickerFor(pickerView.yearPicker)
        animatePicker()
    }
    @IBAction func btnProcessAction(_ sender: Any) {
        pickerView.setPickerFor(pickerView.processPicker)
        animatePicker()
        //"Min","Max","Mod","Median","STDev"
    
    }
    
    @IBAction func btnResetAction(_ sender: Any) {
        filt = []
        btnDay.setTitle("Gün", for: .normal)
        btnMonth.setTitle("Ay", for: .normal)
        btnYear.setTitle("Year", for: .normal)
        btnProcess.setTitle("İşlem", for: .normal)
        btnReset.setTitle("Sıfırla", for: .normal)

    }
    
    
    @IBAction func btnGraphicAction(_ sender: Any) {
        self.performSegue(withIdentifier: "seguegraph", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ChartVC
        let arr = filt.map{$0["day"].stringValue}
        var hoursArr = [String]()
        arr.forEach { (item) in
            hoursArr.append(item.components(separatedBy: " ")[1])
        }
        
        dest.hours = hoursArr
        
        var speedArr = [Double]()
        for item in filt {
            if item["windSpeed"].stringValue != "" {
                let it = item["windSpeed"].stringValue
                speedArr.append(Double(it)!)
            } else {
                speedArr.append(0.0)
            }
        }
        dest.windSpeeds = speedArr

        
    }
    
    
    func animatePicker() {
        if pickerView.isOpened {
            //KAPA
            UIView.animate(withDuration: 0.4) {
                self.bottomConst.constant = 200
                self.view.layoutIfNeeded()
                self.pickerView.isOpened = false
            }
        } else {
            //AÇ
            UIView.animate(withDuration: 0.4) {
                self.bottomConst.constant = 0
                self.view.layoutIfNeeded()
                self.pickerView.isOpened = true
            }
        }
    }
    
    func dayFilter(_ day: String) {
        
        var newDay = "0"
        if day.count == 1 {
            newDay = "0" + day
        } else {
            newDay = day
        }
        var index = 0
        if filt.count == 0 {
            //filt = (jsonArr?.filter{$0["windSpeed"].doubleValue > 1})!
            if let jsonAr = jsonArr {
                let strArr = jsonAr.map{$0["day"].stringValue}
                for item in strArr {
                    if item.components(separatedBy: " ")[0].components(separatedBy: "-")[0] == newDay {
                        index = strArr.index(of: item)!
                        filt.append(jsonAr[index])
                    }
                }
            }
        } else {
            
            var newFilt = [JSON]()
            let strArr = filt.map{$0["day"].stringValue}
            for item in strArr {
                if item.components(separatedBy: " ")[0].components(separatedBy: "-")[0] == newDay {
                    index = strArr.index(of: item)!
                    newFilt.append(filt[index])
                }
            }
            
            filt = newFilt
        }
    }
    
    func monthFilter(_ month: String) {
        
        var newMonth = "0"
        if month.count == 1 {
            newMonth = "0" + month
        } else {
            newMonth = month
        }
        var index = 0
        if filt.count == 0 {
            //filt = (jsonArr?.filter{$0["windSpeed"].doubleValue > 1})!
            if let jsonAr = jsonArr {
                let strArr = jsonAr.map{$0["day"].stringValue}
                for item in strArr {
                    
                    if item.components(separatedBy: " ")[0].components(separatedBy: "-")[1] == newMonth {
                        index = strArr.index(of: item)!
                        filt.append(jsonAr[index])
                    }
                }
            }
        } else {
            
            var newFilt = [JSON]()
            let strArr = filt.map{$0["day"].stringValue}
            for item in strArr where strArr.count != 0 {
                if item.components(separatedBy: " ")[0].components(separatedBy: "-")[1] == newMonth {
                    index = strArr.index(of: item)!
                    newFilt.append(filt[index])
                }
            }
            
            filt = newFilt
        }
    }
    
    func yearFilter(_ year: String) {
        var index = 0
        if filt.count == 0 {
            //filt = (jsonArr?.filter{$0["windSpeed"].doubleValue > 1})!
            if let jsonAr = jsonArr {
                let strArr = jsonAr.map{$0["day"].stringValue}
                for item in strArr {
                    
                    if item.components(separatedBy: " ")[0].components(separatedBy: "-")[2] == year {
                        index = strArr.index(of: item)!
                        filt.append(jsonAr[index])
                    }
                }
            }
        } else {
            
            var newFilt = [JSON]()
            let strArr = filt.map{$0["day"].stringValue}
            for item in strArr {
                if item.components(separatedBy: " ")[0].components(separatedBy: "-")[2] == year{
                    index = strArr.index(of: item)!
                    newFilt.append(filt[index])
                }
            }
            
            filt = newFilt
        }
    }
    
    
    func processFilter(_ proc: Process) {
        let arr = filt.map{$0["windSpeed"].doubleValue}
        if arr.count != 0 {
            switch proc {
            case Process.mod:
                txtData.text = String(describing: Processes.getMod(arr))
                break
            case Process.median:
                txtData.text = String(describing: Processes.getMedian(arr))
                break
            case Process.min:
                txtData.text = String(describing: Processes.getMin(arr))
                break
            case Process.max:
                txtData.text = String(describing: Processes.getMax(arr))
                break
            case Process.stdev:
                txtData.text = String(describing: Processes.getstDev(arr))
                break
            default:
                break
            }
        }
       
    }
    
    

}

extension MainVC: animatePickerProtocol {
    func animate(_ type: SelectionType) {
        self.animatePicker()
        switch type {
        case SelectionType.day:
            self.btnDay.setTitle(pickerView.selectedDay, for: .normal)
            self.dayFilter(pickerView.selectedDay)
        case SelectionType.month:
            self.btnMonth.setTitle(pickerView.selectedMonth, for: .normal)
            self.monthFilter(pickerView.selectedMonth)
        case SelectionType.year:
            self.btnYear.setTitle(pickerView.selectedYear, for: .normal)
            self.yearFilter(pickerView.selectedYear)
        case SelectionType.process:
            self.btnProcess.setTitle(pickerView.selectedProcess, for: .normal)
            if let title = btnProcess.titleLabel?.text {
                var pType: Process = Process.max
                switch title {
                case "Min":
                    pType = Process.min
                case "Max":
                    pType = Process.max
                case "Mod":
                    pType = Process.mod
                case "Median":
                    pType = Process.median
                case "STDev":
                    pType = Process.stdev
                default:
                    break
                }
                self.processFilter(pType)
            }
        default:
            break
        }
    }
}

