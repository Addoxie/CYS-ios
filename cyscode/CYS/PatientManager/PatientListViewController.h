//
//  PatientListViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/28.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "HXViewController.h"
#import "TagsGroupViewController.h"
#import "TagsRenameViewController.h"
#import "OpenCellModel.h"



@interface PatientListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,HXViewControllerdelegate,TagsGroupViewControllerdelegate,TagsRenameViewControllerdelegate,UIScrollViewDelegate>

@property (nonatomic, retain) UITableView *tableView;


@end
