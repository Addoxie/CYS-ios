//
//  ICSDrawerController.m
//
//  Created by Vito Modena
//
//  Copyright (c) 2014 ice cream studios s.r.l. - http://icecreamstudios.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ICSDrawerController.h"
#import "ICSDropShadowView.h"
#import "ZWIntroductionViewController.h"


static const CGFloat kICSDrawerControllerDrawerDepth = 280.0f;
static const CGFloat kICSDrawerControllerLeftViewInitialOffset = -60.0f;
static const NSTimeInterval kICSDrawerControllerAnimationDuration = 0.5;
static const CGFloat kICSDrawerControllerOpeningAnimationSpringDamping = 0.7f;
static const CGFloat kICSDrawerControllerOpeningAnimationSpringInitialVelocity = 0.1f;
static const CGFloat kICSDrawerControllerClosingAnimationSpringDamping = 1.0f;
static const CGFloat kICSDrawerControllerClosingAnimationSpringInitialVelocity = 0.5f;





@interface ICSDrawerController () <UIGestureRecognizerDelegate>

@property(nonatomic, strong, readwrite) UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *leftViewController;
@property(nonatomic, strong, readwrite) UINavigationController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *centerViewController;

@property(nonatomic, strong) UIView *leftView;
@property(nonatomic, strong) ICSDropShadowView *centerView;


@property(nonatomic, assign) CGPoint panGestureStartLocation;



@end



@implementation ICSDrawerController

- (id)initWithLeftViewController:(UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *)leftViewController
            centerViewController:(UINavigationController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *)centerViewController
{
    NSParameterAssert(leftViewController);
    NSParameterAssert(centerViewController);
    
    self = [super init];
    if (self) {
        _leftViewController = leftViewController;
        _centerViewController = centerViewController;
        
        if ([_leftViewController respondsToSelector:@selector(setDrawer:)]) {
            _leftViewController.drawer = self;
        }
        if ([_centerViewController respondsToSelector:@selector(setDrawer:)]) {
            _centerViewController.drawer = self;
        }
    }
    
    return self;
}

- (void)addCenterViewController
{
    NSParameterAssert(self.centerViewController);
    NSParameterAssert(self.centerView);
    
    [self addChildViewController:self.centerViewController];
    self.centerViewController.view.frame = self.view.bounds;
    [self.centerView addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];
}

#pragma mark - Managing the view

- (void)viewDidLoad
{
    [super viewDidLoad];
       
//
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changecentervc:) name:@"changecentervc" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newgain:) name:@"havenewgain" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newguangbo:) name:@"havenewguangbo" object:nil];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Initialize left and center view containers
    self.leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.centerView = [[ICSDropShadowView alloc] initWithFrame:self.view.bounds];    
    self.leftView.autoresizingMask = self.view.autoresizingMask;
    self.centerView.autoresizingMask = self.view.autoresizingMask;
