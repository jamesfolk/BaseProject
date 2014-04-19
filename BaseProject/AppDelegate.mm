//
//  AppDelegate.m
//  BaseProject
//
//  Created by library on 8/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "AppDelegate.h"

//#import <CoreData/NSManagedObjectContext.h>
//#import <CoreData/NSManagedObjectModel.h>
//#import <CoreData/CoreData.h>
#import "Day.h"
#import "Levels.h"
#import "TotalTime.h"

#include "WorldPhysics.h"
#include "TextureFactory.h"
#include "ZipFileResourceLoader.h"
#include "LocalizedTextLoader.h"
#include "LuaVM.h"
//#include "PlayerInput.h"
#include "DeviceInput.h"
#include "VertexAttributeLoader.h"
#include "CameraFactory.h"
#include "FrameCounter.h"
//#import "SingletonSoundManager.h"
//extern SingletonSoundManager *sharedSoundManager;
#include "GameStateMachine.h"
#include "GameStateFactory.h"
#include "EntityStateFactory.h"
//#include "CollisionFilterBehaviorFactory.h"
//#include "UpdateBehaviorFactory.h"
#include "CollisionResponseBehaviorFactory.h"
#include "TextureBehaviorFactory.h"
#include "ParticleEmitterBehaviorFactory.h"
#include "EntityFactory.h"
#include "ViewObjectFactory.h"
#include "VertexBufferObjectFactory.h"
#include "VBOMaterialFactory.h"
#include "TextViewObjectFactory.h"
#include "ShaderFactory.h"
#include "CollisionShapeFactory.h"
#include "AnimationControllerFactory.h"
#include "SteeringBehaviorFactory.h"
#include "EntityStateMachineFactory.h"
#include "HeadingSmoother.h"
#include "UserSettingsSingleton.h"
#include "DebugVariableFactory.h"
#include "TextureBufferObjectFactory.h"

#include "FacebookSingleton.h"

#import <AdSupport/AdSupport.h>


#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

static void *btAllocJLI(size_t size)
{
	return malloc(size);
}

static void btFreeJLI(void *ptr)
{
	free(ptr);
}

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (void)reload
{
    [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
    
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products)
    {
        if (success)
        {
            _products = products;
            
            for (int i = 0; i < [_products count]; i++)
            {
                SKProduct * product = (SKProduct *) _products[i];
                NSLog(@"%@\n", product.localizedTitle);
            }
        }
    }];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self reload];
    
    //btAlignedAllocSetCustom(btAllocJLI, btFreeJLI);
    
    //_eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    
    // Setup TestFlight
#if defined(TESTFLIGHT)
//    [TestFlight setDeviceIdentifier:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
//    [TestFlight takeOff:@"62b9eedf-09b6-47a8-b490-82cad7392f0a"];
//    
//    // Use this option to notifiy beta users of any updates
//    [TestFlight setOptions:@{ TFOptionDisableInAppUpdates : @YES }];
#endif
    
    
    
    
    
    //[self createFactories];
    EntityStateFactory::createInstance();
    GameStateFactory::createInstance();
    GameStateMachine::createInstance();
    UserSettingsSingleton::createInstance();
    [self initDatabaseForDate:[NSDate date] numberOfLevels:45];
    ZipFileResourceLoader::createInstance();
    LuaVM::createInstance();
    //PlayerInput::createInstance();
    DeviceInput::createInstance(); 
    FrameCounter::createInstance();
    
