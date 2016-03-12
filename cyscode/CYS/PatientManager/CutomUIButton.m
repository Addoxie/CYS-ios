//
//  CutomUIButton.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/29.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "CutomUIButton.h"


@interface CutomUIButton ()
{
    UIImageView *stateimagev;
}

@end

@implementation CutomUIButton



-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.isneedArrow) {
        stateimagev=[[UIImageView alloc]initWithFrame:CGRectMake(15, 52/2.0-10/2.0, 9, 10)];
        stateimagev.image=[UIImage imageNamed:@"expansion_2"];
        [self addSubview:stateimagev];

    }
    
}
-(void)setCustomSelect:(BOOL)haveselect{
    
    if (haveselect) {
          stateimagev.image=[UIImage imageNamed:@"expansion_1"];
    } else {
      
          stateimagev.image=[UIImage imageNamed:@"expansion_2"];
    }
   
    
    
}
@end
