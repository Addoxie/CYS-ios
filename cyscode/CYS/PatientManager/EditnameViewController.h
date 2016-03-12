//
//  EditnameViewController.h
//  ZDE
//
//  Created by NX on 15/8/26.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDetailViewController.h"

@protocol EditnameViewControllerdelegate <NSObject>

-(void)changenameWithNamestr:(NSString *)name;

@end

@interface EditnameViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,GroupDetailViewControllerdelegate>

@property(nonatomic,retain)NSString *oldname;
@property(nonatomic,assign)id <EditnameViewControllerdelegate> delegate;
@end
