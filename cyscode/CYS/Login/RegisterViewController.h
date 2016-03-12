//
//  RegisterViewController.h
//  ZDE
//
//  Created by 谢阳晴 on 15/5/19.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBarView.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate,navbardelegate>
@property(nonatomic,retain)UITextField *usernametf;
@property(nonatomic,retain)UITextField *passwordtf;
@property(nonatomic,retain)UITextField *phonenumtf;
@property(nonatomic,retain)UITextField *captchanumrtf;


@end
