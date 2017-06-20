//
//  Charts.swift
//  PractisDemo
//
//  Created by Mehul Solanki on 08/06/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

import UIKit
import SwiftCharts


class Charts: UIViewController {
    
    @IBOutlet weak var expanceTrackingChart: UIView!
    @IBOutlet weak var leaseChart: UIView!
    @IBOutlet weak var roiChart: UIView!
    fileprivate var objROIChart: Chart? // arc
    fileprivate var objExpenceChart: Chart? // arc
    fileprivate var Lchart: Chart? // arc
    fileprivate var gradientPicker: GradientPicker? // to pick the colors of the bars
    
    override func viewDidLoad() {
        
        
        
        
        let Newframe = CGRect(x: 0.0, y: 0.0, width: expanceTrackingChart.frame.size.width, height: expanceTrackingChart.frame.size.height)
        print("Old Expance tracking frame \(Newframe)")
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.gradientPicker = GradientPicker(width: 200)
            
            self.ROIChart()
            self.loadExpanceChart()
            self.LeaseRenewalChart()
        }
    }
    fileprivate class GradientPicker {
        
        let gradientImg: UIImage
        
        lazy private(set) var imgData: UnsafePointer<UInt8>? = {
            let pixelData = self.gradientImg.cgImage?.dataProvider?.data
            return CFDataGetBytePtr(pixelData)
        }()
        
        init?(width: CGFloat) {
            
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: 0, width: width, height: 1)
            gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            
            let imgHeight = 1
            let imgWidth = Int(gradient.bounds.size.width)
            
            let bitmapBytesPerRow = imgWidth * 4
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue).rawValue
            
            guard let context = CGContext(data: nil,
                                          width: imgWidth,
                                          height: imgHeight,
                                          bitsPerComponent: 8,
                                          bytesPerRow: bitmapBytesPerRow,
                                          space: colorSpace,
                                          bitmapInfo: bitmapInfo) else {
                                            print("Couldn't create context")
                                            return nil
            }
            
            UIGraphicsBeginImageContext(gradient.bounds.size)
            gradient.render(in: context)
            
            guard let gradientImg = (context.makeImage().map{UIImage(cgImage: $0)}) else {
                print("Couldn't create image")
                UIGraphicsEndImageContext()
                return nil
            }
            
            UIGraphicsEndImageContext()
            self.gradientImg = gradientImg
        }
        
        func colorForPercentage(_ percentage: CGFloat) -> UIColor {
            guard let data = imgData else {print("Couldn't get imgData, returning black"); return UIColor.black}
            
            let xNotRounded = gradientImg.size.width * percentage
            let x = 4 * (floor(abs(xNotRounded / 4)))
            let pixelIndex = Int(x * 4)
            
            let color = UIColor(
                red: CGFloat(data[pixelIndex + 0]) / 255.0,
                green: CGFloat(data[pixelIndex + 1]) / 255.0,
                blue: CGFloat(data[pixelIndex + 2]) / 255.0,
                alpha: CGFloat(data[pixelIndex + 3]) / 255.0
            )
            return color
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    func LeaseRenewalChart()
    {
        
        let vals: [(title: String, val: CGFloat)] = [
            ("U", -75),
            ("T", -65),
            ("S", -50),
            ("R", -45),
            ("Q", -40),
            ("P", -30),
            ("O", -20),
            ("N", -10),
            ("M", -5),
            ("L", -0),
            ("K", 10),
            ("J", 15),
            ("I", 20),
            ("H", 30),
            ("G", 35),
            ("F", 40),
            ("E", 50),
            ("D", 60),
            ("C", 65),
            ("B", 70),
            ("A", 75)
        ]
        
        let (minVal, maxVal): (CGFloat, CGFloat) = vals.reduce((min: CGFloat(0), max: CGFloat(0))) {tuple, val in
            (min: min(tuple.min, val.val), max: max(tuple.max, val.val))
        }
        let length: CGFloat = maxVal - minVal
        
        let zero = ChartAxisValueDouble(0)
        let bars: [ChartBarModel] = vals.enumerated().map {index, tuple in
            let percentage = (tuple.val - minVal - 0.01) / length // FIXME without -0.01 bar with 1 (100 perc) is black
            let color = gradientPicker?.colorForPercentage(percentage).withAlphaComponent(0.6) ?? {print("No gradient picker, defaulting to black"); return UIColor.black}()
            return ChartBarModel(constant: ChartAxisValueDouble(Double(index)), axisValue1: zero, axisValue2: ChartAxisValueDouble(Double(tuple.val)), bgColor: color)
        }
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let labelsGenerator = ChartAxisLabelsGeneratorFunc {scalar in
            return ChartAxisLabel(text: "\(scalar)", settings: labelSettings)
        }
        let xGenerator = ChartAxisGeneratorMultiplier(20)
        
        let xModel = ChartAxisModel(firstModelValue: -80, lastModelValue: 80, axisTitleLabels: [ChartAxisLabel(text: "Axis title", settings: labelSettings)], axisValuesGenerator: xGenerator, labelsGenerator: labelsGenerator)
        
        let yValues = [ChartAxisValueString(order: -1)] + vals.enumerated().map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} + [ChartAxisValueString(order: vals.count)]
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        
        let Newframe = CGRect(x: 0.0, y: 0.0, width: roiChart.frame.size.width, height: roiChart.frame.size.height)
        print("New Expance tracking frame \(Newframe)")
        let chartFrame = ExamplesDefaults.chartFrame(Newframe)
        
        // calculate coords space in the background to keep UI smooth
        DispatchQueue.global(qos: .background).async {
            
            let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
            
            let coordsSpace = ChartCoordsSpaceLeftTopSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
            
            DispatchQueue.main.async {
                
                let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
                
                let barViewSettings = ChartBarViewSettings(animDuration: 0.5, selectionViewUpdater: ChartViewSelectorBrightness(selectedFactor: 0.5))
                let barsLayer = ChartBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, bars: bars, horizontal: true, barWidth: Env.iPad ? 40 : 16, settings: barViewSettings)
                
                let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
                let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, axis: .x, settings: settings)
                
                // create x zero guideline as view to be in front of the bars
                let dummyZeroXChartPoint = ChartPoint(x: ChartAxisValueDouble(0), y: ChartAxisValueDouble(0))
                let xZeroGuidelineLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: [dummyZeroXChartPoint], viewGenerator: {(chartPointModel, layer, chart) -> UIView? in
                    let width: CGFloat = 2
                    let v = UIView(frame: CGRect(x: chartPointModel.screenLoc.x - width / 2, y: chart.contentView.bounds.origin.y, width: width, height: innerFrame.size.height))
                    v.backgroundColor = UIColor(red: 1, green: 69 / 255, blue: 0, alpha: 1)
                    return v
                })
                
                let chart = Chart(
                    frame: chartFrame,
                    innerFrame: innerFrame,
                    settings: chartSettings,
                    layers: [
                        xAxisLayer,
                        yAxisLayer,
                        guidelinesLayer,
                        barsLayer,
                        xZeroGuidelineLayer
                    ]
                )
                
                self.roiChart.addSubview(chart.view)
                self.Lchart = chart
            }
        }
    }
    func ROIChart(){
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let chartPoints = [(0, 0), (4, 4), (8, 11), (9, -2), (11, -10), (12, 3), (15, -18), (18, 10), (20, 15)].map{ChartPoint(x: ChartAxisValueInt($0.0, labelSettings: labelSettings), y: ChartAxisValueInt($0.1))}
        let xValues = chartPoints.map{$0.x}
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 1, maxSegmentCount: 10, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        
        let Newframe = CGRect(x: 0.0, y: 0.0, width: leaseChart.frame.size.width, height: leaseChart.frame.size.height)
        print("New Expance tracking frame \(Newframe)")
        
        let chartFrame = ExamplesDefaults.chartFrame(Newframe)
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.purple, lineWidth: 2, animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], pathGenerator: CatmullPathGenerator()) // || CubicLinePathGenerator
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer
            ]
        )
        
        leaseChart.addSubview(chart.view)
        self.objROIChart = chart
        
    }
    func loadExpanceChart()
    {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        let barsData: [(title: String, min: Double, max: Double)] = [
            ("A", 0, 40),
            ("B", -30, 0),
            ("C", 0, 35),
            ("D", -50, 0),
            ("E", 0, 30),
            ("F", -35, 0),
            ("G", 0, 60),
            ("H", 0, 60),
            ("I", 0, 50),
            ("J", 0, 40),
            ("K", 0, 38),
            ("L", 0, 29)
        ]
        let lineData: [(title: String, val: Double)] = [
        ]
        
        let alpha: CGFloat = 0.5
        let posColor = UIColor.green.withAlphaComponent(alpha)
        let negColor = UIColor.red.withAlphaComponent(alpha)
        let zero = ChartAxisValueDouble(0)
        let bars: [ChartBarModel] = barsData.enumerated().flatMap {index, tuple in
            [
                ChartBarModel(constant: ChartAxisValueDouble(index), axisValue1: zero, axisValue2: ChartAxisValueDouble(tuple.min), bgColor: negColor),
                ChartBarModel(constant: ChartAxisValueDouble(index), axisValue1: zero, axisValue2: ChartAxisValueDouble(tuple.max), bgColor: posColor)
            ]
        }
        let xGenerator = ChartAxisGeneratorMultiplier(1)
        let yGenerator = ChartAxisGeneratorMultiplier(20)
        let labelsGenerator = ChartAxisLabelsGeneratorFunc {scalar in
            return ChartAxisLabel(text: "\(scalar)", settings: labelSettings)
        }
        let xModel = ChartAxisModel(firstModelValue: -1, lastModelValue: Double(barsData.count), axisTitleLabels: [ChartAxisLabel(text: "Axis title", settings: labelSettings)], axisValuesGenerator: xGenerator, labelsGenerator: labelsGenerator)
        let yModel = ChartAxisModel(firstModelValue: -80, lastModelValue: 80, axisTitleLabels: [ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical())], axisValuesGenerator: yGenerator, labelsGenerator: labelsGenerator)
        
        let Newframe = CGRect(x: 0.0, y: 0.0, width: expanceTrackingChart.frame.size.width, height: expanceTrackingChart.frame.size.height)
        print("New Expance tracking frame \(Newframe)")
        
        let chartFrame = ExamplesDefaults.chartFrame(Newframe)
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        let barViewSettings = ChartBarViewSettings(animDuration: 0.5)
        let barsLayer = ChartBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, bars: bars, horizontal: false, barWidth: Env.iPad ? 5 : 1, settings: barViewSettings)
        
        /*
         Labels layer.
         Create chartpoints for the top and bottom of the bars, where we will show the labels.
         There are multiple ways to do this. Here we represent the labels with chartpoints at the top/bottom of the bars. We set some space using domain coordinates, in order for this to be updated properly during zoom / pan. Note that with this the spacing is also zoomed, meaning the labels will move away from the edges of the bars when we scale up, which maybe it's not wanted. More elaborate approaches involve passing a custom transform closure to the layer, or using GroupedBarsCompanionsLayer (currently only for stacked/grouped bars, though any bar chart can be represented with this).
         */
        let labelToBarSpace: Double = 3 // domain units
        let labelChartPoints = bars.map {bar in
            ChartPoint(x: bar.constant, y: bar.axisValue2.copy(bar.axisValue2.scalar + (bar.axisValue2.scalar > 0 ? labelToBarSpace : -labelToBarSpace)))
        }
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        let labelsLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: labelChartPoints, viewGenerator: {(chartPointModel, layer, chart) -> UIView? in
            let label = HandlingLabel()
            let pos = chartPointModel.chartPoint.y.scalar > 0
            label.text = "\(formatter.string(from: NSNumber(value: chartPointModel.chartPoint.y.scalar - labelToBarSpace))!)%"
            label.font = ExamplesDefaults.labelFont
            label.sizeToFit()
            label.center = CGPoint(x: chartPointModel.screenLoc.x, y: pos ? innerFrame.origin.y : innerFrame.origin.y + innerFrame.size.height)
            label.alpha = 0
            label.movedToSuperViewHandler = {[weak label] in
                UIView.animate(withDuration: 0.3, animations: {
                    if label?.text == "-6%"
                    {
                        //                        label?.text = ""
                        label?.alpha = 0
                        
                    }else{
                        label?.alpha = 1
                    }
                    label?.center.y = chartPointModel.screenLoc.y
                })
            }
            return label
            
        }, displayDelay: 0.5, mode: .translate) // show after bars animation
        
        // NOTE: If you need the labels from labelsLayer to stay at the same distance from the bars during zooming, i.e. that the space between them and the bars is not scaled, use mode: .custom and pass a custom transform block, in which you update manually the position. Similar to how it's done in e.g. NotificationsExample for the notifications views.
        
        // line layer
        let lineChartPoints = lineData.enumerated().map {index, tuple in ChartPoint(x: ChartAxisValueDouble(index), y: ChartAxisValueDouble(tuple.val))}
        let lineModel = ChartLineModel(chartPoints: lineChartPoints, lineColor: UIColor.black, lineWidth: 2, animDuration: 0.5, animDelay: 1)
        let lineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
        // circles layer
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let color = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
            //            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 0)
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 6)
            circleView.animDuration = 0.5
            circleView.fillColor = color
            return circleView
        }
        let lineCirclesLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: lineChartPoints, viewGenerator: circleViewGenerator, displayDelay: 1.5, delayBetweenItems: 0.05, mode: .translate)
        
        
        // show a gap between positive and negative bar
        let dummyZeroYChartPoint = ChartPoint(x: ChartAxisValueDouble(0), y: ChartAxisValueDouble(0))
        let yZeroGapLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: [dummyZeroYChartPoint], viewGenerator: {(chartPointModel, layer, chart) -> UIView? in
            let height: CGFloat = 2
            let v = UIView(frame: CGRect(x: chart.contentView.frame.origin.x + 2, y: chartPointModel.screenLoc.y - height / 2, width: chart.contentView.frame.origin.x + chart.contentView.frame.height, height: height))
            v.backgroundColor = UIColor.clear
            return v
        })
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            //            layers: [
            //                xAxisLayer,
            //                yAxisLayer,
            //                barsLayer,
            //                labelsLayer,
            //                yZeroGapLayer,
            //                lineLayer,
            //                lineCirclesLayer
            //            ]
            
            layers: [
                xAxisLayer,
                yAxisLayer,
                barsLayer,
                labelsLayer,
                yZeroGapLayer,
                lineLayer,
                lineCirclesLayer
                
            ]
        )
        expanceTrackingChart.addSubview(chart.view)
        self.objExpenceChart = chart
        
    }
    
}
