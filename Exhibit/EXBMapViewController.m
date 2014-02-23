//
//  EXBMapViewController.m
//  Exhibit
//
//  Created by Andrew Finch on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import <ESTBeaconManager.h>
#import "EXBExhibitButton.h"
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
@property (weak, nonatomic) IBOutlet UIScrollView *mapScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (nonatomic, strong) NSDictionary *exhibitData;
@property BOOL longPressWasDetected;
@property BOOL setupScrollView;

@property (weak, nonatomic) IBOutlet UILabel *explorePercent;

// Exhibit buttons
@property (weak, nonatomic) IBOutlet EXBExhibitButton *parmigianinoButton;
@property (weak, nonatomic) IBOutlet EXBExhibitButton *matisseButton;
@property (weak, nonatomic) IBOutlet EXBExhibitButton *impressionistButton;

@end

@implementation EXBMapViewController

@synthesize matisseButton, parmigianinoButton, impressionistButton;


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
    
    self.longPressWasDetected = NO;
    self.setupScrollView = NO;

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
                                                         action:@selector(longPressDetected)];
    [longPressRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:longPressRecognizer];
    
    self.mapImageView.frame = CGRectMake(100, 100, self.mapImageView.image.size.width, self.mapImageView.image.size.height);
    
    self.mapScrollView.contentSize = CGSizeMake(self.mapImageView.image.size.width + 200, self.mapImageView.image.size.height + 200);
    
    CGPoint initialCoords = CGPointMake(226,300);
    [self.mapScrollView setContentOffset:initialCoords animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)impressionistButtonPressed:(id)sender {
    [(EXBExhibitButton *)sender expandButtonWithMessage:@"Impressionism"];
}

- (IBAction)parmigianinoButtonPressed:(id)sender {
    [(EXBExhibitButton *)sender expandButtonWithMessage:@"Parmigianino"];
}

- (IBAction)matisseButtonPressed:(id)sender {
    [(EXBExhibitButton *)sender expandButtonWithMessage:@"Matisse"];
}


- (void) longPressDetected {
    if (!self.longPressWasDetected) {
        [self beaconDetected];
        self.longPressWasDetected = YES;
    }
}

- (IBAction)beaconDetected {
    [self.exhibitService enteredBeaconId:@"37678-62097"];
    [self displayDetailsView];
    
    [PFCloud callFunctionInBackground:@"visit" withParameters:@{@"phoneID": [[[UIDevice currentDevice] identifierForVendor] UUIDString], @"exhibitID": @"matisse"} block:^(id object, NSError *error) {
        if (!error) {
            NSLog(@"Visit to matisse logged!");
        }
    }];
}

- (void) scrollToExhibit:(NSString *)exhibitId {
    
    [matisseButton stopPulsing];
    [parmigianinoButton stopPulsing];
    [impressionistButton stopPulsing];
    
    if ([exhibitId isEqualToString:@"matisse"]) {
        
        
        CGPoint coords = matisseButton.frame.origin;
        coords.x -= ([[UIScreen mainScreen] bounds].size.width / 2) - 22.5;
        coords.y -= ([[UIScreen mainScreen] bounds].size.height / 2) - 22.5 - 90;
        
        [self.mapScrollView setContentOffset:coords animated:YES];
        [matisseButton startPulsing];
    }
    
    if ([exhibitId isEqualToString:@"impressionist"]) {
        CGPoint coords = impressionistButton.frame.origin;
        coords.x -= ([[UIScreen mainScreen] bounds].size.width / 2) - 22.5;
        coords.y -= ([[UIScreen mainScreen] bounds].size.height / 2) - 22.5 - 90;
        
        [self.mapScrollView setContentOffset:coords animated:YES];
        [impressionistButton startPulsing];

    }
    
    if ([exhibitId isEqualToString:@"parmigianino"]) {
        CGPoint coords = parmigianinoButton.frame.origin;
        coords.x -= ([[UIScreen mainScreen] bounds].size.width / 2) - 22.5;
        coords.y -= ([[UIScreen mainScreen] bounds].size.height / 2) - 22.5 - 90;
        
        [self.mapScrollView setContentOffset:coords animated:YES];
        [parmigianinoButton startPulsing];

    }
}

- (void) displayDetailsView {
    
    // If we already have a detailsVC being displayed, remove it
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
    elevatedFrame.origin.y -= 200;
    elevatedFrame.size.width -= 20;
    elevatedFrame.origin.x += 10;
    
    detailsView.frame = frame;
    
    [self.view addSubview:detailsView];
    
    [UIView animateWithDuration:0.25f animations: ^{
        detailsView.frame = elevatedFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self scrollToExhibit:self.exhibitService.currentExhibit.exhibitId];
        }
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
    
    newDetailsFrame.origin.y += (screenFrame.size.height - 180);
    newDetailsFrame.size.width -= 20;
    newDetailsFrame.origin.x += 10;
    
    [UIView animateWithDuration:0.75f animations:^{
        self.detailsVC.view.frame = newDetailsFrame;
    } completion:^(BOOL finished) {
        //self.detailsVC = nil;
    }];
}

-(void)updateExplorePercent
{
    [self.explorePercent setText:[NSString stringWithFormat:@"%d%% Explored", [self.exhibitService percentVisited]]];
}

-(void)beaconManager:(ESTBeaconManager *)manager
     didRangeBeacons:(NSArray *)beacons
            inRegion:(ESTBeaconRegion *)region
{
    [self.beaconService processBeacons:beacons];
    
    if(self.exhibitService.exhibitChanged) {
        if(self.exhibitService.currentExhibit) {
            [self displayDetailsView];
            [self.detailsVC.exhibitName setText:self.exhibitService.currentExhibit.name];
            self.detailsVC.exhibitThumb.image = [UIImage imageNamed:self.exhibitService.currentExhibit.exhibitId];
            
            [self updateExplorePercent];
            
            [PFCloud callFunctionInBackground:@"visit" withParameters:@{@"phoneID": [[[UIDevice currentDevice] identifierForVendor] UUIDString], @"exhibitID": self.exhibitService.currentExhibit.exhibitId} block:^(id object, NSError *error) {
                if (!error) {
                    NSLog(@"Visit to matisse logged!");
                }
            }];
        }
        else {
            [self shrinkDetailsView];
        }
        
        self.exhibitService.exhibitChanged = false;
        
    }
}

@end
