//
//  ButtonTableCell.h
//  BaseProject
//
//  Created by library on 10/7/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "DebugViewController.h"

@interface ButtonTableCell : UITableViewCell
+(void)setViewController:(ViewController*)vc;

@property (weak, nonatomic) IBOutlet UIButton *button;
//@property (weak, nonatomic) ViewController *viewController;
@end
