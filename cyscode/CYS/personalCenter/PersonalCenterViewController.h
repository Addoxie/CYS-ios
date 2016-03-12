//
//  PersonalCenterViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientServiceViewController.h"
#import "WebBarCodeViewController.h"
#import "MsgWebViewController.h"

#import "MsgListWebViewController.h"

@interface PersonalCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UITextFieldDelegate,MsgListWebViewControllerdelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;

@end
