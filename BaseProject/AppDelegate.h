//
//  AppDelegate.h
//  BaseProject
//
//  Created by library on 8/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#define APP_HANDLED_URL @"APP_HANDLED_URL"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
    CMMotionManager *motionManager;
    NSArray *_products;
    
}

@property (readonly) CMMotionManager *motionManager;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void)printLevelsForDate:(NSDate*)_date;
-(long)getMazeEntry:(NSDate*)_date theLevel:(int)level;
-(void)addMazeEntry:(NSDate*)date theLevel:(int)level theTotalTime:(long)totalTime;
-(void)initDatabaseForDate:(NSDate*)date numberOfLevels:(int)numberOfLevels;


@end
