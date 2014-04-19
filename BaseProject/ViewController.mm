//
//  ViewController.m
//  BaseProject
//
//  Created by library on 8/21/13.
//  Copyright (c) 2013 JFArmy. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DebugViewController.h"

#import <CoreMotion/CoreMotion.h>

#include "FrameCounter.h"

#include "CameraFactory.h"

#include "GameStateMachine.h"
#include "PhysicsEntityTestState.h"
#include "FontTestState.h"
#include "ViewEntityTestState.h"

#include "SpriteTestState.h"

#include "MazeGameState.h"
#include "PathTestState.h"

#include "LuaVM.h"

#include "ZipFileResourceLoader.h"
#include "LoadGameState.h"
#include "TextureFactory.h"
#include "TextViewObjectFactory.h"
#include "LocalizedTextLoader.h"


#include "GLDebugDrawer.h"
//#include "CollisionFilterBehaviorFactory.h"
//#include "UpdateBehaviorFactory.h"
#include "CollisionResponseBehaviorFactory.h"
#include "TextureBehaviorFactory.h"
#include "ParticleEmitterBehaviorFactory.h"
#include "EntityFactory.h"
#include "ViewObjectFactory.h"
#include "TextViewObjectFactory.h"
#include "ShaderFactory.h"
#include "CollisionShapeFactory.h"
#include "AnimationControllerFactory.h"
#include "SteeringBehaviorFactory.h"
#include "EntityStateMachineFactory.h"
#include "DebugGameState.h"
#include "GameStateFactory.h"
#include "HeadingSmoother.h"
#include "UserSettingsSingleton.h"
#include "TextureBufferObjectFactory.h"
#include "FacebookSingleton.h"
#include "DeviceInput.h"
#include "VertexBufferObject.h"

#define check_gl_error() _check_gl_error(__FILE__,__LINE__,__FUNCTION__);


//#define pause_normal @"pause1.tga"
//#define pause_highlight @"pause2.tga"
//
//#define play_normal @"play1.tga"
//#define play_highlight @"play2.tga"
//
//#define quit_normal @"quit1.tga"
//#define quit_highlight @"quit2.tga"


#define pause_normal @"PauseButton2_Unpressed.png"
#define pause_highlight @"PauseButton2_Pressed.png"

#define play_normal @"PlayButton2_Unpressed.png"
#define play_highlight @"PlayButton2_Pressed.png"

#define quit_normal @"QuitButton2_Unpressed.png"
#define quit_highlight @"QuitButton2_Pressed.png"

@interface ViewController ()
{
    BOOL m_debugDraw;
    GameStateType_e m_gametype;
    
    UIButton *pauseButton;
    UIButton *quitButton;
    
    UIButton *nextLevel;
    UIButton *previousLevel;
    
    UIButton *resetLevel;
    
    IDType loadGameStateID;
    IDType mazeGameStateID;
    IDType debugGameStateID;
    DebugGameState *pDebugGameState;
    LoadGameState *pLoadGameState;
    
    IDType shaderFactoryID;
    
}

@property (strong, nonatomic) EAGLContext *context;

@end

@implementation ViewController


-(void) createFactories
{
    int s = sizeof(btTransform);
    int ss = sizeof(btScalar);
    int sss = sizeof(btVector3);
    
    for(int i = LocalizedTextViewObjectType_NONE + 1; i < LocalizedTextViewObjectType_MAX; i++)
    {
        LocalizedTextLoader::getInstance()->load((LocalizedTextViewObjectType) i);
    }
    
    BaseGameStateInfo *bgsi = NULL;
    
    bgsi = new BaseGameStateInfo();
    
    bgsi->gametype = GameStateType_LoadGameState;
    loadGameStateID = GameStateFactory::getInstance()->create(bgsi);
    
    bgsi->gametype = m_gametype;
    mazeGameStateID = GameStateFactory::getInstance()->create(bgsi);
    
    bgsi->gametype = GameStateType_DebugGameState;
    debugGameStateID = GameStateFactory::getInstance()->create(bgsi);
    
    pLoadGameState = dynamic_cast<LoadGameState*>(GameStateFactory::getInstance()->get(loadGameStateID));
    pDebugGameState = dynamic_cast<DebugGameState*>(GameStateFactory::getInstance()->get(debugGameStateID));
    
    delete bgsi;
    bgsi = NULL;
}


-(void) destroyFactories
{
    GameStateFactory::getInstance()->destroy(debugGameStateID);
    GameStateFactory::getInstance()->destroy(loadGameStateID);
    GameStateFactory::getInstance()->destroy(mazeGameStateID);
    
    LocalizedTextLoader::getInstance()->unLoadAll();
}



