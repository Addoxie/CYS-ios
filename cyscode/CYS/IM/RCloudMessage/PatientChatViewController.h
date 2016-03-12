//
//  PatientChatViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/30.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import <RongIMKit/RCChatSessionInputBarControl.h>
#import <RongIMKit/RCThemeDefine.h>
#import <RongIMKit/RCThemeDefine.h>
#import <RongIMKit/RCMessageBaseCell.h>
#import <RongIMKit/RCMessageModel.h>


#import "GroupDetailViewController.h"

#import "THTinderNavigationController.h"
#import "RCDChatViewController.h"
#import "PatientProfileWEBViewController.h"






@interface PatientChatViewController :UITabBarController <UIPageViewControllerDataSource,UIPageViewControllerDelegate,navbardelegate,RCDChatViewControllerdelegate>
@property(nonatomic,retain)UIPageViewController *pageViewController;
@property(nonatomic,retain)RCConversationModel *model;
@property(nonatomic,assign)BOOL isgroup;
@property(nonatomic,assign)BOOL ismanager;
@property(nonatomic,retain)NSDictionary *datadic;
@property(nonatomic,retain)NSString *titlestr;
@property(nonatomic,retain)NSString *teamid;
@property(nonatomic,retain)NSString *patientd;
@property(nonatomic,retain)NSDictionary *teamdic;
-(id)initWithChatModel:(RCConversationModel *)model;
-(void)setupmorebutton;
@end

