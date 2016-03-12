//
//  EnterPriceViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/30.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EnterPriceViewControllerdelegate <NSObject>

-(void)setCustomPrice:(NSString *)price;

@end

@interface EnterPriceViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,retain)NSString *oldname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign)id <EnterPriceViewControllerdelegate> delegate;

@property(nonatomic,assign)BOOL isglobe;
@property(nonatomic,assign)BOOL ismonth;
@property(nonatomic,assign)BOOL isIM;

@property(nonatomic,assign)NSInteger maxPrice;

@end
