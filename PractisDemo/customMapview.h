//
//  customMapview.h
//  PractisDemo
//
//  Created by Mehul Solanki on 07/06/17.
//  Copyright © 2017 sufalam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface customMapview : UIViewController

- (MKPolyline*)polylineWithEncodedString:(NSString*)encodedString;

@end
