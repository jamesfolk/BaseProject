//
//  VariablesViewController.m
//  BaseProject
//
//  Created by library on 10/7/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "VariablesViewController.h"
#import "VariableTweakTableCell.h"
#import "ButtonTableCell.h"
#include <string>
#include "DebugVariableFactory.h"

#include "NSData+Base64.h"

//static ViewController *viewController = nil;

@interface VariablesViewController ()
{
    ViewController *viewController;
}
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation VariablesViewController
@synthesize dataArray;
@synthesize tableView;

-(void)createMaze:(MFMailComposeViewController*)composeVC
{
    
    NSData *photoData = UIImageJPEGRepresentation([UIImage imageNamed:@"ground.jpg"], 1);
    //MFMailComposeViewController *viewController = [[MFMailComposeViewController alloc] init];
    [composeVC addAttachmentData:photoData mimeType:@"image/jpg" fileName:[NSString stringWithFormat:@"ground.jpg"]];
    
    NSString *imageStr = [photoData base64EncodingWithLineLength:[photoData length]];
    NSString *htmlStr = [NSString stringWithFormat:@"<html><body><img src='data:image/jpeg;base64,%@'></body></html>",imageStr];
    
    [composeVC setMessageBody:htmlStr isHTML:YES];
    
//    UIImage *image = nil;
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
//    NSString *imageStr = [imageData base64EncodingWithLineLength:[imageData length]];
//    
//    NSString *htmlStr = [NSString stringWithFormat:@".....<img src='data:image/jpeg;base64,%@'>.......",imageStr];
//    
//    [mailComposer setMessageBody:htmlStr isHTML:YES];
    
    //if (mailClass != nil)
    //{
        
        // We must always check whether the current device is configured for sending emails
        
        
//        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//        
//        UIGraphicsEndImageContext();
//        //MFMailComposeViewController *composeVC = [[MFMailComposeViewController alloc] init];
//        composeVC.mailComposeDelegate = self;
//        [composeVC setSubject:@"test"];
//        NSString *messageBody = @"";
//        [composeVC setMessageBody:messageBody isHTML:NO];
//        UIImage *artworkImage = viewImage;
//        NSData *artworkJPEGRepresentation = nil;
//        if (artworkImage)
//        {
//            artworkJPEGRepresentation = UIImageJPEGRepresentation(artworkImage, 0.7);
//        }
//        if (artworkJPEGRepresentation)
//        {
//            [composeVC addAttachmentData:artworkJPEGRepresentation mimeType:@"image/jpeg" fileName:@"ground.jpg"];
//        }
//        
//        NSString *emailBody = @"Find out more  App at <a href='http://itunes.apple.com/us/artist/test/id319692005' target='_self'>Test</a>";//add code
//        const char *urtfstring = [emailBody UTF8String];
//        NSData *HtmlData = [NSData dataWithBytes:urtfstring length:strlen(urtfstring)];
//        [composeVC addAttachmentData:HtmlData mimeType:@"text/html" fileName:@""];
//        //Add code
//        //[self presentModalViewController:composeVC animated:YES];
//        //[composeVC release];
//        //[self dismissModalViewControllerAnimated:YES];
//        UIGraphicsEndImageContext();
}

//+ (NSString*)base64forData:(NSData*)theData {
//    const uint8_t* input = (const uint8_t*)[theData bytes];
//    NSInteger length = [theData length];
//    
//    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
//    
//    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
//    uint8_t* output = (uint8_t*)data.mutableBytes;
//    
//    NSInteger i;
//    for (i=0; i < length; i += 3) {
//        NSInteger value = 0;
//        NSInteger j;
//        for (j = i; j < (i + 3); j++) {
//            value <<= 8;
//            
//            if (j < length) {
//                value |= (0xFF & input[j]);
//            }
//        }
//        
//        NSInteger theIndex = (i / 3) * 4;
//        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
//        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
//        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
//        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
//    }
//    
//    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
//}

