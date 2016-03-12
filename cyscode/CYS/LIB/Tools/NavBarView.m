//
//  NavBarView.m
//  ZDE
//
//  Created by NX on 15/6/11.
//  Copyright (c) 2015年 谢阳晴. All rights reserved.
//

#import "NavBarView.h"

@implementation NavBarView


-(id)initWithFrame:(CGRect)frame{
    if (self) {
        self=[super initWithFrame:frame];
        self.frame=CGRectMake(0, 0, ScreenWidth, 64);
        self.backgroundColor=[UIColor whiteColor];
        //[self.view addSubview:containview];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 0.0;
        self.layer.borderWidth = 0.0;
        self.layer.borderColor = [[UIColor grayColor] CGColor];
      
        // Do any additional setup after loading the view.
        canclebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        canclebutton.frame=CGRectMake(12, 29, 60, 30);
        [canclebutton setTitle:@"  返回" forState:UIControlStateNormal];
        [canclebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [canclebutton addTarget:self action:@selector(cancleitemaction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:canclebutton];
        
        
        
        
        
       
    }
    return self;
}
-(void)hidebacktbtn{
    canclebutton.hidden=YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.isRoot) {
        [canclebutton setImage:[UIImage imageNamed:@"sidebar.png"] forState:UIControlStateNormal];
    } else {
        UIImageView *backarowv=[[UIImageView alloc]initWithFrame:CGRectMake(10, 33, 13, 21)];
        backarowv.image=[UIImage imageNamed:@"back"];
        [self addSubview:backarowv];
        [canclebutton setImage:[UIImage imageNamed:@"returnback.png"] forState:UIControlStateNormal];
    }
    if (self.isneedtype) {
        [canclebutton setImage:[UIImage imageNamed:@"returnback.png"] forState:UIControlStateNormal];
    }
   // UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    [canclebutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60-25)];
    titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-200/2, 29, 200, 30)];
    titlelabel.text=self.navbarTitle;
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.font=[UIFont boldSystemFontOfSize:19.0];
   // titlelabel.backgroundColor=[UIColor redColor];
    [self addSubview:titlelabel];


}
-(void)setnavcanclecolor:(UIColor *)color{
    [canclebutton setTitleColor:color forState:UIControlStateNormal];
    [canclebutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];

}
-(void)setnavcancletimage:(NSString *)imagename{
    [canclebutton setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
}
-(void)setnavcancletitle:(NSString *)title{
//    [canclebutton setTitle:title forState:UIControlStateNormal];
//    canclebutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
//    [canclebutton sizeToFit];
}
-(void)setnavtitle:(NSString *)title{
    titlelabel.text=title;
   // titlelabel.textColor=[UIColor orangeColor];
}
-(void)hiderightbtn:(BOOL)needhide{
    if (needhide) {
        canclebutton.hidden=YES;
    } else {
        canclebutton.hidden=NO;
    }
}
-(void)cancleitemaction{
    if (self.isneedtype) {
        [self.delegate itemactionWithType:100];
    }else{
    [self.delegate itemactionWithType:1];
    }
}
-(void)setnavbackimageisroot:(BOOL)isroot{
    if (isroot) {
        [canclebutton setImage:[UIImage imageNamed:@"sidebar.png"] forState:UIControlStateNormal];
    } else {
        [canclebutton setImage:[UIImage imageNamed:@"returnback.png"] forState:UIControlStateNormal];
    }
    //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    [canclebutton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60-30)];
}
@end
