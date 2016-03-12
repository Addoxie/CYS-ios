//
//  OKGetLocation.h
//  MYLOCATION
//
//  Created by 谢阳晴 on 14/10/23.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^FinishLoadBlock)(NSMutableDictionary *);

@interface OKGetLocation : NSObject<CLLocationManagerDelegate,MKReverseGeocoderDelegate>
@property(nonatomic,copy)FinishLoadBlock myblock;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,retain)NSMutableDictionary *mydic;
+(id)shareInstance;
-(void)getlocation;
@end