//- (NSString*)createMazeEmail
//{
//    //Create a string with HTML formatting for the email body
////    NSMutableString *emailBody = [[[NSMutableString alloc] initWithString:@"<html><body>"] retain];
//    NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
//    
//    //Add some text to it however you want
//    [emailBody appendString:@"<p>Some email body text can go here</p>"];
//    //Pick an image to insert
//    //This example would come from the main bundle, but your source can be elsewhere
//    UIImage *emailImage = [UIImage imageNamed:@"Bricks.png"];
//    //Convert the image into data
//    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(emailImage)];
//    //Create a base64 string representation of the data using NSData+Base64
//
//    //NSString *base64String = [imageData base64EncodedString];
//    NSString *base64String = [VariablesViewController base64forData:imageData];
//    //Add the encoded string to the emailBody string
//    //Don't forget the "<b>" tags are required, the "<p>" tags are optional
//    [emailBody appendString:[NSString stringWithFormat:@"<p><b><img src='data:image/png;base64,%@'></b></p>",base64String]];
//    //You could repeat here with more text or images, otherwise
//    //close the HTML formatting
//    [emailBody appendString:@"</body></html>"];
//    NSLog(@"%@",emailBody);
//    return emailBody;
//    
////    //Create the mail composer window
////    MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
////    emailDialog.mailComposeDelegate = self;
////    [emailDialog setSubject:@"My Inline Image Document"];
////    [emailDialog setMessageBody:emailBody isHTML:YES];
////    
////    [self presentModalViewController:emailDialog animated:YES];
////    //[emailDialog release];
////    //[emailBody release];
//}




-(void)setViewController:(ViewController*)vc
{
    viewController = vc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addVariableToTweak:(const std::string)label_value
                sld_value:(float)slider_current_value
                sld_min_value:(float)slider_minimum_value
                sld_max_value:(float)slider_maximum_value
                   var_id:(IDType)variable_id
                stp_value:(float)stepper_current_value;
{
    NSNumber *_id = [[NSNumber alloc] initWithLongLong:variable_id];
    NSString *label = [NSString stringWithUTF8String:label_value.c_str()];
    NSNumber *slider_value = [[NSNumber alloc] initWithFloat:slider_current_value];
    NSNumber *slider_min = [[NSNumber alloc] initWithFloat:slider_minimum_value];
    NSNumber *slider_max = [[NSNumber alloc] initWithFloat:slider_maximum_value];
    NSNumber *stepper_value = [[NSNumber alloc] initWithFloat:stepper_current_value];
    
    NSArray *array = [[NSArray alloc] initWithObjects:_id, label, slider_value, slider_min, slider_max, stepper_value, nil];
    
    [self.dataArray addObject:array];
}

-(void)addVariables
{
    btAlignedObjectArray<DebugVariable*> objects;
    DebugVariable *pDebugVariable = NULL;
    
    [dataArray removeAllObjects];
    
    DebugVariableFactory::getInstance()->get(objects);
    for(int i = 0; i < objects.size(); i++)
    {
        pDebugVariable = objects.at(i);
        
        [self addVariableToTweak:pDebugVariable->getLabel() sld_value:pDebugVariable->getValue() sld_min_value:pDebugVariable->getMinValue() sld_max_value:pDebugVariable->getMaxValue() var_id:pDebugVariable->getID() stp_value:pDebugVariable->getStepperStepValue()];
    }
    
    [tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addVariables];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    dataArray = [[NSMutableArray alloc] init];
    
    if([self.dataArray count] < 1)
    {
        DebugViewController *pDebugViewController = [viewController getDebugViewController];
        
        [pDebugViewController.navigationController pushViewController:viewController animated:YES];
    }

    
    //[self addVariableToTweak:"variable to tweak" sld_value:1.0f sld_min_value:0.0f sld_max_value:10.0f];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count] + 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(VariableTweakTableCell*)createTweakCell:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"VariableCell";
    
    NSArray *ary = [dataArray objectAtIndex:indexPath.row];
    
    VariableTweakTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"VariableTweakTableCell" owner:nil options:nil];
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell = (VariableTweakTableCell*)view;
                
                NSNumber *_id = [ary objectAtIndex:0];
                NSString *label = [ary objectAtIndex:1];
                NSNumber *slider_value = [ary objectAtIndex:2];
                NSNumber *slider_min = [ary objectAtIndex:3];
                NSNumber *slider_max = [ary objectAtIndex:4];
                NSString *stepper_value = [ary objectAtIndex:5];
                
                [cell setLabelText:label];
                
                [cell setSliderMinValue:[slider_min floatValue]];
                [cell setSliderMaxValue:[slider_max floatValue]];
                
                [cell setSliderValue:[slider_value floatValue]];
                [cell setVariableID:[_id longLongValue]];
                
                [cell setStepperStep:[stepper_value floatValue]];
                
            }
        }
    }
    return cell;
}

