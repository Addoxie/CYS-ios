//
//  DoctorTeamViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDetailViewController.h"
#import "EditnameViewController.h"

@interface DoctorTeamViewController : UIViewController<UITableViewDataSource,EditnameViewControllerdelegate,UITableViewDelegate,GroupDetailViewControllerdelegate>
{
    
    NSInteger selectedindex;
}
@property(nonatomic,retain)NSMutableArray *teamarr;
@property(nonatomic,retain)NSMutableArray *participatedTeamarr;
@property(nonatomic,retain)NSMutableArray *invitationarr;

@end