//     if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
//      
//    }
    
    // Add the center view container
    [self.view addSubview:self.centerView];
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(opendrawernext:) name:@"newopendrawernext" object:nil];
    // Add the center view controller to the container
    [self addCenterViewController];

    [self setupGestureRecognizers];
    
   // [self newgetprojid];
    
    
    
    
    
}
-(void)newguangbo:(NSNotification *)sender{
    
//    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
//        NSLog(@"active");
//        //程序当前正处于前台
//        
//          dealmsgmodel=(UserModel *)sender.object;
//        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"有新消息，是否阅读？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"阅读", nil];
//        alertview.tag=1000002;
//        [alertview show];
//        
//    }else if([UIApplication sharedApplication].applicationState == UIApplicationStateInactive){
//        NSLog(@"inactive");
//        //程序处于后台
//        
//        
//        UserModel *msgmodel=(UserModel *)sender.object;
//        
//        msgmodel.msgtype=@"broadcast";
//        NSMutableDictionary *mydic=[[NSMutableDictionary alloc]initWithDictionary:[msgmodel.apscontent objectFromJSONString]];
//        if ([[mydic objectForKey:@"haveread"]isEqualToString:@"NO"]) {
//            [mydic setValue:@"YES" forKey:@"haveread"];
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mydic options:0 error:nil];
//            NSString * JSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            msgmodel.apscontent=JSONString;
//            
//            msgmodel.msgid=msgmodel.msgid;
//            
//            BOOL res=[[UserDB shareInstance]addUser:msgmodel];
//            if (res) {
//                NSLog(@"数据掺入成功");
//            }
//            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
//                [[PublicTools shareInstance]seticonbadge];
//            }else{
//                NSArray *tmparr=[[UserDB shareInstance]findUsers];
//                NSMutableArray *truearr=[[NSMutableArray alloc]init];
//                for (UserModel *model in tmparr) {
//                    
//                    if ([model.msgtype isEqualToString:@"broadcast"]) {
//                        NSDictionary *mydic=[model.apscontent objectFromJSONString];
//                        
//                        if ([[mydic objectForKey:@"haveread"]isEqualToString:@"NO"]) {
//                            [truearr addObject:model];
//                        }
//                    }else{
//                        [truearr addObject:model];
//                    }
//                    
//                }
//                
//                [UIApplication sharedApplication].applicationIconBadgeNumber= truearr.count;
//            }
//            MsgwebViewController *msgdetailvc=[[MsgwebViewController alloc]init];
//            msgdetailvc.urlstr=[mydic objectForKey:@"link"];
//            //  itemvc.delegate=self;
//            //    itemvc.sourcedatadic=dic;
//            msgdetailvc.isneeddismiss=YES;
//            PubilcNaviViewController *itemnav=[[PubilcNaviViewController alloc]initWithRootViewController:msgdetailvc];
//            [self presentViewController:itemnav animated:YES completion:nil];
//            
//        }
//
//        
//        
//        
//    }
//    

}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//}
-(void)newgetprojid{
//      if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
//          NSString *urlstring1=[NSString stringWithFormat:@"private/order/ordered-project/"];
//          [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring1 theReturnBlock:^(id respondataarr) {
//              
//              NSArray *mydataarr=(NSArray *)respondataarr;
//              //NSLog(@"%@",mydataarr);
//              
//              if ([[[mydataarr objectAtIndex:0] stringValue]isEqualToString:@"200"]) {
//                  
//                  NSArray *tmpdataarr=[mydataarr objectAtIndex:1];
//                  if (tmpdataarr.count!=0) {
//                      //  NSDictionary *dic=(NSDictionary *)[dataarr objectAtIndex:1];
//                      //   NSLog(@"%@",dic);
//                      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                      [defaults setObject:@"YES" forKey:@"haveproj"];
//                      [defaults synchronize];
//                  }else{
//                      
//                      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                      [defaults setObject:@"NO" forKey:@"haveproj"];
//                      [defaults synchronize];
//                  }
//              }else{
//                  //   NSDictionary *dic=(NSDictionary *)[mydataarr objectAtIndex:1];
//                  
//                  
//              }
//              //  NSDictionary *dic=(NSDictionary *)obj;
//              
//              
//          }];
//
//      }else{
//          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//          [defaults setObject:@"NO" forKey:@"haveproj"];
//          [defaults synchronize];
//
//      }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
//    if (msgarr.count!=0) {
//        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"更新提醒" message:@"种点儿有新版本更新有惊喜" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"马上更新", nil];
//        alertview.tag=100000000;
//        [alertview show];
//    
//    }

}
-(void)newgain:(NSNotification *)sender{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        NSLog(@"active");
//        
//        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"新的收成" message:@"有新的收成要查看吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
//        alertview.tag=100000001;
//        [alertview show];
        

        //程序当前正处于前台
    }
    else if([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
        NSLog(@"inactive");
       
   

        //程序处于后台
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

#pragma mark - Configuring the view’s layout behavior
-(void)changecentervc:(NSNotification *)notification{
    
}
-(void)opendrawernext:(NSNotification *)sender{
   

}
- (UIViewController *)childViewControllerForStatusBarHidden
{
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    if (self.drawerState == ICSDrawerControllerStateOpening) {
        return self.leftViewController;
    }
    return self.centerViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    if (self.drawerState == ICSDrawerControllerStateOpening) {
        return self.leftViewController;
    }
    return self.centerViewController;
}

#pragma mark - Gesture recognizers

- (void)setupGestureRecognizers
{
    NSParameterAssert(self.centerView);
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    self.panGestureRecognizer.delegate = self;   
    
    [self.centerView addGestureRecognizer:self.panGestureRecognizer];
}

- (void)addClosingGestureRecognizers
{
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.panGestureRecognizer);
    
    [self.centerView addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)removeClosingGestureRecognizers
{
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.panGestureRecognizer);

    [self.centerView removeGestureRecognizer:self.tapGestureRecognizer];
}

#pragma mark Tap to close the drawer
- (void)tapGestureRecognized:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self close];
    }
}

