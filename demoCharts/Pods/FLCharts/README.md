![FLCharts](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/FLCharts_icon.png)

# FLCharts

![Version](https://img.shields.io/cocoapods/v/FLCharts.svg?style=flat) ![Platforms](https://img.shields.io/cocoapods/p/FLCharts.svg?style=flat) ![License](https://img.shields.io/cocoapods/l/FLCharts.svg?style=flat) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![Swift](https://img.shields.io/badge/swift-5.0-brightgreen.svg) ![Xcode 11.0+](https://img.shields.io/badge/Xcode-11.0%2B-blue.svg) ![iOS 11.0+](https://img.shields.io/badge/iOS-11.0%2B-blue.svg) [![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

FLCharts is an easy-to-use library to build highly customizable bar, line and pie charts. It allows you to create your own chart bar `UIView` and use it to display data in the chart.
<br>
Additionally FLCharts allows you to provide a custom `HighlightedView` to show the highlighted bar contents on top of the chart.
<br>
Embed effortlessly your chart in a `FLCard` alogside with a title, an average vlue view and additional behaviours.


# Table of Contents
* [Requirements](#requirements)
* [Installation](#installation)
  * [Swift Package Manager](#SPM)
  * [CocoaPods](#cocoapods)
  * [Carthage](#carthage)
* [Features](#features)
* [Configurations](#configurations)
* [Prebuilt bar cells](#barcells)
* [Docs](#docs)
* [Chart types](#charttypes)
* [Examples](#examples)
* [Animations](#animations)
* [Apps that uses FLCharts](#apps)
* [License](#license)


## Requirements <a name="requirements"></a>
* Xcode 11 / Swift 5
* iOS >= 11.0


## Installation <a name="installation"></a>

FLCharts is available through SPM, CocoaPods and Carthage

### Swift Package Manager <a name="SPM"></a>

In XCode go to `File -> Add Packages...`

Search for `https://github.com/francescoleoni98/FLCharts` and click `Add Package`.

Select to which target you want to add it and select `Add Package`.

### CocoaPods <a name="cocoapods"></a>
FLCharts is available through [CocoaPods](https://cocoapods.org). To install it, add the following line to your Podfile:

```ruby
pod 'FLCharts'
```
Then run `pod install`

### Carthage <a name="carthage"></a>
To install it with Carthage, in your Cartfile add:
```ruby
github "francescoleoni98/FLCharts"
```
Then run `carthage update`

In XCode > Build phases click the plus button on top left > New Run Script Phases. <br>
Then in Run Script > Shell script window > add `/usr/local/bin/carthage copy-frameworks`. <br>
Run Script > Input file window > add `$(SRCROOT)/Carthage/Build/iOS/FLCharts.framework`.

Then, go to `$project_dir/Carthage/Build/iOS` and drag the folder `FLCharts.framework` into your `Xcode Project > Your Target > Frameworks, Libraries and Embedded Content`.

### Example
Here you can find a guide about how to setup a bar chart using FLCharts: <br>
https://medium.com/@leonifrancesco/set-up-a-basic-bar-chart-using-flcharts-swift-d2f615a10d0b

## Features <a name="features"></a>

 - Animations for chart bars
 - Customizable Axes (both x and y axis)
 - Dragging / Panning (with touch-gesture)
 - Highlighting values (with customizable popup-views)
 - Create custom cards with embedded chart and more features
 - Scroll through chart while highlighted to change highlighted bar
 - Fully customizable (bar colors, axes color, background, average value, dashed lines, ...)

## Configurations <a name="configurations"></a>

FLChart is highly customizable. You can choose which property to modify through the .config property.

```swift
let axisLabelConfig = FLAxisLabelConfig(color: .black,
                                        font: .preferredFont(forTextStyle: .body))
                         
chart.config = ChartConfig(axesLabels: axisLabelConfig)
```

## Prebuilt bar cells <a name="barcells"></a>
- `FLPlainChartBar`
- `FLMultipleValuesChartBar`
- `FLHorizontalMultipleValuesChartBar`

Use this bars when you configure your chart.

Eg. `FLChart(data: ..., type: .bar(bar: FLMultipleValuesChartBar.self))`

## Docs <a name="docs"></a>

You can build FLCharts documentation directly in XCode.
</br>
In XCode go to `Product -> Build Documentation`, once XCode has finished building, the documentation will appear.

## Chart types <a name="charttypes"></a>

|  |  |  |
| ----------- | ----------- | ----------- |
| **Plain Bar Chart** | **Multi Value Bar Chart** | **Horizontal Multi Value Bar Chart** |
| Bar class: `FLPlainChartBar` | Bar class: `FLMultipleValuesChartBar` | Bar class: `FLHorizontalMultipleValuesChartBar` |  
| Data type: `SinglePlotable` | Data type: `MultiPlotable` | Data type: `MultiPlotable` |
| ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1143.jpg?raw=true) | ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1144.jpg?raw=true) | ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1145.jpg?raw=true) |
| <img width=0 height=40 /> |  |  |
| **Line Chart** | **Multi Value Line Chart** | **Scatter Chart** |
| Data type: `SinglePlotable` | Data type: `MultiPlotable` | Data type: `ScatterPlotable` |
| ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1148.jpg?raw=true) | ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1146.jpg?raw=true) | ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1149.jpg?raw=true) |
| <img width=0 height=40 /> |  |  |
| **Radar Chart** | **Pie Chart** |
| Data type: `FLDataSet` | Data type: `FLPiePlotable` |
| ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1150.jpg?raw=true) | ![](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/ChartTypes/IMG_1151.jpg?raw=true) |


## Examples <a name="examples"></a>

|  |  |  |
| ----------- | ----------- | ----------- |
| **Highlighted Bar** | **Average view** | **Bar chart embedded in FLCard** |
| Highlight View: `BarHighlightedView` | `showAverage = true` |  |
| ![highlighted bar](https://github.com/francescoleoni98/FLCharts/blob/main/Screenshots/highlightedview_chart.jpg) | ![average view](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/average_line.jpg) | ![bar chart embedded in FLCard](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/FLCard.jpg) |
| <img width=0 height=40 /> |  |  |
| **Dark Mode** | **Line Chart X and Y Segments** | **Pie Chart** |
|  | X Segments: `Key(key: String, xColors: [UIColor])` |  |
|  | Y Segments: `Key(key: String, yThresholds: [CGFloat : UIColor], data: [PlotableData])` |  |
| ![dark mode](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/dark_mode.jpg) | ![x y segments](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/x_y_segments_line_chart.jpg) | ![pie chart](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/pie_chart.png) |


## Animations <a name="animations"></a>

- **Panning while highlighted**

 ![alt tag](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/GIFs/highlighted_pan_animation.gif)

- **Chart animation**

 ![alt tag](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/GIFs/start_bars_animation.gif)

- **Scrolling behaviour with average and highlighted views**

 ![alt tag](https://raw.githubusercontent.com/francescoleoni98/FLCharts/main/Screenshots/GIFs/scrolling_behaviour.gif)


## Apps that uses FLCharts <a name="apps"></a>
- [Aware - Daily Bullet Journal](https://apps.apple.com/it/app/aware-daily-bullet-journal/id1560309401)

## Author

Francesco Leoni | [@franceleonidev](https://twitter.com/franceleonidev) | leoni.francesco98@gmail.it


## License <a name="license"></a>

FLCharts is available under the MIT license. See the LICENSE file for more info.

### My Apps
[Linkboard - Bookmarks Manager](https://apps.apple.com/app/linkboard-websites-manager/id1612805234)
