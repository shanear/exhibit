//
//  EXBExhibit.m
//  Exhibit
//
//  Created by srussell on 2/22/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBExhibit.h"

@implementation EXBExhibit

-(id)initWithId:(NSString*)id name:(NSString*)name
{
    self = [super init];
    _id = id;
    _name = name;
    return self;
}

@end