#pragma mark Pan to open/close the drawer
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSParameterAssert([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]);
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
    
    if (self.drawerState == ICSDrawerControllerStateClosed && velocity.x > 0.0f) {
        return YES;
    }
    else if (self.drawerState == ICSDrawerControllerStateOpen && velocity.x < 0.0f) {
        return YES;
    }
    
    return NO;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (self.needstopopen) {
        
    } else {
        NSParameterAssert(self.leftView);
        NSParameterAssert(self.centerView);
        
        UIGestureRecognizerState state = panGestureRecognizer.state;
        CGPoint location = [panGestureRecognizer locationInView:self.view];
        CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
        
        switch (state) {
                
            case UIGestureRecognizerStateBegan:
                //            NSLog(@"1111");
                //           // NSLog(@"%@", self.centerViewController.navigationController);
                //            NSLog(@"%@", self.centerViewController);
                //           // NSLog(@"%@", self.navigationController.viewControllers[0]);
                //            NSLog(@"%zd", self.centerViewController.viewControllers.count);
                
                
                
                if(self.centerViewController.viewControllers.count >1) {
                    NSLog(@"matched");
                    return;
                } else {
                    NSLog(@"unmatched");
                    
                }
                self.panGestureStartLocation = location;
                if (self.drawerState == ICSDrawerControllerStateClosed) {
                    [self willOpen];
                }
                else {
                    [self willClose];
                }
                break;
                
            case UIGestureRecognizerStateChanged:
            {
                //NSLog(@"123");
                CGFloat delta = 0.0f;
                if (self.drawerState == ICSDrawerControllerStateOpening) {
                    delta = location.x - self.panGestureStartLocation.x;
                }
                else if (self.drawerState == ICSDrawerControllerStateClosing) {
                    delta = kICSDrawerControllerDrawerDepth - (self.panGestureStartLocation.x - location.x);
                }
                
                CGRect l = self.leftView.frame;
                CGRect c = self.centerView.frame;
                if (delta > kICSDrawerControllerDrawerDepth) {
                    l.origin.x = 0.0f;
                    c.origin.x = kICSDrawerControllerDrawerDepth;
                }
                else if (delta < 0.0f) {
                    l.origin.x = kICSDrawerControllerLeftViewInitialOffset;
                    c.origin.x = 0.0f;
                }
                else {
                    // While the centerView can move up to kICSDrawerControllerDrawerDepth points, to achieve a parallax effect
                    // the leftView has move no more than kICSDrawerControllerLeftViewInitialOffset points
                    l.origin.x = kICSDrawerControllerLeftViewInitialOffset
                    - (delta * kICSDrawerControllerLeftViewInitialOffset) / kICSDrawerControllerDrawerDepth;
                    
                    c.origin.x = delta;
                }
                
                self.leftView.frame = l;
                self.centerView.frame = c;
                
                break;
            }
                
            case UIGestureRecognizerStateEnded:
                //  NSLog(@"123123");
                
                if (self.drawerState == ICSDrawerControllerStateOpening) {
                    CGFloat centerViewLocation = self.centerView.frame.origin.x;
                    if (centerViewLocation == kICSDrawerControllerDrawerDepth) {
                        // Open the drawer without animation, as it has already being dragged in its final position
                        [self setNeedsStatusBarAppearanceUpdate];
                        [self didOpen];
                    }
                    else if (centerViewLocation > self.view.bounds.size.width / 3
                             && velocity.x > 0.0f) {
                        // Animate the drawer opening
                        [self animateOpening];
                    }
                    else {
                        // Animate the drawer closing, as the opening gesture hasn't been completed or it has
                        // been reverted by the user
                        [self didOpen];
                        [self willClose];
                        [self animateClosing];
                    }
                    
                } else if (self.drawerState == ICSDrawerControllerStateClosing) {
                    CGFloat centerViewLocation = self.centerView.frame.origin.x;
                    if (centerViewLocation == 0.0f) {
                        // Close the drawer without animation, as it has already being dragged in its final position
                        [self setNeedsStatusBarAppearanceUpdate];
                        [self didClose];
                    }
                    else if (centerViewLocation < (2 * self.view.bounds.size.width) / 3
                             && velocity.x < 0.0f) {
                        // Animate the drawer closing
                        [self animateClosing];
                    }
                    else {
                        // Animate the drawer opening, as the opening gesture hasn't been completed or it has
                        // been reverted by the user
                        [self didClose];
                        
                        // Here we save the current position for the leftView since
                        // we want the opening animation to start from the current position
                        // and not the one that is set in 'willOpen'
                        CGRect l = self.leftView.frame;
                        [self willOpen];
                        self.leftView.frame = l;
                        
                        [self animateOpening];
                    }
                }
                break;
                
            default:
                break;
        }

    }
}

