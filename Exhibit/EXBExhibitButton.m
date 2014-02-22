//
//  EXBExhibitButton.m
//  Exhibit
//
//  Created by Andrew Finch on 2/22/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBExhibitButton.h"

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
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 3.0f;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 22.5;
    }
    return self;
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
