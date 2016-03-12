//
//  CallListViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/11.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemdetailbutton.h"
#import "NavBarView.h"
#import "ConnectDetailViewController.h"

@interface CallListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UITextFieldDelegate,ConnectDetailViewControllerdelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign)BOOL isphone;
@property(nonatomic,assign)BOOL isshow1st;
@property(nonatomic,assign)BOOL isshowCancle;
@end
