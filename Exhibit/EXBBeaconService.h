//
//  EXBBeaconService.h
//  Exhibit
//
//  Created by srussell on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXBExhibitService.h"

@interface EXBBeaconService : NSObject

@property (nonatomic) NSString* closestBeaconId;
@property (nonatomic) NSInteger streak;
@property (nonatomic) NSMutableDictionary* beacons;
@property (nonatomic, weak) EXBExhibitService* exhibitService;

-(id)initWithExhibitService:(EXBExhibitService*)exhibitService;
-(void)processBeacons:(NSArray*)beacons;

@end
