//
//  EXBExhibitService.h
//  Exhibit
//
//  Created by srussell on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXBExhibit.h"

@interface EXBExhibitService : NSObject

@property (nonatomic) NSDictionary* exhibits;
@property (nonatomic, weak) EXBExhibit* currentExhibit;
@property BOOL exhibitChanged;

-(EXBExhibit*)exhibitForBeaconId:(NSString*)beaconId;
-(void)enteredBeaconId:(NSString*)beaconId;
-(NSInteger)percentVisited;

@end
