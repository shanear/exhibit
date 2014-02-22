//
//  EXBExhibit.h
//  Exhibit
//
//  Created by srussell on 2/22/14.
//  Copyright (c) 2014 Happy Hour Devs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXBExhibit : NSObject

-(id)initWithId:(NSString*)anId name:(NSString*)aName;

@property (nonatomic) NSString* exhibitId;
@property (nonatomic) NSString* name;
@property (nonatomic) CGPoint* mapCoords;

@end