//    sharedSoundManager = [SingletonSoundManager sharedSoundManager];
//#if defined(DEBUG) || defined (_DEBUG)
//    [sharedSoundManager errorAL:__FILE__ funct:__FUNCTION__ line:__LINE__];
//#endif
    
    ViewObjectFactory::createInstance();
    VertexBufferObjectFactory::createInstance();
    VBOMaterialFactory::createInstance();
    TextViewObjectFactory::createInstance();
    
    WorldPhysics::createInstance();
    TextureFactory::createInstance();
    
    
    
    
    
    VertexAttributeLoader::createInstance();
    CameraFactory::createInstance();
    //CollisionFilterBehaviorFactory::createInstance();
    //UpdateBehaviorFactory::createInstance();
    CollisionResponseBehaviorFactory::createInstance();
    TextureBehaviorFactory::createInstance();
    ParticleEmitterBehaviorFactory::createInstance();
    EntityFactory::createInstance();
    
    ShaderFactory::createInstance();
    CollisionShapeFactory::createInstance();
    AnimationControllerFactory::createInstance();
    SteeringBehaviorFactory::createInstance();
    EntityStateMachineFactory::createInstance();
    HeadingSmoother::createInstance();
    
    LocalizedTextLoader::createInstance();
    
    DebugVariableFactory::createInstance();
    
    TextureBufferObjectFactory::createInstance();
    
    FacebookSingleton::createInstance();
    
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call)
    {
        if (call.appLinkData && call.appLinkData.targetURL)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_HANDLED_URL
                                                                object:call.appLinkData.targetURL];
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    GameStateMachine::getInstance()->enablePause();
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    GameStateMachine::getInstance()->saveDefaultData();
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    GameStateMachine::getInstance()->loadDefaultData();
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    GameStateMachine::getInstance()->saveDefaultData();
    
    TextureBufferObjectFactory::destroyInstance();
    
    DebugVariableFactory::destroyInstance();
    
    LocalizedTextLoader::destroyInstance();
    GameStateFactory::destroyInstance();
    EntityStateFactory::destroyInstance();
    GameStateMachine::destroyInstance();
    UserSettingsSingleton::destroyInstance();
    ZipFileResourceLoader::destroyInstance();
    DeviceInput::destroyInstance();
    //PlayerInput::destroyInstance();
    LuaVM::destroyInstance();
    FrameCounter::destroyInstance();
    
//    [sharedSoundManager shutdownSoundManager];
//    sharedSoundManager = nil;
    
    HeadingSmoother::destroyInstance();
    EntityStateMachineFactory::destroyInstance();
    SteeringBehaviorFactory::destroyInstance();
    AnimationControllerFactory::destroyInstance();
    CollisionShapeFactory::destroyInstance();
    ShaderFactory::destroyInstance();
    TextViewObjectFactory::destroyInstance();
    ViewObjectFactory::destroyInstance();
    VBOMaterialFactory::destroyInstance();
    VertexBufferObjectFactory::destroyInstance();
    EntityFactory::destroyInstance();
    ParticleEmitterBehaviorFactory::destroyInstance();
    TextureBehaviorFactory::destroyInstance();
    CollisionResponseBehaviorFactory::destroyInstance();
    //UpdateBehaviorFactory::destroyInstance();
    //CollisionFilterBehaviorFactory::destroyInstance();
    CameraFactory::destroyInstance();
    VertexAttributeLoader::destroyInstance();
    
    TextureFactory::destroyInstance();
    WorldPhysics::destroyInstance();
    
    FacebookSingleton::destroyInstance();
    
    [self saveContext];
    
    [[FBSession activeSession] close];
    
    
//    [EAGLContext setCurrentContext:[self getEAGLContext]];
//    if ([EAGLContext currentContext] == [self getEAGLContext])
//    {
//        [EAGLContext setCurrentContext:nil];
//    }
//    _eaglContext = nil;
    
    //[self destroyFactories];
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


- (CMMotionManager *)motionManager
{
    if (!motionManager) motionManager = [[CMMotionManager alloc] init];
    return motionManager;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MazeADay" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MazeADay.sqlite"];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)populateCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    long _time = [self getMazeEntry:[NSDate date] theLevel:indexPath.row];
    
    NSString *level = [[NSString alloc] initWithFormat:@"%d", indexPath.row];
    NSString *time = [[NSString alloc] initWithFormat:@"%ld", _time];
    cell.textLabel.text = level;
    cell.detailTextLabel.text = time;
}

-(void)printLevelsForDate:(NSDate*)_date
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    
    NSString *todaysDate = [formatter stringFromDate:_date];
    NSDate *date = [formatter dateFromString:todaysDate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Day"
                                              inManagedObjectContext:context];
    
    NSString *attributeName = @"datePlayed";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", attributeName, date];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:pred];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Day *day in fetchedObjects)
    {
        NSDate *datePlayed = day.datePlayed;
        
        for(Levels *levels in day.levels)
        {
            NSNumber *level = levels.level;
            
            TotalTime *totalTimes = levels.totalTime;
            NSNumber *totalTime = totalTimes.totalTime;
            NSLog(@"\nDate: %@\nLevel: %d\nTotalTime: %ld\n\n",
                  datePlayed,
                  [level integerValue],
                  [totalTime longValue]);
        }
    }
}

