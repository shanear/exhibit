//
//  EXBBeaconService.m
//  Exhibit
//
//  Created by srussell on 2/21/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import "ESTBeacon.h"
#import "EXBBeaconService.h"

@implementation EXBBeaconService

-(id)initWithExhibitService:(EXBExhibitService*)exhibitService
{
    self = [super init];
    _beacons = [NSMutableDictionary dictionary];
    _exhibitService = exhibitService;
    return self;
}

-(NSString*)generateBeaconId:(ESTBeacon*)beacon
{
    return [NSString stringWithFormat:@"%@-%@", beacon.major, beacon.minor];
}

-(void)logBeaconData
{
    NSLog([NSString stringWithFormat:@"Closest beacon %@ streaking %d", self.closestBeaconId, self.streak]);
}

-(NSString*)getClosestBeaconId:(NSArray*)beacons
{
    for(ESTBeacon* beacon in beacons) {
        if(beacon.rssi > -90) {
            //if([self.exhibitService exhibitForBeaconId:[self generateBeaconId:beacon]]) {
                return [self generateBeaconId:beacon];
            //}
        }
    }
    
    return nil;
}

-(void)processBeacons:(NSArray*)beacons
{
    NSString* closestBeaconId = [self getClosestBeaconId:beacons];;

    if([self.closestBeaconId isEqualToString:closestBeaconId]) {
        self.streak += 1;
        
        if(self.streak > 5) {
            [self.exhibitService enteredBeaconId:self.closestBeaconId];
        }
    }
    else {
        self.closestBeaconId = closestBeaconId;
        self.streak = 1;
    }
    
    [self logBeaconData];
}

@end
