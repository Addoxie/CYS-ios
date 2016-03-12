//
//  TESTIViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/31.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "TESTIViewController.h"

@implementation TESTIViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
//    
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    
//    [self.view addGestureRecognizer:swipeLeft];
//    
//    
//    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
//    
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    
//    [self.view addGestureRecognizer:swipeRight];
    
    
}

- (IBAction) tappedRightButton:(id)sender

{
    UISwipeGestureRecognizer *swipeRight=(UISwipeGestureRecognizer *)sender;
    //    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    //
    //
    //
    //    NSArray *aryViewController = self.tabBarController.viewControllers;
    //
    //    if (selectedIndex < aryViewController.count - 1) {
    //
    //        UIView *fromView = [self.tabBarController.selectedViewController view];
    //
    //        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
    //
    //        [UIView transitionFromView:fromView toView:toView duration:2.0f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
    //
    //            if (finished) {
    //
    //                [self.tabBarController setSelectedIndex:selectedIndex + 1];
    //
    //            }
    //
    //        }];
    //
    //    }
    NSUInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
    if (swipeRight.direction == UISwipeGestureRecognizerDirectionLeft) {
        [transaction setSubtype:kCATransitionFromRight];
        if (currentIndex + 1==self.tabBarController.childViewControllers.count - 1) {
            self.tabBarController.selectedIndex = self.tabBarController.childViewControllers.count - 1;
        }else{
             self.tabBarController.selectedIndex = currentIndex + 1;
        }
       
    } else {
        [transaction setSubtype:kCATransitionFromLeft];
        self.tabBarController.selectedIndex = MIN(0, currentIndex - 1);
    }
     [[NSNotificationCenter defaultCenter]postNotificationName:@"changeselectindex" object:nil];
    if (currentIndex == self.tabBarController.selectedIndex) {
        return;
    }
    transaction.duration = 0.25;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
    
    
    
}



- (IBAction) tappedLeftButton:(id)sender
{
    
    
    
    
    UISwipeGestureRecognizer *swipeRight=(UISwipeGestureRecognizer *)sender;
    //    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    //
    //
    //
    //    NSArray *aryViewController = self.tabBarController.viewControllers;
    //
    //    if (selectedIndex < aryViewController.count - 1) {
    //
    //        UIView *fromView = [self.tabBarController.selectedViewController view];
    //
    //        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
    //
    //        [UIView transitionFromView:fromView toView:toView duration:2.0f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
    //
    //            if (finished) {
    //
    //                [self.tabBarController setSelectedIndex:selectedIndex + 1];
    //
    //            }
    //
    //        }];
    //
    //    }
    NSUInteger currentIndex = self.tabBarController.selectedIndex;
    
    CATransition *transaction = [CATransition animation];
    transaction.type = kCATransitionPush;
    if (swipeRight.direction == UISwipeGestureRecognizerDirectionLeft) {
        [transaction setSubtype:kCATransitionFromRight];
        
        self.tabBarController.selectedIndex = MAX(self.tabBarController.childViewControllers.count - 1, currentIndex + 1);
    } else {
        [transaction setSubtype:kCATransitionFromLeft];
        if (currentIndex - 1==0) {
            self.tabBarController.selectedIndex = 0;
            
        }else{
            self.tabBarController.selectedIndex = currentIndex - 1;
            
            
        }
         [[NSNotificationCenter defaultCenter]postNotificationName:@"changeselectindex" object:nil];
    }
    
    if (currentIndex == self.tabBarController.selectedIndex) {
        return;
    }
    transaction.duration = 0.25;
    transaction.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [[self.tabBarController.view layer] addAnimation:transaction forKey:@"switchView"];
    
    //{
    //
    //    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    //
    //
    //
    //    if (selectedIndex > 0) {
    //
    //        UIView *fromView = [self.tabBarController.selectedViewController view];
    //
    //        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1] view];
    //
    //        [UIView transitionFromView:fromView toView:toView duration:2.0f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
    //
    //            if (finished) {
    //
    //                [self.tabBarController setSelectedIndex:selectedIndex - 1];
    //                
    //            }
    //            
    //        }];
    //        
    //    }
    //    
    
}


@end
