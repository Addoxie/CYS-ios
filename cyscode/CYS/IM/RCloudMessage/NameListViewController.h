//
//  NameListViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/30.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsRenameViewController.h"
#import "CutomUIButton.h"
#import "HXViewController.h"
#import "EditSpamContentViewController.h"


@interface NameListViewController : UIViewController<TagsRenameViewControllerdelegate,HXViewControllerdelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign)BOOL isSpam;
@property(nonatomic,retain)NSMutableArray *editdataarr;
@end
