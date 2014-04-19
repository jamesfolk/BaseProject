//
//  InstructionGameViewController.m
//  MazeADay
//
//  Created by James Folk on 1/26/14.
//  Copyright (c) 2014 JFArmy. All rights reserved.
//

#import "InstructionGameViewController.h"

@interface InstructionGameViewController ()

@end

@implementation InstructionGameViewController

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
	// Do any additional setup after loading the view.
    
    UIImage *img = [UIImage imageNamed:@"MenuScreen.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    [[self view] addSubview:imageView];
    [[self view] sendSubviewToBack:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchUpInside:(id)sender {
    [[self getGlobalGameJamViewController].navigationController popViewControllerAnimated:NO];
}
- (IBAction)touchDown:(id)sender {
}

-(void)setGlobalGameJamViewController:(GlobalGameJamViewController*)controller
{
    globalGameJamViewController = controller;
}

-(GlobalGameJamViewController*)getGlobalGameJamViewController
{
    return globalGameJamViewController;
}

@end
