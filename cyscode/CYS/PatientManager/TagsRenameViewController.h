//
//  TagsRenameViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/13.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CutomUIButton.h"

@protocol TagsRenameViewControllerdelegate <NSObject>

-(void)reloadrenametags;
-(void)addwithdic:(NSDictionary *)tagdic;

@end

@interface TagsRenameViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    UITextField *codetf1;
}


@property(nonatomic,assign)id <TagsRenameViewControllerdelegate> delegate;
@property(nonatomic,assign)BOOL isadd;
@property(nonatomic,retain)NSString *tagid;
@property(nonatomic,retain)NSString *tagstr;
@end
