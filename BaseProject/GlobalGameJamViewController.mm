//
//  GlobalGameJamViewController.m
//  MazeADay
//
//  Created by James Folk on 1/24/14.
//  Copyright (c) 2014 JFArmy. All rights reserved.
//

#import "GlobalGameJamViewController.h"
#import "ViewController.h"
#include "GameStateFactory.h"
#import "InstructionGameViewController.h"

@interface GlobalGameJamViewController ()

@end

@implementation GlobalGameJamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *img = [UIImage imageNamed:@"SplashScreen.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    [[self view] addSubview:imageView];
    [[self view] sendSubviewToBack:imageView];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)play
{
    ViewController *pViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    if(pViewController != nil)
    {
        [pViewController setGameStateEnum:GameStateType_GlobalGameJam];
        [pViewController enableDebugDraw:NO];
        [pViewController setDebugViewController:nil];
        [pViewController setGlobalGameJamViewController:self];
        //[pViewController setMainViewController:self];
        
    }
    
    [self.navigationController pushViewController:pViewController animated:YES];
}
- (IBAction)touchUpInside:(id)sender
{
    UIImage *followImageHighlighted = [UIImage imageNamed:@"StartButton2_UnPressed.png"];
    
    [(UIButton*)sender setImage:followImageHighlighted forState:UIControlStateHighlighted];
    
    [self play];
}
- (IBAction)touchDown:(id)sender
{
    UIImage *followImageHighlighted = [UIImage imageNamed:@"StartButton2_Pressed.png"];
    
    [(UIButton*)sender setImage:followImageHighlighted forState:UIControlStateHighlighted];
}


- (IBAction)howTouchUpInside:(id)sender {
    UIImage *followImageHighlighted = [UIImage imageNamed:@"HowToPlay_UnPressed.png"];
    
    [(UIButton*)sender setImage:followImageHighlighted forState:UIControlStateHighlighted];
    
    InstructionGameViewController *pInstructionGameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Instructions"];
    
    [pInstructionGameViewController setGlobalGameJamViewController:self];
    
    [self.navigationController pushViewController:pInstructionGameViewController animated:YES];
}
- (IBAction)howTouchDown:(id)sender {
    UIImage *followImageHighlighted = [UIImage imageNamed:@"HowToPlay_Pressed.png"];
    
    [(UIButton*)sender setImage:followImageHighlighted forState:UIControlStateHighlighted];
}

//- (IBAction)playTouchUpInside:(id)sender
//{
//    [self play];
//}
//- (IBAction)touchDown:(id)sender {
//    UIImage *followImageHighlighted = [UIImage imageNamed:@"Start_Pressed.png"];
//    
//    [(UIButton*)sender setImage:followImageHighlighted forState:UIControlStateHighlighted];
//}

@end
