//
//  EXBMapViewController.m
//  Exhibit
//
//  Created by Andrew Finch on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import <ESTBeaconManager.h>
#import "EXBBeaconService.h"
#import "EXBExhibitService.h"
#import "EXBMapViewController.h"
#import "EXBDetailsViewController.h"

@interface EXBMapViewController () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) EXBDetailsViewController *detailsVC;
@property (nonatomic, strong) ESTBeaconManager* beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *beaconRegion;
@property (nonatomic, strong) EXBBeaconService *beaconService;
@property (nonatomic, strong) EXBExhibitService *exhibitService;

@end

@implementation EXBMapViewController

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

    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.avoidUnknownStateBeacons = YES;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID: ESTIMOTE_PROXIMITY_UUID
                                                            identifier: @"EstimoteSampleRegion"];
    self.beaconRegion.notifyEntryStateOnDisplay = true;
    
    _exhibitService = [[EXBExhibitService alloc] init];
    _beaconService = [[EXBBeaconService alloc] initWithExhibitService: self.exhibitService];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    
    // Setup two-finger press for artificial beacon trigger
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:@selector(beaconDetected:)];
    [longPressRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:longPressRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beaconDetected:(id)sender {
    [self displayDetailsView];
}

- (void) displayDetailsView {
    
    // If we alreayd have a detailsVC being displayed, remove it
    if (self.detailsVC) {
        [self.detailsVC.view removeFromSuperview];
        self.detailsVC = nil;
    }
    
    // Create a new detailsVC
    self.detailsVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"EXBDetailsViewController"];
    
    self.detailsVC.mapDelegate = self;
    
    UIView *detailsView = self.detailsVC.view;
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.y += frame.size.height;
    CGRect elevatedFrame = frame;
    elevatedFrame.origin.y -= 100;
    elevatedFrame.size.width -= 20;
    elevatedFrame.origin.x += 10;
    
    detailsView.frame = frame;
    
    [self.view addSubview:detailsView];
    
    [UIView animateWithDuration:0.5f animations: ^{
        detailsView.frame = elevatedFrame;
    } completion:^(BOOL finished) {
        CGRect finalFrame = self.detailsVC.view.frame;
        finalFrame.origin.y += 20;
        
        [UIView animateWithDuration:0.5f animations: ^{
            self.detailsVC.view.frame = finalFrame;
        }];
    }];
}

- (void) expandDetailsView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:1.0f animations: ^{
        self.detailsVC.view.frame = frame;
    }];
}

- (void) shrinkDetailsView {
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGRect newDetailsFrame = self.detailsVC.view.frame;
    
    newDetailsFrame.origin.y += (screenFrame.size.height - 100);
    newDetailsFrame.size.width -= 20;
    newDetailsFrame.origin.x += 10;
    
    [UIView animateWithDuration:0.75f animations:^{
        self.detailsVC.view.frame = newDetailsFrame;
    } completion:^(BOOL finished) {
        //self.detailsVC = nil;
    }];
}

-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region
{
    [self.beaconService processBeacons:beacons];
    
    if(self.exhibitService.exhibitChanged) {
        if(self.exhibitService.currentExhibit) {
            [self displayDetailsView];
        }
        else {
            [self shrinkDetailsView];
        }
        
        self.exhibitService.exhibitChanged = false;
        
    }
}
         

@end
