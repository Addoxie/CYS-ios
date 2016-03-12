//
//  WebBarCodeViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvitefriendsViewController.h"
#import "AddPhoneNumberViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"


@interface WebBarCodeViewController : UIViewController<navbardelegate,AddPhoneNumberViewControllerdelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,InvitefriendsViewControllerdelegate,UMSocialUIDelegate>
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *dataarr;
@property(nonatomic,retain)UITextField *usernametf;

@end
