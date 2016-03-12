//
//  InviteMessageListViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InviteMessageListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *tableView;

@property(nonatomic,retain)NSMutableArray *invitationarr;

@end
