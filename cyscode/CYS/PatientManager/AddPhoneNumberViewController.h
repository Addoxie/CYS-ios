//
//  AddPhoneNumberViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/1.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CutomUIButton.h"

@protocol AddPhoneNumberViewControllerdelegate <NSObject>

-(void)reloadrenametags;
-(void)addwithdic:(NSDictionary *)tagdic;

@end

@interface AddPhoneNumberViewController : UIViewController<UITextFieldDelegate,navbardelegate>{
    UITextField *codetf1;
}


@property(nonatomic,assign)id <AddPhoneNumberViewControllerdelegate> delegate;
@property(nonatomic,assign)BOOL isadd;
@property(nonatomic,retain)NSString *tagid;
@property(nonatomic,retain)NSString *tagstr;




@end