#pragma mark - Animations
#pragma mark Opening animation
- (void)animateOpening
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpening);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    
    // Calculate the final frames for the container views
    CGRect leftViewFinalFrame = self.view.bounds;
    CGRect centerViewFinalFrame = self.view.bounds;
    centerViewFinalFrame.origin.x = kICSDrawerControllerDrawerDepth;
    
    [UIView animateWithDuration:kICSDrawerControllerAnimationDuration
                          delay:0
         usingSpringWithDamping:kICSDrawerControllerOpeningAnimationSpringDamping
          initialSpringVelocity:kICSDrawerControllerOpeningAnimationSpringInitialVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerView.frame = centerViewFinalFrame;
                         self.leftView.frame = leftViewFinalFrame;
                         
                         [self setNeedsStatusBarAppearanceUpdate];
                     }
                     completion:^(BOOL finished) {
                         [self didOpen];
                     }];
}
#pragma mark Closing animation
- (void)animateClosing
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosing);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    
    // Calculate final frames for the container views
    CGRect leftViewFinalFrame = self.leftView.frame;
    leftViewFinalFrame.origin.x = kICSDrawerControllerLeftViewInitialOffset;
    CGRect centerViewFinalFrame = self.view.bounds;
    
    [UIView animateWithDuration:kICSDrawerControllerAnimationDuration
                          delay:0
         usingSpringWithDamping:kICSDrawerControllerClosingAnimationSpringDamping
          initialSpringVelocity:kICSDrawerControllerClosingAnimationSpringInitialVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerView.frame = centerViewFinalFrame;
                         self.leftView.frame = leftViewFinalFrame;
                         
                         [self setNeedsStatusBarAppearanceUpdate];
                     }
                     completion:^(BOOL finished) {
                         [self didClose];
                     }];
}

#pragma mark - Opening the drawer

- (void)open
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosed);

    [self willOpen];
    
    [self animateOpening];
}

- (void)willOpen
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosed);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Keep track that the drawer is opening
    self.drawerState = ICSDrawerControllerStateOpening;
    
    // Position the left view
    CGRect f = self.view.bounds;
    f.origin.x = kICSDrawerControllerLeftViewInitialOffset;
    NSParameterAssert(f.origin.x < 0.0f);
    self.leftView.frame = f;
    
    // Start adding the left view controller to the container
    [self addChildViewController:self.leftViewController];
    self.leftViewController.view.frame = self.leftView.bounds;
    [self.leftView addSubview:self.leftViewController.view];

    // Add the left view to the view hierarchy
    [self.view insertSubview:self.leftView belowSubview:self.centerView];
    
    // Notify the child view controllers that the drawer is about to open
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerWillOpen:)]) {
        [self.leftViewController drawerControllerWillOpen:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerWillOpen:)]) {
        [self.centerViewController drawerControllerWillOpen:self];
    }
}

- (void)didOpen
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpening);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Complete adding the left controller to the container
    [self.leftViewController didMoveToParentViewController:self];
    
    [self addClosingGestureRecognizers];
    
    // Keep track that the drawer is open
    self.drawerState = ICSDrawerControllerStateOpen;
    
    // Notify the child view controllers that the drawer is open
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerDidOpen:)]) {
        [self.leftViewController drawerControllerDidOpen:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerDidOpen:)]) {
        [self.centerViewController drawerControllerDidOpen:self];
    }
}

#pragma mark - Closing the drawer

- (void)close
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);

    [self willClose];

    [self animateClosing];
}

- (void)willClose
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Start removing the left controller from the container
    [self.leftViewController willMoveToParentViewController:nil];
    
    // Keep track that the drawer is closing
    self.drawerState = ICSDrawerControllerStateClosing;
    
    // Notify the child view controllers that the drawer is about to close
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerWillClose:)]) {
        [self.leftViewController drawerControllerWillClose:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerWillClose:)]) {
        [self.centerViewController drawerControllerWillClose:self];
    }
}

