//
//  EXBDetailsViewController.m
//  Exhibit
//
//  Created by Andrew Finch on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBDetailsViewController.h"

@interface EXBDetailsViewController ()

@property BOOL isExpanded;
@property (weak, nonatomic) IBOutlet UILabel *seeMore;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation EXBDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.isExpanded = NO;
    [self zoomToLocationWithCoords:CLLocationCoordinate2DMake(50.11, 3.55)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)zoomToLocationWithCoords:(CLLocationCoordinate2D)coords;
{
    //CLLocationCoordinate2D coordinate;
    //coordinate.latitude = coords[0];
    
    //coordinate.latitude = 50.11;
    //coordinate.longitude = 3.55;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coords, 500, 500);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:viewRegion];
    [self.map setRegion:adjustedRegion animated:YES];
}

- (IBAction)closeButtonPressed:(id)sender {
    self.isExpanded = NO;
    self.seeMore.hidden = NO;
    [self.mapDelegate shrinkDetailsView];
}

- (IBAction)expand:(id)sender {
    if (!self.isExpanded) {
        [self.mapDelegate expandDetailsView];
        self.seeMore.hidden = YES;
        self.isExpanded = YES;
    }
}

@end
