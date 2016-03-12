//
//  HomeViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/14.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAPageControl.h"
#import "OutCallViewController.h"
#import "MobClick.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "NavBarView.h"
#import "DoctorHomePageWebViewController.h"

@interface HomeViewController : UIViewController<navbardelegate,UIScrollViewDelegate,TAPageControlDelegate,OutCallViewControllerdelegate,UIAlertViewDelegate>

@end
