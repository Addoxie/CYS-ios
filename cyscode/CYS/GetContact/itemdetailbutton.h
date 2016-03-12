//
//  itemdetailbutton.h
//  ByShare
//
//  Created by 谢阳晴 on 14/11/25.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itemdetailbutton : UIButton
@property(nonatomic,assign)NSInteger buttonlocation;
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)BOOL havePressed;
@property(nonatomic,retain)NSString *keystr;
@end
