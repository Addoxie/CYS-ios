//
//  AddPatientViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvitefriendsViewController.h"
#import "AddPhoneNumberViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"

@interface AddPatientViewController : UIViewController<navbardelegate,AddPhoneNumberViewControllerdelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,InvitefriendsViewControllerdelegate,UMSocialDataDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *dataarr;
@property(nonatomic,retain)UITextField *usernametf;
@end
