//
//  EXBDetailsViewController.h
//  Exhibit
//
//  Created by Andrew Finch on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EXBMapViewController.h"

@interface EXBDetailsViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *exhibitName;
@property (weak, nonatomic) IBOutlet UIImageView *exhibitThumb;

@property (nonatomic, strong) EXBMapViewController *mapDelegate;

-(void)zoomToLocationWithCoords:(CLLocationCoordinate2D)coords;

@end
