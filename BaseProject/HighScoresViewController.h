//
//  HighScoresViewController.h
//  MazeADay
//
//  Created by James Folk on 12/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface HighScoresViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label;

-(void)setViewController:(ViewController*)vc;

@end
