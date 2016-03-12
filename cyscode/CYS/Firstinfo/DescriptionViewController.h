//
//  DescriptionViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/19.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DescriptionViewControllerdelegate <NSObject>

-(void)DescriptionDealtdataMethodname:(NSString *)methodname stringval:(NSString *)stringval;

@end

@interface DescriptionViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate>

@property(nonatomic,retain)NSString *methodname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign) id <DescriptionViewControllerdelegate> delegate;

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,retain)NSString *oldname;


@end
