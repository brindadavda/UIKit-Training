//
//  ViewController.swift
//  demoCharts
//
//  Created by apple on 06/06/24.
//

import UIKit
import DGCharts

class ViewController: UIViewController {
    
    @IBOutlet weak var dailyBarChartView: BarChartView!
    @IBOutlet weak var weeklyBarChartView: BarChartView!
    @IBOutlet weak var monthlyBarChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure your bar charts here
        configureDailyBarChart()
        configureWeeklyBarChart()
        configureMonthlyBarChart()
    }
    
    func configureDailyBarChart() {
        // Populate data for the last 7 days
        let dailyDataEntries = [BarChartDataEntry(x: 1, y: 100), BarChartDataEntry(x: 2, y: 150), /* Add more entries */]
        
        let dataSet = BarChartDataSet(entries: dailyDataEntries, label: "Last 7 Days")
        let data = BarChartData(dataSet: dataSet)
        
        
        dailyBarChartView.data = data
        
        
        // Remove numbers from the axes
        dailyBarChartView.xAxis.drawLabelsEnabled = false
        dailyBarChartView.leftAxis.drawLabelsEnabled = false
        
    }
    
    func configureWeeklyBarChart() {
        // Populate data for the last 7 weeks
        let weeklyDataEntries = [BarChartDataEntry(x: 1, y: 200), BarChartDataEntry(x: 2, y: 250), /* Add more entries */]
        
        let dataSet = BarChartDataSet(entries: weeklyDataEntries, label: "Last 7 Weeks")
        let data = BarChartData(dataSet: dataSet)
        
        weeklyBarChartView.data = data
//        
//        // Remove numbers from the axes
        weeklyBarChartView.xAxis.drawLabelsEnabled = false
        weeklyBarChartView.leftAxis.drawLabelsEnabled = false
    }
    
    func configureMonthlyBarChart() {
        // Populate data for the last 7 months
        let monthlyDataEntries = [BarChartDataEntry(x: 1, y: 300), BarChartDataEntry(x: 2, y: 350), /* Add more entries */]
        
        let dataSet = BarChartDataSet(entries: monthlyDataEntries, label: "Last 7 Months")
        let data = BarChartData(dataSet: dataSet)
//        
        monthlyBarChartView.data = data
        
        // Remove numbers from the axes
        monthlyBarChartView.xAxis.drawLabelsEnabled = false
        monthlyBarChartView.leftAxis.drawLabelsEnabled = false
    }
}
