//
//  OrderIMCancleListViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/28.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConnectDetailViewController.h"

@interface OrderIMCancleListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,navbardelegate,UITextFieldDelegate,ConnectDetailViewControllerdelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign)BOOL isphone;
@end
