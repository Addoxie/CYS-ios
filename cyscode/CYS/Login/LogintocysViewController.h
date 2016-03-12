//
//  LoginViewController.h
//  ZDE
//
//  Created by 谢阳晴 on 15/5/18.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <RongIMKit/RongIMKit.h>

@protocol LogintocysViewController <NSObject>

-(void)havelogin;

@end



@interface LogintocysViewController : UIViewController<UITextFieldDelegate,ICSDrawerControllerChild, ICSDrawerControllerPresenting,navbardelegate>{
    UIView *containview;
}
@property(nonatomic,retain)UITextField *usernametf;
@property(nonatomic,assign)BOOL isrootvc;
@property(nonatomic,assign)BOOL needfirst;
@property(nonatomic,retain)UITextField *passwordtf;
@property(nonatomic,retain)UITextField *phonenumtf;
@property(nonatomic,retain)UITextField *captchanumrtf;
@property(nonatomic,assign)id <LogintocysViewController> delegate;
@end
