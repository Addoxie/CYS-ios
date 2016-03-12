//
//  AddDoctorViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDoctorViewController : UIViewController<navbardelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *dataArr;
@property(nonatomic,retain)NSString *docteamid;
@property(nonatomic,assign)BOOL isneedTimeLine;
@property(nonatomic,assign)BOOL isfromPersonCenter;
@end
