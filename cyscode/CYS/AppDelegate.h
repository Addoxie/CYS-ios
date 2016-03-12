/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

#import "WXApi.h"

#import "UMSocialSnsService.h"
#import "UMSocialData.h"

#import "MsgModel.h"
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate, RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate,RCIMGroupUserInfoDataSource,RCIMUserInfoDataSource,RCIMGroupInfoDataSource>
{
    NSInteger i;
    NSMutableArray *msgarr;
    MsgModel *testmodel;
    MainTabBarController *mainv;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)NSMutableArray *msgarr;
@property (nonatomic,retain)NSString *msgcount;
@end
