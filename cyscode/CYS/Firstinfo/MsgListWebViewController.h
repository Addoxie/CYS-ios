//
//  MsgListWebViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/3/4.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MsgDetailViewController.h"


@protocol MsgListWebViewControllerdelegate <NSObject>

-(void)MsgListWebMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type;

@end

@interface MsgListWebViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate,MsgDetailViewControllerdelegate>

@property(nonatomic,retain)NSString *methodname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign) id <MsgListWebViewControllerdelegate> delegate;

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,retain)NSString *oldname;

@property(nonatomic,assign)BOOL needhidemorebtn;


@end
