//
//  MatrisVC.swift
//  WindDatasApp
//
//  Created by Erencan Evren on 13.05.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import UIKit
import SpreadsheetView

class TitleCell: Cell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}

class MatrisVC: UIViewController {
    
    
    @IBOutlet weak var matriceView: SpreadsheetView!
    
    var xArray = [String]()
    var yArray = [String]()
    
    var speeds = [String]()
    var x = 0
    var y = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matriceView.dataSource = self
        matriceView.delegate = self
        matriceView.register(TitleCell.self, forCellWithReuseIdentifier: String(describing: TitleCell.self))
        // Do any additional setup after loading the view.
        prepareArrays()
       // fillCell()
        //fillACell()
    }
    
    func prepareArrays() {
        for i in stride(from: 0, to: 15.1, by: 0.1) {
            xArray.append(String(describing: i))
            yArray.append(String(describing: i))
        }
    
    }
    
    func fillCell() {
        for i in 0..<speeds.count - 1 {
            if i != 0 {
                if speeds[i].contains(".") == false {
                    self.x = xArray.index(of: speeds[i] + ".0")!
                } else {
                    if let x = xArray.index(of: speeds[i]) {
                        self.x = x
                    }
                    
                }
                
                if speeds[i+1].contains(".") == false {
                    self.y = xArray.index(of: speeds[i+1] + ".0")!
                } else {
                    if let y = xArray.index(of: speeds[i+1]) {
                        self.y = y
                    }
                }
                
                var indexPath = IndexPath(row: x, column: y)
                let cell = matriceView.cellForItem(at: indexPath) as! TitleCell
                if cell.label.text == "" {
                    cell.label.text = "1"
                } else {
                    cell.label.text = "\(Int(cell.label.text!)! + 1)"
                }
                
            }
        }
    }
    
    func fillACell() {
        var indexPath = IndexPath(row: 2, column: 2)
        let cell = matriceView.cellForItem(at: indexPath) as! TitleCell
        cell.label.text = "test"
    }



}

extension MatrisVC: SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return yArray.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return xArray.count
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        
        if case (0..<(xArray.count),0) = (indexPath.column, indexPath.row) {
            let cell = matriceView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
            cell.label.text = xArray[indexPath.column]
            cell.label.textColor = .black
            cell.label.numberOfLines = 0
            return cell
        }
        
        if case (0,(0..<(yArray.count))) = (indexPath.column, indexPath.row) {
            let cell = matriceView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
            cell.label.text = yArray[indexPath.row]
            cell.label.textColor = .black
            cell.label.numberOfLines = 0
            return cell
        }
        
        for i in 0..<speeds.count - 1 {
            if i != 0 {
                if speeds[i].contains(".") == false {
                    self.x = xArray.index(of: speeds[i] + ".0")!
                } else {
                    if let x = xArray.index(of: speeds[i]) {
                        self.x = x
                    }

                }

                if speeds[i+1].contains(".") == false {
                    self.y = xArray.index(of: speeds[i+1] + ".0")!
                } else {
                    if let y = xArray.index(of: speeds[i+1]) {
                        self.y = y
                    }
                }


                if case (x, y) = (indexPath.row, indexPath.column) {
                    let cell = matriceView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
                    print(cell.label.textColor)

                    if cell.label.text == "" {
                        cell.label.text = "1"
                    } else {
                        if cell.label.text != "0" && cell.label.text != "1" {
                            cell.label.text = "1"
                        } else {
                           cell.label.text = "\(Int(cell.label.text ?? "0")! + 1)"
                        }
                        
                    }
                    cell.label.textColor = UIColor.red
                    return cell
                }

            }
        }
        
        
        if case ((1..<xArray.count), (1..<yArray.count)) = (indexPath.row, indexPath.column) {
            let cell = matriceView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
            cell.label.text = "0"
            cell.label.textColor = UIColor.blue
            return cell
        }
        
       
        
        return nil
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 80
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
}
