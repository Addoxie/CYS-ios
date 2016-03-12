//
//  UIManager.m
//  ChatDemo-UI3.0
//
//  Created by 谢阳晴 on 15/12/9.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "UIManager.h"


static UIManager *instnce;
@implementation UIManager

+ (id)shareInstance {
    if (instnce == nil) {
        //类实例化以便调用实例方法
        
        instnce = [[[self class] alloc] init];
    }
    return instnce;
    
}

-(UIView *)getlineviewWithFrame:(CGRect)myframe withimage:(UIImage *)image withbgcolor:(UIColor *)bgcolor{
    
    UIImageView *bgv1=[[UIImageView alloc]initWithFrame:myframe];
    bgv1.image=image;
    bgv1.backgroundColor=bgcolor;
    return bgv1;
}
-(UILabel *)getLabelWithFrame:(CGRect)myframe theText:(NSString *)mytext Withcolor:(UIColor *)mycolor{
    UILabel *label=[[UILabel alloc]initWithFrame:myframe];
    label.text=mytext;
    label.textColor=mycolor;
    label.font=[UIFont systemFontOfSize:18.0];
    label.textAlignment=NSTextAlignmentLeft;
    return label;
}

-(UIButton *)getbuttonWithtitle:(NSString *)titlestr theFrame:(CGRect)theframe theButtonImage:(UIImage *)image{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=theframe;
    [button setTitle:titlestr forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //  button.backgroundColor = [UIColor blackColor];
    // button.alpha = 0.7;
    // button.layer.cornerRadius = 15;
    //[button addSubview:[self getImageviewWithimage:[UIImage imageNamed:@"test1.jpg"] theFrame:CGRectMake(ScreenWidth/3/2-60/2, 122-100, 60, 60)]];
    //button.backgroundColor=[UIColor grayColor];
    // [button setImage:image forState:UIControlStateNormal];
    
    return button;
}
-(UIImageView *)getImageViewWithFrame:(CGRect)theframe theImage:(UIImage *)image{
    
    UIImageView *imageview=[[UIImageView alloc]init];
    imageview.frame=theframe;
    imageview.image=image;
    
    return imageview;
}

@end