- (void)togglePause
{
    if(GameStateMachine::getInstance()->isPauseAllowed())
    {
        if(GameStateMachine::getInstance()->isPaused())
        {
            [pauseButton setImage:[UIImage imageNamed:pause_normal] forState:UIControlStateNormal];
            [pauseButton setImage:[UIImage imageNamed:pause_highlight] forState:UIControlStateHighlighted];
            
            GameStateMachine::getInstance()->enablePause(false);
        }
        else
        {
            [pauseButton setImage:[UIImage imageNamed:play_normal] forState:UIControlStateNormal];
            [pauseButton setImage:[UIImage imageNamed:play_highlight] forState:UIControlStateHighlighted];
            
            GameStateMachine::getInstance()->enablePause();
        }
    }
}

-(void)nextLevel
{
    GameStateMachine::getInstance()->pushCurrentState(MazeGameState::getGameState(GameStateType_MazeGameState_NextLevel));
}
-(void)previousLevel
{
    GameStateMachine::getInstance()->pushCurrentState(MazeGameState::getGameState(GameStateType_MazeGameState_PreviousLevel));
}

-(void)resetLevel
{
    GameStateMachine::getInstance()->pushCurrentState(MazeGameState::getGameState(GameStateType_MazeGameState_ReadySetGo));
}

- (void)quitAction
{
    [[self getGlobalGameJamViewController].navigationController popViewControllerAnimated:NO];
//    DebugViewController *pDebugViewController = [self getDebugViewController];
//    
//    if(pDebugViewController != nil)
//    {
//        GameStateMachine::getInstance()->quit();
//        [pDebugViewController.navigationController popViewControllerAnimated:NO];
//        return;
//    }
//    
//    MainViewController *pMainViewController = [self getMainViewController];
//    //if(pDebugViewController != nil)
//    {
//        GameStateMachine::getInstance()->quit();
//        [pMainViewController.navigationController popViewControllerAnimated:NO];
//        return;
//    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.motionManager stopAccelerometerUpdates];
    [self.motionManager stopDeviceMotionUpdates];
    [self.motionManager stopGyroUpdates];
    [self.motionManager stopMagnetometerUpdates];
    
}

