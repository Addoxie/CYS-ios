//
//  CutomUIButton.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/29.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CutomUIButton : UIButton
@property(nonatomic,assign)NSUInteger section;
@property(nonatomic,assign)NSUInteger row;
@property(nonatomic,assign)NSUInteger subrow;
@property(nonatomic,assign)BOOL isneedArrow;
-(void)setCustomSelect:(BOOL)haveselect;
@end
