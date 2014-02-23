//
//  EXBExhibitButton.m
//  Exhibit
//
//  Created by Andrew Finch on 2/22/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBExhibitButton.h"

@interface EXBExhibitButton ()

@property (nonatomic, strong) UIImageView *checkMark;
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
        self.layer.borderWidth = 4.0f;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 30;
    }
    return self;
}

- (void)startPulsing {
    self.isPulsing = YES;
    self.layer.borderColor = [UIColor greenColor].CGColor;
    
    self.checkMark = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    [self.checkMark setContentMode:UIViewContentModeScaleAspectFit];
    self.checkMark.image = [UIImage imageNamed:@"check_mark_green"];
    [self addSubview:self.checkMark];
    
    
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
