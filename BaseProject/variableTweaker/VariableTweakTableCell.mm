//
//  VariableTweakTableCell.m
//  BaseProject
//
//  Created by library on 10/7/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "VariableTweakTableCell.h"

@interface VariableTweakTableCell ()
{
    IDType ID;
}
@end

@implementation VariableTweakTableCell

@synthesize textInput;

-(void)valueListener:(float)value
{
    NSString *val = [NSString stringWithFormat:@"%f", value];
    [self.textInput setText:val];
    
    DebugVariable *pDebugVariable = DebugVariableFactory::getInstance()->get(ID);
    if(pDebugVariable)
        pDebugVariable->setValue(value);
    
    [self.stepper setValue:value];
    [self.slider setValue:value];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)sliderChanged:(id)sender
{
    float value = [(UISlider *)sender value];
    [self valueListener:value];
}
- (void)textViewDidChange:(UITextView *)textView
{
    float val = [textView.text floatValue];
    [self setSliderValue:val];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    [textInput setDelegate:self];
}

-(void)setSliderMaxValue:(float)max
{
    [self.slider setMaximumValue:max];
    [self.stepper setMaximumValue:max];
}
-(void)setSliderMinValue:(float)min
{
    [self.slider setMinimumValue:min];
    [self.stepper setMinimumValue:min];
}
-(void)setSliderValue:(float)value
{
    [self valueListener:value];
}
- (IBAction)stepperChanged:(id)sender
{
    float value = [(UIStepper *)sender value];
    [self valueListener:value];
}
-(void)setLabelText:(NSString*)text
{
    [self.label setText:text];
}
-(void)setVariableID:(IDType)_id
{
    ID = _id;
    
}
-(void)setStepperStep:(float)value
{
    self.stepper.stepValue = value;
}
@end
