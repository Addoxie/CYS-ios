//
//  MainTabBarController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/14.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "FirstinfoViewController.h"
#import "ViewController.h"
#import "TOOLViewController.h"
#import "PatientManagerViewController.h"
#import "EditnameViewController.h"
#import "THTinderNavigationController.h"

#import "LXDSegmentControl.h"

#import "WMPageController.h"
#import "PubilcViewController.h"




#import "CallListViewController.h"
#import "OrderIMListViewController.h"
#import "OrderIMPaidListViewController.h"

#import "OrderIMDoneListViewController.h"
#import "OrderIMCancleListViewController.h"

#import "FaceOrderViewController.h"


#import "WMPageController.h"

#import "OutCallViewController.h"





@interface MainTabBarController : UITabBarController<EditnameViewControllerdelegate,THTinderNavigationControllerdelegate,LXDSegmentControlDelegate,WMPageControllerdelegate,UIAlertViewDelegate,OutCallViewControllerdelegate>

@property(nonatomic,retain)NSString *msgcount;
@property(nonatomic,retain)NSString *ordermsgcount;
@end