- (void)didClose
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosing);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.centerViewController);
    
    // Complete removing the left view controller from the container
    [self.leftViewController.view removeFromSuperview];
    [self.leftViewController removeFromParentViewController];
    
    // Remove the left view from the view hierarchy
    [self.leftView removeFromSuperview];
    
    [self removeClosingGestureRecognizers];
    
    // Keep track that the drawer is closed
    self.drawerState = ICSDrawerControllerStateClosed;
    
    // Notify the child view controllers that the drawer is closed
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerDidClose:)]) {
        [self.leftViewController drawerControllerDidClose:self];
    }
    if ([self.centerViewController respondsToSelector:@selector(drawerControllerDidClose:)]) {
        [self.centerViewController drawerControllerDidClose:self];
    }
}

#pragma mark - Reloading/Replacing the center view controller

- (void)reloadCenterViewControllerUsingBlock:(void (^)(void))reloadBlock
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);
    NSParameterAssert(self.centerViewController);
    
    [self willClose];
    
    CGRect f = self.centerView.frame;
    f.origin.x = self.view.bounds.size.width;
    
    [UIView animateWithDuration: kICSDrawerControllerAnimationDuration / 2
                     animations:^{
                         self.centerView.frame = f;
                     }
                     completion:^(BOOL finished) {
                         // The center view controller is now out of sight
                         if (reloadBlock) {
                             reloadBlock();
                         }
                         // Finally, close the drawer
                         [self animateClosing];
                     }];
}

- (void)replaceCenterViewControllerWithViewController:(UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *)viewController
{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);
    NSParameterAssert(viewController);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.centerViewController);
    
    [self willClose];
    
    CGRect f = self.centerView.frame;
    f.origin.x = self.view.bounds.size.width;
    
    [self.centerViewController willMoveToParentViewController:nil];
    [UIView animateWithDuration: kICSDrawerControllerAnimationDuration / 2
                     animations:^{
                         self.centerView.frame = f;
                     }
                     completion:^(BOOL finished) {
                         // The center view controller is now out of sight
                         
                         // Remove the current center view controller from the container
                         if ([self.centerViewController respondsToSelector:@selector(setDrawer:)]) {
                             self.centerViewController.drawer = nil;
                         }
                         [self.centerViewController.view removeFromSuperview];
                         [self.centerViewController removeFromParentViewController];
                         
                         // Set the new center view controller
                         self.centerViewController = viewController;
                         if ([self.centerViewController respondsToSelector:@selector(setDrawer:)]) {
                             self.centerViewController.drawer = self;
                         }
                         
                         // Add the new center view controller to the container
                         [self addCenterViewController];
                         
                         // Finally, close the drawer
                         [self animateClosing];
                     }];
}
- (void)replaceCenterViewControllerWithViewControllerWithoutanimation:(UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting> *)viewController{
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateOpen);
    NSParameterAssert(viewController);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.centerViewController);
    
    [self willClose];
    
    CGRect f = self.centerView.frame;
    f.origin.x = self.view.bounds.size.width;
    
    [self.centerViewController willMoveToParentViewController:nil];
    [UIView animateWithDuration: 0.0
                     animations:^{
                         self.centerView.frame = f;
                     }
                     completion:^(BOOL finished) {
                         // The center view controller is now out of sight
                         
                         // Remove the current center view controller from the container
                         if ([self.centerViewController respondsToSelector:@selector(setDrawer:)]) {
                             self.centerViewController.drawer = nil;
                         }
                         [self.centerViewController.view removeFromSuperview];
                         [self.centerViewController removeFromParentViewController];
                         
                         // Set the new center view controller
                         self.centerViewController = viewController;
                         if ([self.centerViewController respondsToSelector:@selector(setDrawer:)]) {
                             self.centerViewController.drawer = self;
                         }
                         
                         // Add the new center view controller to the container
                         [self addCenterViewController];
                         
                         // Finally, close the drawer
                         [self noanimateClosing];
                     }];

}
- (void)noanimateClosing
{
    //[self didClose];
    NSParameterAssert(self.drawerState == ICSDrawerControllerStateClosing);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    
    // Calculate final frames for the container views
    CGRect leftViewFinalFrame = self.leftView.frame;
    leftViewFinalFrame.origin.x = -10;
    CGRect centerViewFinalFrame = self.view.bounds;
    
    [UIView animateWithDuration:0.0
                          delay:0
         usingSpringWithDamping:0.1
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerView.frame = centerViewFinalFrame;
                         self.leftView.frame = leftViewFinalFrame;
                         
                         [self setNeedsStatusBarAppearanceUpdate];
                     }
                     completion:^(BOOL finished) {
                         [self didClose];
                     }];
}


@end
