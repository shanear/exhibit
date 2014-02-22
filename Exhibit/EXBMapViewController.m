//
//  EXBMapViewController.m
//  Exhibit
//
//  Created by Andrew Finch on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBMapViewController.h"
#import "EXBDetailsViewController.h"

@interface EXBMapViewController ()

@property (nonatomic, strong) EXBDetailsViewController *detailsVC;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beaconDetected:(id)sender {
    if (((UIButton *)sender).tag == 0) {
        [self displayDetailsView];
    }
}

- (void) displayDetailsView {
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
         

@end
