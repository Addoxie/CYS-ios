//
//  TeamListViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/20.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import "THTinderNavigationController.h"

@interface TeamListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,navbardelegate,RCIMReceiveMessageDelegate,RCIMGroupUserInfoDataSource,RCIMUserInfoDataSource,RCIMGroupInfoDataSource,THTinderNavigationControllerdelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *grouparr1;
@property (nonatomic, retain) NSMutableArray *grouparr2;
@end
