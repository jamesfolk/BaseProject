//
//  ButtonTableCell.m
//  BaseProject
//
//  Created by library on 10/7/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "ButtonTableCell.h"

static ViewController *viewController = nil;

@implementation ButtonTableCell



+(void)setViewController:(ViewController*)vc
{
    viewController = vc;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonTouchUpInside:(id)sender
{
    DebugViewController *pDebugViewController = [viewController getDebugViewController];
    
    [pDebugViewController.navigationController pushViewController:viewController animated:YES];
}


@end
