//
//  OpenModel.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/12.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface OpenModel : NSObject
@property(nonatomic,assign)BOOL haveOpen;
@property(nonatomic,assign)BOOL havepress;
@property(nonatomic,retain)NSString *sectionnum;
@property(nonatomic,retain)NSString *sectionTitle;
@property(nonatomic,retain)NSString *sectionid;
@property(nonatomic,retain)NSIndexPath *modelindexpath;
@end
