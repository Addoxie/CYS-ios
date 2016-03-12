//
//  ConnectDetailViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/12.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import <RongIMKit/RCChatSessionInputBarControl.h>
#import <RongIMKit/RCThemeDefine.h>
#import <RongIMKit/RCThemeDefine.h>
#import <RongIMKit/RCMessageBaseCell.h>
#import <RongIMKit/RCMessageModel.h>



@protocol ConnectDetailViewControllerdelegate <NSObject>

-(void)ConnectDetailMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type;

@end

@interface ConnectDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign)BOOL isphone;
@property(nonatomic,retain)NSDictionary *patientdatadic;
@property(nonatomic,retain)RCConversationModel *model;

@property(nonatomic,retain)NSString *methodname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign) id <ConnectDetailViewControllerdelegate> delegate;

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,retain)NSString *oldname;

@property(nonatomic,assign)BOOL needhidemorebtn;

@end
