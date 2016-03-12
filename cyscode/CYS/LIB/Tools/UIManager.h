//
//  UIManager.h
//  ChatDemo-UI3.0
//
//  Created by 谢阳晴 on 15/12/9.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIManager : NSObject

+ (id)shareInstance;




-(UIView *)getlineviewWithFrame:(CGRect)myframe withimage:(UIImage *)image withbgcolor:(UIColor *)bgcolor;



-(UILabel *)getLabelWithFrame:(CGRect)myframe theText:(NSString *)mytext Withcolor:(UIColor *)mycolor;



-(UIButton *)getbuttonWithtitle:(NSString *)titlestr theFrame:(CGRect)theframe theButtonImage:(UIImage *)image;



-(UIImageView *)getImageViewWithFrame:(CGRect)theframe theImage:(UIImage *)image;

@end
