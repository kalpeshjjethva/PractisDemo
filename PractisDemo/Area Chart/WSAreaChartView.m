/*
 Copyright (C) 2012, pyanfield  - pyanfield@gmail.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "WSAreaChartView.h"
#import "WSAreaLayer.h"


@implementation WSAreaChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = @"WSAreaChart";
    }
    return self;
}
- (void)drawChart:(NSArray *)arr withColor:(NSDictionary *)dict
{
    [super drawChart:arr withColor:dict];
}
- (void)createChartLayer
{
    NSArray *legendNames = [colorDict allKeys];
    for (int j=0; j<[legendNames count]; j++) {
        NSString *legendName = [legendNames objectAtIndex:j];
        NSMutableArray *points = [[NSMutableArray alloc] init];
        WSAreaLayer *layer = [[WSAreaLayer alloc] init];
        layer.color = [colorDict valueForKey:legendName];
        for (int i=0; i<[datas count]; i++) {
            NSDictionary *data = [datas objectAtIndex:i];
            WSChartObject *chartObj = [data valueForKey:legendName];
            CGFloat yValue = zeroPoint.y - ([chartObj.yValue floatValue]-correctionY)*propotionY;
            CGPoint point = CGPointMake(self.rowWidth*i+zeroPoint.x, yValue);
            [points addObject:[NSValue valueWithCGPoint:point]];
        }
        layer.originalPoint = self.coordinateOriginalPoint;
        layer.points = [points copy];
        layer.frame = self.bounds;
        [layer setNeedsDisplay];
        [chartLayer addSublayer:layer];
      //  layer.path = [self addBezierPathBetweenPoints:points toView:self withColor:[UIColor redColor] andStrokeWidth:1];

    }
}
- (CGPathRef)addBezierPathBetweenPoints:(NSArray *)points
                            toView:(UIView *)view
                         withColor:(UIColor *)color
                    andStrokeWidth:(NSUInteger)strokeWidth
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float granularity = 100;
    
    [path moveToPoint:[[points firstObject] CGPointValue]];
    
    for (int index = 1; index < points.count - 2 ; index++) {
        
        CGPoint point0 = [[points objectAtIndex:index - 1] CGPointValue];
        CGPoint point1 = [[points objectAtIndex:index] CGPointValue];
        CGPoint point2 = [[points objectAtIndex:index + 1] CGPointValue];
        CGPoint point3 = [[points objectAtIndex:index + 2] CGPointValue];
        
        for (int i = 1; i < granularity ; i++) {
            float t = (float) i * (1.0f / (float) granularity);
            float tt = t * t;
            float ttt = tt * t;
            
            CGPoint pi;
            pi.x = 0.5 * (2*point1.x+(point2.x-point0.x)*t + (2*point0.x-5*point1.x+4*point2.x-point3.x)*tt + (3*point1.x-point0.x-3*point2.x+point3.x)*ttt);
            pi.y = 0.5 * (2*point1.y+(point2.y-point0.y)*t + (2*point0.y-5*point1.y+4*point2.y-point3.y)*tt + (3*point1.y-point0.y-3*point2.y+point3.y)*ttt);
            
            if (pi.y > view.frame.size.height) {
                pi.y = view.frame.size.height;
            }
            else if (pi.y < 0){
                pi.y = 0;
            }
            
            if (pi.x > point0.x) {
                [path addLineToPoint:pi];
            }
        }
        
        [path addLineToPoint:point2];
    }
    
    [path addLineToPoint:[[points objectAtIndex:[points count] - 1] CGPointValue]];
    
    CAShapeLayer *shapeView = [[CAShapeLayer alloc] init];
    
    shapeView.path = [path CGPath];
    
    shapeView.strokeColor = [UIColor greenColor].CGColor;  //color.CGColor;
    shapeView.fillColor = [UIColor redColor].CGColor;
    shapeView.lineWidth = strokeWidth;
   // [shapeView setLineCap:kCALineCapRound];
    [view.layer addSublayer:shapeView];
    
    
    return shapeView.path;
}- (void)createCoordinateLayer
{
    xyAxesLayer.yMarkTitles = yMarkTitles;
    xyAxesLayer.xMarkDistance = self.rowWidth;
    xyAxesLayer.xMarkTitles = xMarkTitles;
    xyAxesLayer.zeroPoint = zeroPoint;
    xyAxesLayer.yMarksCount = yMarksCount;
    xyAxesLayer.yAxisLength = yAxisLength;
    xyAxesLayer.xAxisLength = self.rowWidth*xMarksCount;
    xyAxesLayer.originalPoint = self.coordinateOriginalPoint;
    xyAxesLayer.xMarkTitlePosition = kWSAtPoint;
    [xyAxesLayer setNeedsDisplay];
}
- (void)manageAllLayersOrder
{
   // [self.layer addSublayer:titleLayer];
  //  [self.layer addSublayer:legendLayer];
    [self.layer addSublayer:chartLayer];
    [self.layer addSublayer:xyAxesLayer];
}

@end