-(Day*)getDay:(NSDate*)date
{
    Day *ret = nil;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Day"
                                              inManagedObjectContext:context];
    
    NSString *attributeName = @"datePlayed";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", attributeName, date];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:pred];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedObjects count] > 0)
    {
        ret = [fetchedObjects objectAtIndex:0];
    }
    
    return ret;
}

-(Levels*)getLevels:(Day*)day theLevel:(int)level
{
    for(Levels *levels in day.levels)
    {
        if([levels.level integerValue] == level)
        {
            return levels;
        }
    }
    
    return nil;
}

-(TotalTime*)getTotalTime:(Levels*)levels
{
    return levels.totalTime;
}

-(Day*)createDayObject:(NSDate*)date
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSLog(@"add a new date");
    //add a new date
    Day *_day = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Day"
                 inManagedObjectContext:context];
    _day.datePlayed = date;
    
    return _day;
}

-(Levels*)createLevelsObject:(int)level
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSLog(@"add a new level");
    
    //add a new level
    Levels *_levels = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Levels"
                       inManagedObjectContext:context];
    _levels.level = [NSNumber numberWithInt:level];
    
    return _levels;
}

-(TotalTime*)createTotalTimeObject:(double)totalTime
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSLog(@"add a new time");
    
    //add a new time
    TotalTime *_totalTime = [NSEntityDescription
                             insertNewObjectForEntityForName:@"TotalTime"
                             inManagedObjectContext:context];
    
    _totalTime.totalTime =[NSNumber numberWithDouble:totalTime];
    
    return _totalTime;
}

//return the fastest time for a level on a date.
//If there is no time available, return std::numeric_limits<long>::max();
-(long)getMazeEntry:(NSDate*)_date theLevel:(int)level
{
    long totalTime = std::numeric_limits<long>::max();
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    
    NSString *todaysDate = [formatter stringFromDate:_date];
    NSDate *date = [formatter dateFromString:todaysDate];
    
    Day *queried_day = [self getDay:date];
    
    if(nil != queried_day)
    {
        Levels *queried_levels = [self getLevels:queried_day theLevel:level];
        
        if(nil != queried_levels)
        {
            TotalTime *queried_totalTime = [self getTotalTime:queried_levels];
            if(nil != queried_totalTime)
            {
                totalTime = queried_totalTime.totalTime.longValue;
            }
        }
    }
    
    return totalTime;
}

//add a the fastest time for a level on a given date or update the fastest time.
-(void)addMazeEntry:(NSDate*)_date
           theLevel:(int)level
       theTotalTime:(long)totalTime
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    
    NSString *todaysDate = [formatter stringFromDate:_date];
    NSDate *date = [formatter dateFromString:todaysDate];
    
    Day *queried_day = [self getDay:date];
    
    //if the day already exists...
    if(nil != queried_day)
    {
        Levels *queried_levels = [self getLevels:queried_day theLevel:level];
        
        if(nil != queried_levels)
        {
            TotalTime *queried_totalTime = [self getTotalTime:queried_levels];
            
            if(nil == queried_totalTime)
            {
                TotalTime *_totalTime = [self createTotalTimeObject:totalTime];
                
                //set total time relationship to levels
                [queried_levels setTotalTime:_totalTime];
            }
            else
            {
                queried_totalTime.totalTime =[NSNumber numberWithDouble:totalTime];
            }
        }
        else
        {
            TotalTime *_totalTime = [self createTotalTimeObject:totalTime];
            Levels *_levels = [self createLevelsObject:level];
            
            //set total time relationship to levels
            [_levels setTotalTime:_totalTime];
            
            //add level relationship to day
            [queried_day addLevelsObject:_levels];
        }
    }
    else
    {
        TotalTime *_totalTime = [self createTotalTimeObject:totalTime];
        Levels *_levels = [self createLevelsObject:level];
        Day *_day = [self createDayObject:date];
        
        //set total time relationship to levels
        [_levels setTotalTime:_totalTime];
        
        //add level relationship to day
        [_day addLevelsObject:_levels];
    }
    
    if (![context save:&error])
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

-(void)initDatabaseForDate:(NSDate*)date numberOfLevels:(int)numberOfLevels
{
    for (int i = 1; i <= numberOfLevels; i++)
    {
        [self addMazeEntry:date theLevel:i theTotalTime:std::numeric_limits<long>::max()];
    }
}

@end
