//
//  MsgWebViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/3/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MsgWebViewControllerdelegate <NSObject>

-(void)MsgWebdataMethodname:(NSString *)methodname stringval:(NSString *)stringval;

@end

@interface MsgWebViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>

@property(nonatomic,retain)NSString *methodname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign) id <MsgWebViewControllerdelegate> delegate;

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,retain)NSString *oldname;



@end
