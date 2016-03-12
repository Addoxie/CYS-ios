//
//  UpdatePasswordViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePasswordViewController : UIViewController<UITextFieldDelegate>


@property(nonatomic,assign)BOOL isEnterOldPW;
@property(nonatomic,assign)BOOL isEnterNEWPW;
@property(nonatomic,retain)NSString *oldPW;
@end
