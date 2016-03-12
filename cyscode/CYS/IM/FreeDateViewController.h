//
//  FreeDateViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FreeDateViewControllerdelegate <NSObject>

-(void)sentFreedate:(NSString *)Freedate isoffer:(BOOL) isoffer;

@end


@interface FreeDateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSArray *indexdataArr;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign)NSInteger contenttype;
@property(nonatomic,assign)BOOL isglobe;
@property(nonatomic,assign)BOOL ismonth;
@property(nonatomic,assign)BOOL isIM;
@property(nonatomic,retain)NSDictionary *DataDic;
@property(nonatomic,retain)NSString *freestr;
@property(nonatomic,assign)id <FreeDateViewControllerdelegate> delegate;

@end
