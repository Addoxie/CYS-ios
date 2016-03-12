//
//  AcountDetailViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/3/3.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AcountDetailViewControllerdelegate <NSObject>

-(void)AcountDetaildataMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type;

@end



@interface AcountDetailViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>

@property(nonatomic,retain)NSString *methodname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign) id <AcountDetailViewControllerdelegate> delegate;

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,retain)NSString *oldname;

@property(nonatomic,assign)BOOL needhidemorebtn;


@end
