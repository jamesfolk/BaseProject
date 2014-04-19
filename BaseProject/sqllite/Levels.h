//
//  Levels.h
//  MazeADay
//
//  Created by James Folk on 12/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TotalTime;

@interface Levels : NSManagedObject

@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) TotalTime *totalTime;

@end
