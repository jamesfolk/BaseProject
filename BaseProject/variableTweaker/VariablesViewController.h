//
//  VariablesViewController.h
//  BaseProject
//
//  Created by library on 10/7/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface VariablesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void)setViewController:(ViewController*)vc;
//+ (NSString*)base64forData:(NSData*)theData;
@end
