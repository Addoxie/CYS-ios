//
//  SearchNameViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchNameViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,retain)NSString *oldname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;
@end
