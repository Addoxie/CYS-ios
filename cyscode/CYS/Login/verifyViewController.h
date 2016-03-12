//
//  verifyViewController.h
//  ZDE
//
//  Created by 谢阳晴 on 15/5/19.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface verifyViewController : UIViewController<UITextFieldDelegate,navbardelegate>
@property(nonatomic,retain)UITextField *usernametf;
@property(nonatomic,retain)NSString *phonenum;
@property(nonatomic,retain)NSString *password;
@end
