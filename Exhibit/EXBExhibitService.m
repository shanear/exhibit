//
//  EXBExhibitService.m
//  Exhibit
//
//  Created by srussell on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "EXBExhibitService.h"

@implementation EXBExhibitService

-(id)init
{
    self = [super init];
    
    self.exhibits = @{ @"37678-62097" : [[EXBExhibit alloc] initWithId: @"matisse" name: @"Matisse from SFMOMA"],
                       @"1337-2" : [[EXBExhibit alloc] initWithId: @"parmigianino" name:@"Poetry of Parmigianino"],
                       @"1337-1" : [[EXBExhibit alloc] initWithId: @"impressionist" name:@"Intimate Impressionism from the National Gallery of Art"]};
    
    return self;
}

-(EXBExhibit*)exhibitForBeaconId: (NSString*)beaconId
{
    return [self.exhibits objectForKey:beaconId];
}

-(NSInteger)percentVisited
{
    NSInteger totalVisited = 0;
    
    for(EXBExhibit* exhibit in [self.exhibits allValues]) {
        if(exhibit.visited) {
            totalVisited += 1;
        }
    }
    
    return (totalVisited * 1.0 / [[self.exhibits allValues] count]) * 100;
}

-(void)enteredBeaconId:(NSString *)beaconId
{
    
    EXBExhibit* newExhibit = [self exhibitForBeaconId:beaconId];
    if(self.currentExhibit != newExhibit) {
        self.currentExhibit = newExhibit;
        self.currentExhibit.visited = YES;
        self.exhibitChanged = true;
    }
}

@end
