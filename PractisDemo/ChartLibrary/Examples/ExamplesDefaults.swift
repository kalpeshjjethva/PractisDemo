//
//  ExamplesDefaults.swift
//  SwiftCharts
//
//  Created by ischuetz on 04/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit
import SwiftCharts

struct ExamplesDefaults {
    
    static var chartSettings: ChartSettings {
        if Env.iPad {
            return iPadChartSettings
        } else {
            return iPhoneChartSettings
        }
    }

    static var chartSettingsWithPanZoom: ChartSettings {
        if Env.iPad {
            return iPadChartSettingsWithPanZoom
        } else {
            return iPhoneChartSettingsWithPanZoom
        }
    }
    
    fileprivate static var iPadChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 0
        chartSettings.top = 5
        chartSettings.trailing = 5
        chartSettings.bottom = 0
        chartSettings.labelsToAxisSpacingX = 0
        chartSettings.labelsToAxisSpacingY = 0
        chartSettings.axisTitleLabelsToLabelsSpacing = 0
        chartSettings.axisStrokeWidth = 0.5
        chartSettings.spacingBetweenAxesX = 5
        chartSettings.spacingBetweenAxesY = 5
        chartSettings.labelsSpacing = 0
        return chartSettings
    }
    
    fileprivate static var iPhoneChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        chartSettings.labelsSpacing = 0
        return chartSettings
    }

    fileprivate static var iPadChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPadChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }

    fileprivate static var iPhoneChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPhoneChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }
    
    static func chartFrame(_ containerBounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: containerBounds.size.width, height: containerBounds.size.height)
    }
    
    static var labelSettings: ChartLabelSettings {
        return ChartLabelSettings(font: ExamplesDefaults.labelFont)
    }
    
    static var labelFont: UIFont {
        return ExamplesDefaults.fontWithSize(Env.iPad ? 4 : 2)
    }
    
    static var labelFontSmall: UIFont {
        return ExamplesDefaults.fontWithSize(Env.iPad ? 4 : 2)
    }
    
    static func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static var guidelinesWidth: CGFloat {
        return Env.iPad ? 0.5 : 0.1
    }
    
    static var minBarSpacing: CGFloat {
        return Env.iPad ? 10 : 5
    }
}
