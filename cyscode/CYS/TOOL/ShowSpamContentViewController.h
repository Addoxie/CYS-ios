//
//  EditSpamContentViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/22.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowSpamContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *contactarr;
@end