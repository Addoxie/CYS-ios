//
//  UserUIcontrol.h
//  ZDE
//
//  Created by NX on 15/6/16.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, contentType) {
    Getphoto,
    GetNewpassword,
    Getnewphone,
};

@protocol usercontroldelegate <NSObject>

-(void)controlDCtypeIsAlbum:(BOOL)isalbum;
-(void)controlchanagepassWord;
-(void)controlchanagephone:(NSString *)phonenum;
@end

@interface UserUIcontrol : UIControl<UITextFieldDelegate>{
   // UIView *bgview;
    UITextField *codetf;
    UITextField *codetf1;
    UITextField *codetf2;
    UIButton *getcodebutton;
     UIButton *newgetcodebutton;
    NSInteger i;
    NSInteger j;
    NSTimer *timer;
    NSTimer *newtimer;
    BOOL haveshow;
}

@property(nonatomic,assign)contentType controlType;
@property(nonatomic,retain)UIImage *pimg;
@property(nonatomic,assign) id <usercontroldelegate> delegate;
@end
