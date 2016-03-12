//
//  AddBankCardViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/3/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EnterBandCardInfoViewController.h"

@protocol AddBankCardViewControllerdelegate <NSObject>

-(void)AddBankCardDealtdataMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type;

@end


@interface AddBankCardViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate,EnterBandCardInfoViewControllerdelegate>

@property(nonatomic,retain)NSString *methodname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign) id <AddBankCardViewControllerdelegate> delegate;

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,retain)NSString *oldname;

@property(nonatomic,assign)BOOL needhidemorebtn;

@end
