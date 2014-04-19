//
//  Levels.h
//  MazeADay
//
//  Created by library on 10/29/13.
//  Copyright (c) 2013 me.jamesfolk.mazeaday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TotalTime;

@interface Levels : NSManagedObject

@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSSet *totalTimes;
@end

@interface Levels (CoreDataGeneratedAccessors)

- (void)addTotalTimesObject:(TotalTime *)value;
- (void)removeTotalTimesObject:(TotalTime *)value;
- (void)addTotalTimes:(NSSet *)values;
- (void)removeTotalTimes:(NSSet *)values;

@end
