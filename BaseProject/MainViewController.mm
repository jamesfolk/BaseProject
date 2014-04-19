//
//  MainViewController.m
//  BaseProject
//
//  Created by library on 11/8/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#include "GameStateFactory.h"

#include "FacebookSingleton.h"
#import "AppDelegate.h"

#import "HighScoresViewController.h"

static MainViewController *mainViewController = nil;

@interface MainViewController ()

@property (strong, nonatomic) EAGLContext *context;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)handledURL: (NSNotification *)deepLinkNotification
{
    NSURL *targetURL = deepLinkNotification.object;
    FacebookSingleton::getInstance()->processIncomingURL(targetURL);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    mainViewController = self;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handledURL:) name:APP_HANDLED_URL object:nil];
    
    [self.activity setHidden:YES];
    //[self.playButton setHidden:YES];
    [self.request setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)play
{
//    HighScoresViewController *pHighScoresViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HighScoresViewController"];
//    
//    
//    [self.navigationController pushViewController:pHighScoresViewController animated:YES];
    
    ViewController *pViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    if(pViewController != nil)
    {
        [pViewController setGameStateEnum:GameStateType_MazeGameState];
        [pViewController enableDebugDraw:NO];
        [pViewController setDebugViewController:nil];
        [pViewController setMainViewController:self];
        
    }
    
    [self.navigationController pushViewController:pViewController animated:YES];
}
- (IBAction)playTouchUpInside:(id)sender
{
    [self play];
}

- (IBAction)requestTouchUpInside:(id)sender
{
    FacebookSingleton::getInstance()->sendRequest("the message", "the data");
}

-(void)loggedin
{
    [self.playButton setHidden:NO];
    [self.request setHidden:NO];
    [self.activity setHidden:YES];
    [self.activity stopAnimating];
    
    NSString *prompt = [[NSString alloc] initWithFormat:@"Welcome %s %s %s!", FacebookSingleton::getInstance()->getFirstName().c_str(), FacebookSingleton::getInstance()->getMiddleName().c_str(), FacebookSingleton::getInstance()->getLastName().c_str()];
    [_lblUser setText:prompt];
    
    [self.fbLoginButton setTitle:@"FB Logout" forState:UIControlStateNormal];
    
    [self.fbLoginButton setEnabled:YES];
}

-(void)loggedout
{
    [self.playButton setHidden:YES];
    [self.request setHidden:YES];
    [_lblUser setText:@""];
    
    [self.fbLoginButton setTitle:@"FB Login" forState:UIControlStateNormal];
}

struct loadReaction
{
    void operator()()
    {
        [mainViewController loggedin];
    }
};

struct loadFriendReaction
{
    void operator()()
    {
        for(int i = 0; i < FacebookSingleton::getInstance()->getNumberOfFriends(); i++)
        {
            NSLog(@"Friend: %s", FacebookSingleton::getInstance()->getFriendName(i).c_str());
        }
    }
};

struct loginReaction
{
    void operator()() 
    {
        loadReaction reaction;
        loadFriendReaction reaction2;
        
        FacebookSingleton::getInstance()->loadUserData<loadReaction>(reaction);
        FacebookSingleton::getInstance()->loadFriends(reaction2);
    }
};

- (IBAction)fbLoginTouchUpInside:(id)sender
{
    if(FacebookSingleton::getInstance()->isLoggedIn())
    {
        FacebookSingleton::getInstance()->logout();
        [self loggedout];
    }
    else
    {
        [self.fbLoginButton setEnabled:NO];
        [self.activity setHidden:NO];
        [self.activity startAnimating];
        
        FacebookSingleton::getInstance()->createNewSession();
        
        loginReaction react;
        FacebookSingleton::getInstance()->login<loginReaction>(react);
        
        FBRequestHandler requestHandler = ^(FBRequestConnection *connection, id result, NSError *error)
        {
            if (!error)
            {
                if ([result objectForKey:@"from"])
                {
                    NSString *from = [[result objectForKey:@"from"] objectForKey:@"name"];
                    NSString *id = [[result objectForKey:@"from"] objectForKey:@"id"];
                    NSString *data = [result objectForKey:@"data"];
                    NSLog(@"%@ %@ %@\n", id, from, data);
                    [self play];
                }
            }
            else
            {
                NSLog(@"ERROR %s, %d, %s, %@\n", __FILE__,__LINE__,__FUNCTION__, error.description);
            }
        };
        
        FacebookSingleton::getInstance()->setRequestHandler(requestHandler);
    }
    
    
}



//- (void)update
//{
//    
//    GLKView *view = (GLKView *)self.view;
//    
//    CameraFactory::updateScreenDimensions(view.drawableWidth, view.drawableHeight);
//    
//    double timeSinceLastUpdate = self.timeSinceLastUpdate;
//    
//    
//}
//
//- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
//{
//    glClearColor(1, 1, 1, 1.0);
//    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
//}

@end
