////
////  ChartVC.swift
////  demoCharts
////
////  Created by apple on 13/06/24.
////
//
//import UIKit
//import FLCharts
//
//class ChartVC: UIViewController {
//    
//    @IBOutlet weak var barChartView: FLChart!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        
//        showChart(combinedData:[
//            SinglePlotable(name: "Jan", value: 50), // Specific value, Average value
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: -40),
//            SinglePlotable(name: "Apr", value: -5)
//        ])
//    }
//
//    
//    
//    @IBAction func changeChart(_ sender : UIButton){
//        showChart(combinedData:[
//            SinglePlotable(name: "Jan", value: 50), // Specific value, Average value
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: 40),
//            SinglePlotable(name: "Apr", value: 5),
//            SinglePlotable(name: "Jan", value: 50), // Specific value, Average value
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: 40),
//            SinglePlotable(name: "Apr", value: -5),
//            SinglePlotable(name: "Jan", value: 50), // Specific value, Average value
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: 40),
//            SinglePlotable(name: "Apr", value: 5),
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: 40),
//            SinglePlotable(name: "Apr", value: -5),
//            SinglePlotable(name: "Jan", value: 50), // Specific value, Average value
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: 40),
//            SinglePlotable(name: "Apr", value: -5),
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: 40),
//            SinglePlotable(name: "Apr", value: 5),
//            SinglePlotable(name: "Jan", value: 50), // Specific value, Average value
//            SinglePlotable(name: "Feb", value: 20),
//            SinglePlotable(name: "Mar", value: -40),
//            SinglePlotable(name: "Apr", value: 5)
//        ])
//    }
//    
//    
//    var averageColor : UIColor = UIColor.red
//    
//    fileprivate func showChart(combinedData: [SinglePlotable]){
//        // Prepare the combined data for specific and average values
//        
//        
//        // Create chart data with combined data
//        let barChartData = FLChartData(title: "",
//                                       data: combinedData,
//                                       legendKeys: [
//                                        Key(key: "Data", color: FLColor.blue),
//                                        Key(key: "Average", color: FLColor(averageColor))
//                                       ],
//                                       unitOfMeasure: "ML")
//        
//        // Setup the bar chart configuration
//        let barConfig = FLBarConfig(radius: .corners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], 3),
//                                    width: 30,
//                                    spacing: 10,
//                                    limitWidth: true)
//        
//        // Setup the chart with data and type
//        let barChart = FLChart(data: barChartData, type: .bar( highlightView: CustomeBarHighlightedView()))
//        
//        // Configure chart properties
//        barChart.averageLineOverlapsChart = true
//        barChart.showAverageLine = true
//        barChart.showDashedLines = false
//        barChart.config = FLChartConfig(granularityY: 10, // Adjust granularity as needed
//                                        averageView: FLAverageViewConfig(lineWidth: 5,
//                                                                         primaryFont: .systemFont(ofSize: 14, weight: .heavy),
//                                                                         secondaryFont: .systemFont(ofSize: 13, weight: .bold),
//                                                                         primaryColor: .clear,
//                                                                         secondaryColor: .clear,
//                                                                         lineColor:
//                                                averageColor.withAlphaComponent(0.9)))
//        barChart.cartesianPlane.yAxisPosition = .left // Ensure y-axis is visible and set to left
//        barChart.shouldScroll = false
//        
//        
//        // Adjust Y-axis range to display negative values
//        barChart.config.granularityX = -20 // Adjust based on your negative data
//        barChart.config.granularityY = 60  // Adjust based on your positive data
//        
////        let card = FLCard(chart: barChart, style: .rounded)
////        card.showAverage = false
////        card.showLegend = false
////        
//        let card = FLCard(chart: barChart, style: .rounded)
//        card.showAverage = false
//        card.showLegend = true
//        card.layer.shadowOpacity = 0
//        
//        view.addSubview(card)
//        card.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            card.heightAnchor.constraint(equalToConstant: 300), // Increased height for better visibility
//            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//        ])
//    }
//}
