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
    
    self.exhibits = @{ @"1337-1" : [[EXBExhibit alloc] initWithId: @"matisse" name: @"Matisse from SFMOMA"],
                       @"1337-2" : [[EXBExhibit alloc] initWithId: @"parmigianio" name:@"The Poetry of Parmigianino's \"Schiava Turca\""],
                       @"1337-3" : [[EXBExhibit alloc] initWithId: @"impressionism" name:@"Intimate Impressionism from the National Gallery of Art"]};
    
    return self;
}

-(EXBExhibit*)exhibitForBeaconId: (NSString*)beaconId
{
    return [self.exhibits objectForKey:beaconId];
}

-(void)enteredBeaconId:(NSString *)beaconId
{
    
    EXBExhibit* newExhibit = [self exhibitForBeaconId:beaconId];
    if(self.currentExhibit != newExhibit) {
        self.currentExhibit = newExhibit;
        self.exhibitChanged = true;
    }
}

@end
