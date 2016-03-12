//
//  SetPasswordViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/10.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPasswordViewController : UIViewController<navbardelegate,UITextFieldDelegate>
@property(nonatomic,retain)NSString *phonenum;
@property(nonatomic,retain)NSString *signature;
@end
