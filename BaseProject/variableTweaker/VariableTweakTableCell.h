//
//  VariableTweakTableCell.h
//  BaseProject
//
//  Created by library on 10/7/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DebugVariableFactory.h"

@interface VariableTweakTableCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;


-(void)setSliderMaxValue:(float)max;
-(void)setSliderMinValue:(float)min;
-(void)setSliderValue:(float)value;
-(void)setLabelText:(NSString*)text;
-(void)setVariableID:(IDType)_id;
-(void)setStepperStep:(float)value;
@end
