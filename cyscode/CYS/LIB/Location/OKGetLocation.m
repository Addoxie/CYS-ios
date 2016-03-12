//
//  OKGetLocation.m
//  MYLOCATION
//
//  Created by 谢阳晴 on 14/10/23.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import "OKGetLocation.h"


static OKGetLocation *Instance;



@implementation OKGetLocation{
    NSString *mylongitude;
    NSString *mylatitude;
}

-(id)init{

    self=[super init];
    
    return self;
    
}
+(id)shareInstance{
    if (Instance==nil) {
        Instance=[[[self class]alloc]init];
        
    }
    return Instance;
}
-(void)getlocation{
    _mydic=[[NSMutableDictionary alloc]init];
    [self getall];
  
}

-(void)getall{
    _locationManager = [[CLLocationManager alloc] init];
    
    //设置过滤信息
    //    [locationManager setDistanceFilter:<#(CLLocationDistance)#>]
    //设置定位的精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    
    _locationManager.delegate = self;
    
    [_locationManager requestAlwaysAuthorization];
    //开始实时定位
    [_locationManager startUpdatingLocation];
}
//实时定位调用的方法, 6.0过期的方法
#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    
    //NSLog(@"经度：%f,纬度：%f",coordinate.longitude,coordinate.latitude);
    mylongitude=nil;
    mylatitude=nil;
    mylatitude=[NSString stringWithFormat:@"%f",coordinate.latitude];
    mylongitude=[NSString stringWithFormat:@"%f",coordinate.longitude];
    //停止实时定位
    [manager stopUpdatingLocation];
    
    //计算两个位置的距离
    //    float distance = [newLocation distanceFromLocation:oldLocation];
    //    NSLog(@"%f",distance);
    
    
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       
                       for (CLPlacemark *place in placemarks) {
//                           NSLog(@"name,%@",place.name);                       // 位置名
//                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
//                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
//                           NSLog(@"locality,%@",place.locality);               // 市
//                           NSLog(@"subLocality,%@",place.subLocality);         // 区
//                           NSLog(@"country,%@",place.country);                 // 国家
                       }
                       
                   }];
   
   
    //----------------------位置反编码--5.0之前的使用-----------------
    MKReverseGeocoder *mkgeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
    mkgeocoder.delegate = self;
    [mkgeocoder start];
    
}

//6.0之后新增的位置调用方法
//- (void)locationManager:(CLLocationManager *)manager
//	 didUpdateLocations:(NSArray *)locations {
//    for (CLLocation *location in locations) {
//        NSLog(@"%@",location);
//    }
//
//    //停止实时定位
//    //[manager stopUpdatingLocation];
//
//}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [manager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

#pragma mark - MKReverseGeocoder delegate
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder
       didFindPlacemark:(MKPlacemark *)place {
    
//    NSLog(@"---name,%@",place.name);                       // 位置名
//    NSLog(@"---thoroughfare,%@",place.thoroughfare);       // 街道
//    NSLog(@"---subThoroughfare,%@",place.subThoroughfare); // 子街道
//    NSLog(@"---locality,%@",place.locality);               // 市
//    NSLog(@"---subLocality,%@",place.subLocality);         // 区
//    NSLog(@"---country,%@",place.country);                 // 国家
    self.mydic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@ %@",place.locality,place.subLocality],@"locationname",mylongitude,@"longitude",mylatitude,@"latitude",nil];
    //NSLog(@"%@",_block(_mydic));
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myblock(self.mydic);
    });
    
}

@end
