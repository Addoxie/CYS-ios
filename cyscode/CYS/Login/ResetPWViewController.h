//
//  ResetPWViewController.h
//  ZDE
//
//  Created by NX on 15/6/15.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPWViewController : UIViewController<navbardelegate,UITextFieldDelegate>
@property(nonatomic,retain)NSString *phonenum;
@property(nonatomic,retain)NSString *signature;
@end
