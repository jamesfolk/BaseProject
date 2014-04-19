//
//  DebugViewController.mm
//  BaseProject
//
//  Created by library on 9/19/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "DebugViewController.h"
#import "ViewController.h"
#include "GameStateFactory.h"
#import "AppDelegate.h"
#import "VariablesViewController.h"
#include "FacebookSingleton.h"

@interface DebugViewController ()
{
    NSMutableArray *listItems;
    NSInteger current_row;
    
    GameStateType_e gamestate;
    BOOL enableDebug;
    BOOL enableVariableView;
}
@end
@implementation DebugViewController
@synthesize pickerView;
@synthesize debugSwitch;
@synthesize variableSwitch;

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // self.view.window.rootViewController = self;
}

- (void)handledURL: (NSNotification *)deepLinkNotification
{
    NSURL *targetURL = deepLinkNotification.object;
    FacebookSingleton::getInstance()->processIncomingURL(targetURL);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gamestate = GameStateType_MazeGameState;
    enableDebug = NO;
    enableVariableView = NO;
    
    
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.opaque = NO;
    
    listItems = [[NSMutableArray alloc] init];
    
	[listItems addObject:@"Maze Game"];
	[listItems addObject:@"Font Test"];
    [listItems addObject:@"Path Test"];
    [listItems addObject:@"Physics Test"];
    [listItems addObject:@"Steering Test"];
    [listItems addObject:@"Sprite Test"];
    [listItems addObject:@"Dynamic Image"];
    [listItems addObject:@"Skybox Test"];
    [listItems addObject:@"GlobalGameJam Game"];
    [listItems addObject:@"Rotation Game"];
    [listItems addObject:@"Lua Test Game"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handledURL:) name:APP_HANDLED_URL object:nil];
}
- (void)viewDidUnload
{
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - Picker Methods -
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return listItems.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [listItems objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    current_row = row;
    
    switch (current_row)
    {
        case 0:gamestate = GameStateType_MazeGameState;break;
        case 1:gamestate = GameStateType_FontTestState;break;
        case 2:gamestate = GameStateType_PathTestState;break;
        case 3:gamestate = GameStateType_PhysicsEntityTest;break;
        case 4:gamestate = GameStateType_SteeringEntityTest;break;
        case 5:gamestate = GameStateType_SpriteTest;break;
        case 6:gamestate = GameStateType_DynamicImage;break;
            case 7:gamestate = GameStateType_Skybox;break;
        case 8:gamestate = GameStateType_GlobalGameJam;break;
        case 9:gamestate = GameStateType_Rotation;break;
        case 10:gamestate = GameStateType_LuaTestState;break;
            
        default:
            break;
    }
    
}



-(IBAction) playGame
{
    ViewController *pViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    if(pViewController != nil)
    {
        [pViewController setGameStateEnum:gamestate];
        [pViewController enableDebugDraw:enableDebug];
        [pViewController setDebugViewController:self];
        
    }
    
    if (enableVariableView)
    {
        VariablesViewController *pV = [self.storyboard instantiateViewControllerWithIdentifier:@"VariablesViewController"];
        [pV setViewController:pViewController];
        //[VariablesViewController setViewController:pViewController];
        
        [self.navigationController pushViewController:pV animated:YES];
        //asdf
    }
    else
    {
        [self.navigationController pushViewController:pViewController animated:YES];
    }
    
}
- (IBAction)variableOnOffSwitch:(id)sender
{
    enableVariableView = variableSwitch.on;
}

-(IBAction)onOffSwitch:(id)sender
{
    enableDebug = debugSwitch.on;
}
@end
