//
//  NavBarView.h
//  ZDE
//
//  Created by NX on 15/6/11.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol navbardelegate <NSObject>

-(void)itemactionWithType:(NSInteger)typeindex;

@end

@interface NavBarView : UIView{
    UIButton *canclebutton;
    UILabel *titlelabel;
}
@property(nonatomic,retain)NSString *navbarTitle;
@property (nonatomic,assign)id <navbardelegate> delegate;
@property (nonatomic,assign)BOOL isRoot;
@property (nonatomic,assign)BOOL isneedtype;
-(void)setnavtitle:(NSString *)title;
-(void)setnavcancletitle:(NSString *)title;
-(void)setnavcanclecolor:(UIColor *)color;
-(void)setnavbackimageisroot:(BOOL)isroot;
-(void)hiderightbtn:(BOOL)needhide;
-(void)setnavcancletimage:(NSString *)imagename;
-(void)hidebacktbtn;
@end
