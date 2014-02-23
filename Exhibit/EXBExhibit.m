//
//  EXBExhibit.m
//  Exhibit
//
//  Created by srussell on 2/22/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBExhibit.h"

@implementation EXBExhibit

@synthesize exhibitId, name, mapCoords;

-(id)initWithId:(NSString*)anId name:(NSString*)aName
{
    self = [super init];
    self.exhibitId = anId;
    self.name = aName;
    self.visited = NO;
    return self;
}

@end
