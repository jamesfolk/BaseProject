//
//  InstructionGameViewController.h
//  MazeADay
//
//  Created by James Folk on 1/26/14.
//  Copyright (c) 2014 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalGameJamViewController.h"

@interface InstructionGameViewController : UIViewController
{
    GlobalGameJamViewController *globalGameJamViewController;
}
@property (weak, nonatomic) IBOutlet UIButton *button;

-(void)setGlobalGameJamViewController:(GlobalGameJamViewController*)controller;
-(GlobalGameJamViewController*)getGlobalGameJamViewController;

@end
