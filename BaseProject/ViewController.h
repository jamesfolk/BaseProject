//
//  ViewController.h
//  BaseProject
//
//  Created by library on 8/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "DebugViewController.h"
#import "MainViewController.h"
#import "GlobalGameJamViewController.h"

@interface ViewController : GLKViewController <UIAccelerometerDelegate>
{
    DebugViewController *debugViewController;
    MainViewController *mainViewController;
    GlobalGameJamViewController *globalGameJamViewController;
}

-(EAGLContext*)getContext;

-(void)setDebugViewController:(DebugViewController*)controller;
-(DebugViewController*)getDebugViewController;

-(void)setMainViewController:(MainViewController*)controller;
-(MainViewController*)getMainViewController;

-(void)setGlobalGameJamViewController:(GlobalGameJamViewController*)controller;
-(GlobalGameJamViewController*)getGlobalGameJamViewController;

-(void)enableDebugDraw:(BOOL)enable;
-(void)setGameStateEnum:(int)val;
@end
