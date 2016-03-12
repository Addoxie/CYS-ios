//
//  UpdatePhoneViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePhoneViewController : UIViewController<UITextFieldDelegate>


//@property(nonatomic,assign)BOOL isEnterOldPW;
//@property(nonatomic,assign)BOOL isEnterNEWPW;

@property(nonatomic,assign)BOOL isEnterPhone;
@property(nonatomic,assign)BOOL isGetCode;
@property(nonatomic,assign)BOOL isnewPhone;
@property(nonatomic,retain)NSString *phoneNum;
@property(nonatomic,retain)NSString *signatrmask;
@end
