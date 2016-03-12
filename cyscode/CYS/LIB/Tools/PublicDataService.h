//
//  PublicDataService.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/3.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(id);

@interface PublicDataService : NSObject
+(void)getHomePageInfoblock:(ResponseBlock)block;
+(void)getHomePageBannerblock:(ResponseBlock)block;
+(void)getHomePageOutCallInfoblock:(ResponseBlock)block;


@end