-(ButtonTableCell*)createButtonCell
{
    static NSString *CellIdentifier = @"ButtonCell";
    //play cell button
    ButtonTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"ButtonTableCell" owner:nil options:nil];
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell = (ButtonTableCell*)view;
                [ButtonTableCell setViewController:viewController];
            }
        }
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = nil;
    
    if(indexPath.row < ([dataArray count]))
    {
        
        _cell = [self createTweakCell:indexPath];
    }
    else
    {
        _cell = [self createButtonCell];
    }
    return _cell;
    
    int numRows = [dataArray count];
    
    if(numRows > 0)
    {
        if(indexPath.row < ([dataArray count]))
        {
            
            _cell = [self createTweakCell:indexPath];
        }
        else
        {
            _cell = [self createButtonCell];
        }
    }
    else
    {
        _cell = [self createButtonCell];
    }
    

    return _cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}


// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    
    
    
	
	//[picker setSubject:@"Maze Variables"];
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObjects:@"jfarmygames@gmail.com", @"jamesfolk1@gmail.com", nil];
    
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	//NSData *myData = [NSData dataWithContentsOfFile:path];
	//[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
	
	// Fill out the email body text
	//NSString *emailBody = @"It is raining in sunny California!";
	//[picker setMessageBody:[self emailBody] isHTML:NO];
	
    [self createMaze:picker];
    
	[self presentViewController:picker animated:YES completion:NULL];
}
-(NSString*)emailBody
{
    //return [self createMazeEmail];
    
    NSString *ret = [[NSString alloc] init];
    ret = @"";
    
    for(int i = 0; i < [dataArray count]; i++)
    {
        NSArray *ary = [dataArray objectAtIndex:i];
        
        NSString *label = [ary objectAtIndex:1];
        NSNumber *slider_value = [ary objectAtIndex:2];
        
        NSString *str = [[NSString alloc] initWithFormat:@"%@ = %f\n", label, [slider_value floatValue]];
        
        ret = [ret stringByAppendingString:str];
    }
    return ret;
}





#pragma mark - Delegate Methods

// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//self.feedbackMsg.text = @"Result: Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
			//self.feedbackMsg.text = @"Result: Mail saved";
			break;
		case MFMailComposeResultSent:
			//self.feedbackMsg.text = @"Result: Mail sent";
			break;
		case MFMailComposeResultFailed:
			//self.feedbackMsg.text = @"Result: Mail sending failed";
			break;
		default:
			//self.feedbackMsg.text = @"Result: Mail not sent";
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}

// -------------------------------------------------------------------------------
//	messageComposeViewController:didFinishWithResult:
//  Dismisses the message composition interface when users tap Cancel or Send.
//  Proceeds to update the feedback message field with the result of the
//  operation.
// -------------------------------------------------------------------------------
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
	//self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
			//self.feedbackMsg.text = @"Result: SMS sending canceled";
			break;
		case MessageComposeResultSent:
			//self.feedbackMsg.text = @"Result: SMS sent";
			break;
		case MessageComposeResultFailed:
			//self.feedbackMsg.text = @"Result: SMS sending failed";
			break;
		default:
			//self.feedbackMsg.text = @"Result: SMS not sent";
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)email:(id)sender
{
    // You must check that the current device can send email messages before you
    // attempt to create an instance of MFMailComposeViewController.  If the
    // device can not send email messages,
    // [[MFMailComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMailComposeViewController canSendMail])
        // The device can send email.
    {
        [self displayMailComposerSheet];
    }
}
@end
