//
//  EXBExhibitButton.m
//  Exhibit
//
//  Created by Andrew Finch on 2/22/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBExhibitButton.h"

@interface EXBExhibitButton ()

@property BOOL isPulsing;

@end

@implementation EXBExhibitButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.isPulsing = NO;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 3.0f;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 22.5;
    }
    return self;
}

- (void)startPulsing {
    self.isPulsing = YES;
    self.layer.borderColor = [UIColor greenColor].CGColor;
    [self pulse];
}

- (void)stopPulsing {
    self.isPulsing = NO;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}


- (void) pulse {
    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"transform"];
    ba.autoreverses = YES;
    ba.duration = .6;
    ba.delegate = self;
    ba.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
    [self.layer addAnimation:ba forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    if (self.isPulsing) { [self pulse]; }
}

- (void)expandButtonWithMessage:(NSString *)message {
    
//    CABasicAnimation* ba = [CABasicAnimation animationWithKeyPath:@"transform"];
//    ba.autoreverses = YES;
//    ba.duration = 0.3;
//    ba.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)];
//    [self.layer addAnimation:ba forKey:nil];
    
    //CGRect expandedFrame = self.frame;
    //expandedFrame.origin.x -= 20; //11.25;
    //expandedFrame.origin.y -= 20; //11.25;
    
//    
//    self.frame = expandedFrame;
    
    //self.translatesAutoresizingMaskIntoConstraints = YES;
    
//    [UIView animateWithDuration:0.5
//                          delay:0
//                        options:0
//                     animations:^{
//                         //NSLog(@"Before center: %@", NSStringFromCGPoint(self.icon.center));
//                         
//                         self.frame = expandedFrame;
//                         CGAffineTransform transform = self.transform;
//                         self.transform = CGAffineTransformScale(transform, 1.5, 1.5);
//                         
//                         
//                         
//                         //NSLog(@"After center: %@", NSStringFromCGPoint(self.icon.center));
//                     }
//                     completion:^(BOOL finished){
//                         // nothing
//                         //NSLog(@"Completion center: %@", NSStringFromCGPoint(self.icon.center));
//                         
//                     }];
//    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
