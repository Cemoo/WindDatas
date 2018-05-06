//
//  ChartVC.swift
//  WindDatasApp
//
//  Created by Erencan Evren on 5.05.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import UIKit
import Charts

class ChartVC: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    //@IBOutlet weak var chartView: UIView!
    var windSpeeds: [Double] = []
    var hours: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChartView()
        setupLineChartView()
    }
    
    func setupChartView() {
        let stringFormatter = ChartStringFormatter()
        var dataEntries: [BarChartDataEntry] = []
   
        
        stringFormatter.nameValues = hours
        barChartView.xAxis.valueFormatter = stringFormatter
        barChartView.xAxis.setLabelCount(stringFormatter.nameValues.count, force: false)
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = true
        
        barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 0.6)
        barChartView.legend.enabled = false
        barChartView.chartDescription?.enabled = false
        barChartView.drawValueAboveBarEnabled = false

        // create the datapoints
        for (index, dataPoint) in windSpeeds.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(index),
                                              y: dataPoint)
            dataEntries.append(dataEntry)
        }
        
        // create the chartDataSet
        let chartDataSet = BarChartDataSet(values: dataEntries,
                                           label: "Saatler")
        chartDataSet.colors = [UIColor.blue]
        chartDataSet.valueTextColor = UIColor.white
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
        
    }
    
    func setupLineChartView() {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<hours.count {
            let dataEntry = ChartDataEntry(x: windSpeeds[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChartView.data = lineChartData
        
    }
}

class ChartStringFormatter: NSObject, IAxisValueFormatter {
    
    var nameValues: [String]!
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: nameValues[Int(value)])
    }
}
