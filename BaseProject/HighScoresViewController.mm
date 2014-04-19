//
//  HighScoresViewController.m
//  MazeADay
//
//  Created by James Folk on 12/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "HighScoresViewController.h"
#import "AppDelegate.h"

@interface HighScoresViewController ()
{
    ViewController *viewController;
}
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HighScoresViewController
@synthesize dataArray;
@synthesize tableView;



//@interface HighScoresViewController ()
//
//@end
//
//@implementation HighScoresViewController

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






- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    dataArray = [[NSMutableArray alloc] init];
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *todaysDate = [formatter stringFromDate:[NSDate date]];
    
    NSString *labelValue = [[NSString alloc] initWithFormat:@"Best maze times for %@", todaysDate];
    [[self label] setText:labelValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addMazeTime:(unsigned int)level
              time:(long)time
{
    NSNumber *_level = [[NSNumber alloc] initWithUnsignedInt:level];
    NSNumber *_time = [[NSNumber alloc] initWithLong:time];
    
    NSArray *array = [[NSArray alloc] initWithObjects:_level, _time, nil];
    
    [self.dataArray addObject:array];
}

-(void)addVariables
{
    [dataArray removeAllObjects];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (int i = 1; i <= 45; i++)
    {
        [self addMazeTime:i time:[appDelegate getMazeEntry:[NSDate date] theLevel:i]];
    }

//    btAlignedObjectArray<DebugVariable*> objects;
//    DebugVariable *pDebugVariable = NULL;
//    
//    [dataArray removeAllObjects];
//    
//    DebugVariableFactory::getInstance()->get(objects);
//    for(int i = 0; i < objects.size(); i++)
//    {
//        pDebugVariable = objects.at(i);
//        
//        [self addVariableToTweak:pDebugVariable->getLabel() sld_value:pDebugVariable->getValue() sld_min_value:pDebugVariable->getMinValue() sld_max_value:pDebugVariable->getMaxValue() var_id:pDebugVariable->getID() stp_value:pDebugVariable->getStepperStepValue()];
//    }
    
    [tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addVariables];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =
    [[self tableView] dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    [appDelegate populateCell:cell cellForRowAtIndexPath:indexPath];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
