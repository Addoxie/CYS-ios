//
//  FaceOrderViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/20.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceOrderViewController : UIViewController<UIWebViewDelegate,navbardelegate>

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,assign)BOOL isPersonal;

@property(nonatomic,assign)NSInteger statustype;
@end
