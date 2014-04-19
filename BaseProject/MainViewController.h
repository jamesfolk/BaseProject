//
//  MainViewController.h
//  BaseProject
//
//  Created by library on 11/8/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;
@property (weak, nonatomic) IBOutlet UILabel *lblUser;
@property (weak, nonatomic) IBOutlet UIButton *request;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

-(void)loggedin;
-(void)loggedout;

@end
