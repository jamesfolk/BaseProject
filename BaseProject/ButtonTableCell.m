//
//  ButtonTableCell.m
//  BaseProject
//
//  Created by library on 10/7/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "ButtonTableCell.h"

@implementation ButtonTableCell

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

@end
