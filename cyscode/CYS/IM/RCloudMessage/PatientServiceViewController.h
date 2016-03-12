//
//  PatientServiceViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/30.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeDateViewController.h"

@interface PatientServiceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,FreeDateViewControllerdelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSDictionary *serviceDataDic;
@property(nonatomic,assign)BOOL isglobe;

@end
