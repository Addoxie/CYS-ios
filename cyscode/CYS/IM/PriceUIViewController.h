//
//  PriceUIViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/30.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EnterPriceViewController.h"
#import "FreeDateViewController.h"


@interface PriceUIViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,EnterPriceViewControllerdelegate,FreeDateViewControllerdelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign)NSInteger contenttype;
@property(nonatomic,assign)BOOL isglobe;
@property(nonatomic,assign)BOOL ismonth;
@property(nonatomic,assign)BOOL isIM;
@property(nonatomic,retain)NSString *currentpricestr;
@property(nonatomic,retain)NSDictionary *DataDic;
@property(nonatomic,retain)NSString *pricestr;
@end
