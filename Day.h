//
//  Day.h
//  MazeADay
//
//  Created by library on 10/29/13.
//  Copyright (c) 2013 me.jamesfolk.mazeaday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Levels;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSDate * datePlayed;
@property (nonatomic, retain) NSSet *levels;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)addLevelsObject:(Levels *)value;
- (void)removeLevelsObject:(Levels *)value;
- (void)addLevels:(NSSet *)values;
- (void)removeLevels:(NSSet *)values;

@end
