//
//  RongCloud
//
//  Created by Liv on 14/10/31.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import "EditnameViewController.h"


@interface RCDChatListViewController : RCConversationListViewController<EditnameViewControllerdelegate>

//弹出菜单
- (IBAction)showMenu:(UIButton *)sender;

@property(nonatomic,assign)BOOL isgroup;

@property(nonatomic,assign)BOOL isneedmorebtn;

@property(nonatomic,retain)NSMutableArray *teamarr;
@property(nonatomic,retain)NSMutableArray *participatedTeamarr;
@property(nonatomic,retain)NSMutableArray *invitationarr;

@property(nonatomic,retain)NSString *extra;
@property(nonatomic,retain)NSMutableArray *grouparr;

//@property(nonatomic,retain)RCConversationModel *model;
@end

