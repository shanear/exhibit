//
//  EXBExhibit.h
//  Exhibit
//
//  Created by srussell on 2/22/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXBExhibit : NSObject

-(id)initWithId:(NSString*)id name:(NSString*)name;

@property (nonatomic) NSString* id;
@property (nonatomic) NSString* name;

@end
