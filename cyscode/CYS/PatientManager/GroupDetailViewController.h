//
//  GroupDetailViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ContactManagerViewController.h"
#import "ContactPatientViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "GroupRenameViewController.h"




@protocol GroupDetailViewControllerdelegate <NSObject>

-(void)deleteAndRelaodDic:(NSDictionary *)dic;

@end


@interface GroupDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UIAlertViewDelegate,ContactManagerViewControllerdelegate,ContactPatientViewControllerdelegate,RCIMReceiveMessageDelegate,GroupRenameViewControllerdelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *teamarr;
@property(nonatomic,retain)NSDictionary *datadic;
@property(nonatomic,assign)id <GroupDetailViewControllerdelegate> delegate;
@property(nonatomic,retain)NSMutableArray *teammemberarr;
@property(nonatomic,retain)NSDictionary *ownerdatadic;
@property(nonatomic,retain)NSMutableArray *patientarr;
@property(nonatomic,assign)BOOL ismanager;

@property(nonatomic,assign)BOOL iswoner;
@property(nonatomic,retain)NSMutableArray *imarr;
@property(nonatomic,retain)NSMutableArray *indexarr;
@property(nonatomic,retain)NSString *teamid;
@property(nonatomic,retain)NSDictionary *teamdic;
@property(nonatomic,assign)BOOL isnewteam;

@end
