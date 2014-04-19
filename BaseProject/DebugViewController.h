//
//  DebugViewController.h
//  BaseProject
//
//  Created by library on 9/19/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DebugViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UISwitch *debugSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *variableSwitch;

@end