-(void)createPauseButton
{
    GLKView *view = (GLKView *)self.view;
    CGRect bounds = view.bounds;
    CGFloat width = bounds.size.height;
    CGFloat height = bounds.size.width;
    
    pauseButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [pauseButton setImage:[UIImage imageNamed:pause_normal] forState:UIControlStateNormal];
    [pauseButton setImage:[UIImage imageNamed:pause_highlight] forState:UIControlStateHighlighted];
    [pauseButton setFrame:CGRectMake((width) - 32, (height) - 32, 32, 32)];
    [pauseButton addTarget:self action:@selector(togglePause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
}



-(void)createQuitButton
{
    GLKView *view = (GLKView *)self.view;
    CGRect bounds = view.bounds;
    CGFloat width = bounds.size.height;
    CGFloat height = bounds.size.width;
    
    quitButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [quitButton setImage:[UIImage imageNamed:quit_normal] forState:UIControlStateNormal];
    [quitButton setImage:[UIImage imageNamed:quit_highlight] forState:UIControlStateHighlighted];
    [quitButton setFrame:CGRectMake(0, (height) - 32, 32, 32)];
    [quitButton addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitButton];
}

-(void)updatePreviousLevelButton
{
    BaseGameState *s = MazeGameState::getGameState(GameStateType_MazeGameState_Play);
    BaseGameState *s2 = MazeGameState::getGameState(GameStateType_MazeGameState_ReadySetGo);
    bool instate = false;
    
    if(s != NULL && s2 != NULL)
    {
        instate = GameStateMachine::getInstance()->isInState(*s) ||
        GameStateMachine::getInstance()->isInState(*s2);
    }
    
    if(instate)
    {
        int level = MazeGameState::getCurrentLevel() - 1;
        BOOL completed = MazeGameState::completedLevel(level);
        [previousLevel setEnabled:completed];
    }
    else
    {
        [previousLevel setEnabled:NO];
    }
}

#include "GameStateFactory.h"
-(void)updateNextLevelButton
{
    BaseGameState *s = MazeGameState::getGameState(GameStateType_MazeGameState_Play);
    BaseGameState *s2 = MazeGameState::getGameState(GameStateType_MazeGameState_ReadySetGo);
    bool instate = false;
    
    if(s != NULL && s2 != NULL)
    {
        instate = GameStateMachine::getInstance()->isInState(*s) ||
        GameStateMachine::getInstance()->isInState(*s2);
    }
    
    if(instate)
    {
        int level = MazeGameState::getCurrentLevel();
        BOOL completed = MazeGameState::completedLevel(level);
        [nextLevel setEnabled:completed];
    }
    else
    {
        [nextLevel setEnabled:NO];
    }
}

-(void)createNextLevelButton
{
    GLKView *view = (GLKView *)self.view;
    CGRect bounds = view.bounds;
    CGFloat width = bounds.size.height;
    CGFloat height = bounds.size.width;
    
    nextLevel = [UIButton buttonWithType: UIButtonTypeCustom];
    [nextLevel setImage:[UIImage imageNamed:@"next1.tga"] forState:UIControlStateNormal];
    [nextLevel setImage:[UIImage imageNamed:@"next2.tga"] forState:UIControlStateHighlighted];
    [nextLevel setImage:[UIImage imageNamed:@"next3.tga"] forState:UIControlStateDisabled];
    [nextLevel setFrame:CGRectMake((width / 2) - (32 - 16), (height) - 32, 32, 32)];
    [nextLevel addTarget:self action:@selector(nextLevel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextLevel];
    
    
    [self updateNextLevelButton];
}
-(void)createPreviousLevelButton
{
    GLKView *view = (GLKView *)self.view;
    CGRect bounds = view.bounds;
    CGFloat width = bounds.size.height;
    CGFloat height = bounds.size.width;
    
    previousLevel = [UIButton buttonWithType: UIButtonTypeCustom];
    [previousLevel setImage:[UIImage imageNamed:@"prev1.tga"] forState:UIControlStateNormal];
    [previousLevel setImage:[UIImage imageNamed:@"prev2.tga"] forState:UIControlStateHighlighted];
    [previousLevel setImage:[UIImage imageNamed:@"prev3.tga"] forState:UIControlStateDisabled];
    [previousLevel setFrame:CGRectMake((width / 2) - (32 + 16), (height) - 32, 32, 32)];
    [previousLevel addTarget:self action:@selector(previousLevel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousLevel];
    
    [self updatePreviousLevelButton];
}

-(void)createResetButton
{
    //
    GLKView *view = (GLKView *)self.view;
    CGRect bounds = view.bounds;
    CGFloat width = bounds.size.height;
    CGFloat height = bounds.size.width;
    
    resetLevel = [UIButton buttonWithType: UIButtonTypeCustom];
    [resetLevel setImage:[UIImage imageNamed:@"reset1.tga"] forState:UIControlStateNormal];
    [resetLevel setImage:[UIImage imageNamed:@"reset2.tga"] forState:UIControlStateHighlighted];
    [resetLevel setImage:[UIImage imageNamed:@"reset3.tga"] forState:UIControlStateDisabled];
    [resetLevel setFrame:CGRectMake((width) - 32, (height / 2) - 16, 32, 32)];
    [resetLevel addTarget:self action:@selector(resetLevel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetLevel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GLKView *view = (GLKView *)self.view;
    
    [self createPauseButton];
    [self createQuitButton];
    //[self createNextLevelButton];
    //[self createPreviousLevelButton];
    //[self createResetButton];
    
    
    

    
    
    

    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    
    //TextureFactory::getInstance()->setShareGroup([self.context sharegroup]);
    
    if (!self.context)
    {
        NSLog(@"%@", @"Failed to create ES context");
    }
    
    view.context = self.context;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGB565;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    self.preferredFramesPerSecond = 60;
    
    view.contentScaleFactor = [UIScreen mainScreen].scale;
    
    [EAGLContext setCurrentContext:self.context];
    
    [self.view setMultipleTouchEnabled:YES];
    
    
    
    
    FrameCounter::getInstance()->setPreferredFramesPerSecond([self preferredFramesPerSecond]);
    
    ShaderFactoryKey key0("PixelLighting.vsh", "PixelLighting.fsh");
    shaderFactoryID = ShaderFactory::getInstance()->create(&key0);
    
    ShaderFactoryKey key(VERTEX_SHADER, FRAGMENT_SHADER);
    shaderFactoryID = ShaderFactory::getInstance()->create(&key);
    
    UserSettingsSingleton::getInstance()->registerDefaults("UserDefaults.plist");
    
    //LuaVM::getInstance()->loadFile("printf.lua");
    //LuaVM::getInstance()->loadFile("factorial.lua");
    //LuaVM::getInstance()->loadFile("inspect.lua");
    LuaVM::getInstance()->loadFile("btVector3Example.lua");
    //LuaVM::getInstance()->loadFile("main.lua");
    LuaVM::getInstance()->loadFile("displacement.lua");
    //LuaVM::getInstance()->loadFile("ggj.lua");
    
    [self createFactories];
    
    
    pLoadGameState->setZipFile("ggj.zip");

    //pLoadGameState->setZipFile("maze.zip");
    //m_debugDraw = YES;
    
    if(m_debugDraw)
    {
        pDebugGameState->setGameState(mazeGameStateID);
        
        pLoadGameState->setOnFinishedState(debugGameStateID);
    }
    else
    {
        pLoadGameState->setOnFinishedState(mazeGameStateID);
    }
    
    GameStateMachine::getInstance()->pushGlobalState(pLoadGameState);
    //GameStateMachine::getInstance()->pushCurrentState(pLoadGameState);
    
    
    [self setupDeviceInput];
    
    
    
    
}

- (void)dealloc
{
    ShaderFactory::getInstance()->destroy(shaderFactoryID);
    
    GameStateMachine::getInstance()->pushCurrentState(NULL);
    GameStateMachine::getInstance()->pushGlobalState(NULL);
    GameStateMachine::getInstance()->update(0);
    
    ZipFileResourceLoader::getInstance()->destroy();
    
    [self destroyFactories];
    MazeGameState::destroyGameStates();
    
    
    [EAGLContext setCurrentContext:self.context];
    if ([EAGLContext currentContext] == self.context)
    {
        [EAGLContext setCurrentContext:nil];
    }
    
    pauseButton = nil;
    quitButton = nil;
    nextLevel = nil;
    previousLevel = nil;
    resetLevel = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil))
    {
        self.view = nil;
        
        [EAGLContext setCurrentContext:self.context];
        
        GameStateMachine::getInstance()->pushGlobalState(NULL);
        GameStateMachine::getInstance()->pushCurrentState(NULL);
        GameStateMachine::getInstance()->update(0);
        
        ZipFileResourceLoader::getInstance()->destroy();
        
        [self destroyFactories];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    GLKView *view = (GLKView *)self.view;
    CameraFactory::updateScreenDimensions(view.drawableWidth, view.drawableHeight);
}

- (void)update
{
//    [sharedSoundManager update];
    
    [self updateNextLevelButton];
    [self updatePreviousLevelButton];
    
//    [sharedSoundManager update];
    
    
    
    
    
    double timeSinceLastUpdate = self.timeSinceLastUpdate;
    
    if(GameStateMachine::getInstance()->isPaused())
        timeSinceLastUpdate = 0;
    
    FrameCounter::getInstance()->update(timeSinceLastUpdate);
    
    WorldPhysics::getInstance()->update();
    
    GameStateMachine::getInstance()->update(timeSinceLastUpdate);
    
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);check_gl_error()
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);check_gl_error()
    
//    glEnable(GL_DEPTH_TEST);check_gl_error()
//    
//    glEnable (GL_BLEND);check_gl_error()
//    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);check_gl_error()
    
    //glEnable(GL_CULL_FACE);
    
//    glUseProgram(ShaderFactory::getInstance()->getCurrentShaderID());
    
    WorldPhysics::getInstance()->render();
    
    EntityFactory::getInstance()->render();
    
    TextViewObjectFactory::getInstance()->render();
    
    ParticleEmitterBehaviorFactory::getInstance()->render();
    
    GameStateMachine::getInstance()->render();    
    
//    glUseProgram(0);
    
    TextureBufferObjectFactory::getInstance()->render();
    
    [view bindDrawable];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    int i = 0;
    for(UITouch *touch in touches)
    {
        GameStateMachine::getInstance()->touchRespond(DeviceTouch(touch,
                                                                  i++,
                                                                  [touches count]));
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    int i = 0;
    
    for(UITouch *touch in touches)
    {
        GameStateMachine::getInstance()->touchRespond(DeviceTouch(touch,
                                                                  i++,
                                                                  [touches count]));
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    int i = 0;
    
    for(UITouch *touch in touches)
    {
        GameStateMachine::getInstance()->touchRespond(DeviceTouch(touch,
                                                                  i++,
                                                                  [touches count]));
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    int i = 0;
    
    for(UITouch *touch in touches)
    {
        GameStateMachine::getInstance()->touchRespond(DeviceTouch(touch,
                                                                  i++,
                                                                  [touches count]));
    }
}

-(void)handleTapGesture:(UITapGestureRecognizer*)sender
{
    GameStateMachine::getInstance()->tapGestureRespond(DeviceTapGesture(sender));
}

-(void)handlePinchGesture:(UIPinchGestureRecognizer*)sender
{
    GameStateMachine::getInstance()->pinchGestureRespond(DevicePinchGesture(sender));
}

-(void)handlePanGesture:(UIPanGestureRecognizer*)sender
{
    GameStateMachine::getInstance()->panGestureRespond(DevicePanGesture(sender));
}

-(void)handleSwipeGesture:(UISwipeGestureRecognizer*)sender
{
    GameStateMachine::getInstance()->swipeGestureRespond(DeviceSwipeGesture(sender));
}

-(void)handleRotationGesture:(UIRotationGestureRecognizer*)sender
{
    GameStateMachine::getInstance()->rotationGestureRespond(DeviceRotationGesture(sender));
}

-(void)handleLongPressGesture:(UILongPressGestureRecognizer*)sender
{
    GameStateMachine::getInstance()->longPressGestureRespond(DeviceLongPressGesture(sender));
}

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)])
    {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}


- (void)setupDeviceInput
{
    GLKView *view = (GLKView *)self.view;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.cancelsTouchesInView = NO;
//    tapGesture.delaysTouchesBegan = YES;
//    tapGesture.delaysTouchesEnded = YES;
    [view addGestureRecognizer:tapGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinchGesture.cancelsTouchesInView = NO;
//    pinchGesture.delaysTouchesBegan = YES;
//    pinchGesture.delaysTouchesEnded = YES;
    [view addGestureRecognizer:pinchGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.cancelsTouchesInView = NO;
//    panGesture.delaysTouchesBegan = YES;
//    panGesture.delaysTouchesEnded = YES;
    [view addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGesture.cancelsTouchesInView = NO;
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [swipeGesture setNumberOfTouchesRequired:1];
//    swipeGesture.delaysTouchesBegan = YES;
//    swipeGesture.delaysTouchesEnded = YES;
    [view addGestureRecognizer:swipeGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    rotationGesture.cancelsTouchesInView = NO;
//    rotationGesture.delaysTouchesBegan = YES;
//    rotationGesture.delaysTouchesEnded = YES;
    [view addGestureRecognizer:rotationGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    longPressGesture.cancelsTouchesInView = NO;
//    longPressGesture.delaysTouchesBegan = YES;
//    longPressGesture.delaysTouchesEnded = YES;
    [view addGestureRecognizer:longPressGesture];
    
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                             withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            GameStateMachine::getInstance()->accelerometerRespond(DeviceAccelerometer(data));
                        });
     }
     ];
    
    [self.motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                            withHandler:^(CMDeviceMotion *data, NSError *error)
     {
//         GameStateMachine::getInstance()->motionRespond(DeviceMotion(data));
//         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
//                        ^{
//                            GameStateMachine::getInstance()->motionRespond(DeviceMotion(data));
//                        });
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            GameStateMachine::getInstance()->motionRespond(DeviceMotion(data));
                        });
     }
     ];
    
    [self.motionManager startGyroUpdatesToQueue:[[NSOperationQueue alloc] init]
                                    withHandler:^(CMGyroData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            GameStateMachine::getInstance()->gyroRespond(DeviceGyro(data));
                        });
     }
     ];
    
    [self.motionManager startMagnetometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                            withHandler:^(CMMagnetometerData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            GameStateMachine::getInstance()->magnetometerRespond(DeviceMagnetometer(data));
                        });
     }
     ];
}

//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
//}

-(EAGLContext*)getContext
{
    return self.context;
}
-(void)setDebugViewController:(DebugViewController*)controller
{
    debugViewController = controller;
}
-(DebugViewController*)getDebugViewController
{
    return debugViewController;
}

-(void)setMainViewController:(MainViewController*)controller
{
    mainViewController = controller;
}

-(MainViewController*)getMainViewController
{
    return mainViewController;
}

-(void)setGlobalGameJamViewController:(GlobalGameJamViewController*)controller
{
    globalGameJamViewController = controller;
}

-(GlobalGameJamViewController*)getGlobalGameJamViewController
{
    return globalGameJamViewController;
}

-(void)enableDebugDraw:(BOOL)enable
{
    m_debugDraw = enable;
}
-(void)setGameStateEnum:(int)val
{
    m_gametype = (GameStateType_e)val;
}

@end
