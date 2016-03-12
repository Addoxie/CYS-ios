//
//  BaseDataService.m
//  ChatDemo-UI3.0
//
//  Created by 谢阳晴 on 15/12/9.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "BaseDataService.h"
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#include "Mybase64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "GTMBase64.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "SDImageCache.h"
#import "PublicTools.h"




static BaseDataService *instnce;

@implementation BaseDataService

+ (id)shareInstance {
    if (instnce == nil) {
        //类实例化以便调用实例方法
       // [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}
-(void)GetNetWorkDataWithURLStr:(NSString *)URLstr theReturnBlock:(Urlreturnobjblock)block
{
    NSString *myurlstr=[[NSString alloc]init];
    
    
    if ([URLstr rangeOfString:@"public"].location !=NSNotFound) {
        myurlstr=[NSString stringWithFormat:@"%@%@",k_baseurl,URLstr];
    }else{
        myurlstr=[NSString stringWithFormat:@"%@%@",k_sbaseurl,URLstr];
    }
    NSString *useragent=[NSString stringWithFormat:@"%@ %@ %@ %@",[self getCurrentDeviceModel],[self getIOSVersion],[self getcarrierName],[self getNetWorkType]];
    NSLog(@"%@",myurlstr);
    
    
    NSString *encodeurl =[myurlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSURL *myurl=[NSURL URLWithString:encodeurl];
    NSURL *url1 = [NSURL URLWithString:encodeurl];
    NSMutableURLRequest *myrequest=[NSMutableURLRequest requestWithURL:url1];
    
    [myrequest setValue:useragent forHTTPHeaderField:@"User-Agent"];
    
    
    //  NSLog(@"%@",myurlstr);
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]&&[myurlstr rangeOfString:@"protected"].location ==NSNotFound) {
        
        [myrequest timeoutInterval];
        // //NSLog(@"%@",myurlstr);
        [myrequest addValue:[NSString stringWithFormat:@"CYSTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
        
    }else if([myurlstr rangeOfString:@"protected"].location !=NSNotFound){
        NSString *subhstr=[[[myurlstr componentsSeparatedByString:@"?"] objectAtIndex:0] substringFromIndex:k_sbaseurl.length-5];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE',' dd' 'MMM' 'yyyy HH':'mm':'ss z"];
        
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] ;
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
        [myrequest setValue:datestr forHTTPHeaderField:@"Date"];
        
        NSString *hmacstring=[NSString stringWithFormat:@"GET:%@:%@",subhstr,datestr];
        
        [myrequest addValue:[NSString stringWithFormat:@"CYSHMAC ios1:%@",[self hmacsMD5:hmacstring key:@"234567"]] forHTTPHeaderField:@"Authorization"];
        
    }
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:myrequest];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    operation.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        if ([myurlstr rangeOfString:@"account"].location !=NSNotFound) {
//            NSLog(@"%@",myurlstr);
//            NSLog(@"%zd",operation.response.statusCode);
//            NSLog(@"%zd",operation.responseData);
//            NSLog(@"%zd",operation.responseData);
//        }
        NSLog(@"JSON code: %zd", operation.response.statusCode);
    //    NSLog(@"JSON responce: %@",responseObject);
        if (operation.response.statusCode==200) {
            
            
             NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:nil];
            if ([[mydic objectForKey:@"code"] intValue]==4007) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"请重新登录"];
            } else {
                NSArray *arr=[[NSArray alloc]init];
                // NSString *statucode=[NSString stringWithFormat:@"%zd",operation.response.statusCode];
                NSNumber *num=[[NSNumber alloc]initWithInt:200];
                if (responseObject!=nil) {
                    arr=@[num,responseObject];
                }else{
                    arr=@[num];
                }
                
                block(arr);

            }
            
            
        }else{
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        if (operation.responseData!=nil) {
            NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"%@",mydic);
            NSLog(@"JSON code: %zd", operation.response.statusCode);
            if ([[mydic objectForKey:@"code"] intValue]==4007) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"请重新登录"];
            } else {
                
                //            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                //            [[PublicTools shareInstance]creareNotificationUIView:@"网络错误"];
            }
        }else{
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"网络错误"];
        }
       
       
        
        
        
    }];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = NO;
    operation.securityPolicy = securityPolicy;
    [operation start];
    
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
-(void)PostNetWorkDataWithURLStr:(NSString *)URLstr  whitdic:(NSMutableDictionary *)dic theReturnBlock:(Urlreturnobjblock)block{
    
    
    
    
    
    
    
////    
////        UIImage *image=(UIImage *)[dic objectForKey:@"image"];
//    
////    
////        [params setObject:image forKey:@"file"];
//       NSString *url=[NSString stringWithFormat:@"%@%@",k_sbaseurl,URLstr];
//        ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
//        //[aRequest setDelegate:delegate];//代理
//        [request setRequestMethod:@"POST"];
//        [request setDelegate:self];
//       // [request addRequestHeader:@"Content-Type" value:@"image/png"];//这里的value值 需与服务器端 一致
//        //[request setPostFormat:ASIMultipartFormDataPostFormat];
//    
//    
//    [request addRequestHeader:[NSString stringWithFormat:@"CYSTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]] value:@"Authorization"];
//    
//    NSString *ContentDispositionstr=[NSString stringWithFormat:@"form-data;name=%@",@"certificate_img"];
//    
//    [request addRequestHeader:ContentDispositionstr value:@"Content-Disposition"];
//
//    
//    
//        NSArray *keys=[dic allKeys];
//    
//        for (int i=0; i<keys.count; i++) {
//    
//            NSString *key=[keys objectAtIndex:i];
//            NSString *value=[dic objectForKey:key];
//    
//            if ([value isKindOfClass:[UIImage class]]) {
//                //  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test4" ofType:@"gif"];
//                //  NSData*  data=[NSData dataWithContentsOfFile:filePath];
//                UIImage *newimage=(UIImage *)value;
//                NSData *imageData=UIImageJPEGRepresentation(newimage, 1.0);
//                [request addData:imageData withFileName:@"file" andContentType:@"image/jpeg" forKey:@"file"];
//    
//            }
//    
//            [request setPostValue:value forKey:key];
//    
//        }
//    
//    
//        [request setCompletionBlock:^{
//            NSData *data=[request responseData];
//            
//            
//            NSData *truedata=[request responseData];
//            
//            // //NSLog(@"%@",request.responseHeaders);
//            NSLog(@"%zd",request.responseStatusCode);
//            
//            NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:truedata options:NSJSONReadingMutableLeaves error:nil];
//            //NSLog(@"%@",mytruedic);
//            NSLog(@"JSON responce: %@",mydic);
//
//                    if ([[mydic objectForKey:@"code"] intValue]==4007) {
//            
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
//                        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                        [[PublicTools shareInstance]creareNotificationUIView:@"请重新登录"];
//                    } else {
//                    // NSString *statucode=[NSString stringWithFormat:@"%zd",operation.response.statusCode];
//                    NSArray *arr=[[NSArray alloc]init];
//                    NSNumber *num=[[NSNumber alloc]initWithInt:200];
//                        NSLog(@"%@",mydic);
//                        NSLog(@"%@",mydic);
//                        
//                    if (data!=nil) {
//            
//                        arr=@[num,mydic];
//                    }else{
//                        arr=@[num];
//                    }
//                  //  block(arr);
//                    }
//
//            
//        }];
//        [request setFailedBlock:^{
//          //  block(@"f");
//            NSData *data=[request responseData];
//             NSLog(@"%zd",request.responseStatusCode);
//            NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//             NSLog(@"%@",mydic);
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"上传失败"];
//
//        }];
//        
//    //    [request setDidFinishSelector:@selector(headPortraitSuccess)];//当成功后会自动触发 headPortraitSuccess 方法
//    //    [request setDidFailSelector:@selector(headPortraitFail)];//如果失败会 自动触发 headPortraitFail 方法
//        
//        [request startAsynchronous];//开始。异步
//    
//    
    
    
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    // [manager.requestSerializer setValue:@"gzip" forKey:@"Accept-Encoding"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //传入的参数
    
    //你的接口地址
    NSString *url=[NSString stringWithFormat:@"%@%@",k_sbaseurl,URLstr];
    
    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = NO;
//    manager.securityPolicy = securityPolicy;
    
    
    //发送请求
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *keys=[dic allKeys];
        ////NSLog(@"%@",dic );
        for (int i=0; i<keys.count; i++) {
            //  //NSLog(@"%zd",i);
            NSString *key=[keys objectAtIndex:i];
            //  NSString *value=[dic objectForKey:key];
            if ([[dic objectForKey:key] isKindOfClass:[UIImage class]]) {
             
                UIImage *myimage=(UIImage *)[dic objectForKey:key];
                NSData *imageData=UIImageJPEGRepresentation(myimage, 1.0);
                //[request addData:imageData forKey:key];
                
                
                
                //[formData appendPartWithHeaders:headerdic body:imageData];
                
                
                
                [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"icon%zd.jpg",i] mimeType:@"image/jpeg"];
                
                NSLog(@"%@",formData);
            
               // [formData appendPartWithHeaders:<#(NSDictionary *)#> body:<#(NSData *)#>]
                
            }else{
                
                //     //NSLog(@"%@",[self dictionaryToJson:[dic objectForKey:key]]);
//                
//                // [formData appendPartWithFormData:[[self dictionaryToJson:[dic objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding] name:key];
//                NSString *ContentDispositionstr=[NSString stringWithFormat:@"form-data;name=%@",@"\"certificate_img\""];
//                NSDictionary *headerdic=[[NSDictionary alloc]initWithObjectsAndKeys:@"application/json; charset=UTF-8",@"Content-Type",ContentDispositionstr,@"Content-Disposition",@"8bit",@"Content-Transfer-Encoding",@"gzip",@"Accept-Encoding",[NSString stringWithFormat:@"CYSTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]],@"Authorization",nil];
//                // [myrequest addValue:[NSString stringWithFormat:@"CYSTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
//                [formData appendPartWithHeaders:headerdic body:[[self dictionaryToJson:[dic objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
//                // //NSLog(@"%@",formData);
            }
            
            
        }
        
        //  [formData appendPartWithFileData:imgData name:@"imagefile" fileName:@"img.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON code: %zd", operation.response.statusCode);
        NSLog(@"JSON responce: %@",responseObject);
        
        NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:nil];
        if ([[mydic objectForKey:@"code"] intValue]==4007) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"请重新登录"];
        } else {
        // NSString *statucode=[NSString stringWithFormat:@"%zd",operation.response.statusCode];
        NSArray *arr=[[NSArray alloc]init];
        NSNumber *num=[[NSNumber alloc]initWithInt:200];
        if (responseObject!=nil) {
            
            arr=@[num,responseObject];
        }else{
            arr=@[num];
        }
        block(arr);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // block(nil);
        if (operation.responseData!=nil) {
            NSLog(@"JSON code: %zd", operation.response.statusCode);
            NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",mydic);
            NSLog(@"%@", error.userInfo);
            if ([[mydic objectForKey:@"code"] intValue]==4007) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"请重新登录"];
            } else if ([[mydic objectForKey:@"code"] intValue]==4003){
                NSLog(@"JSON code: %zd", operation.response.statusCode);
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"网络错误"];
            }
        }else{
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"网络错误"];
        }
       
    }];
}
-(UIImage *)compressImage:(UIImage *)imgSrc
{
    CGSize size = {150, 150*imgSrc.size.height/imgSrc.size.width};
    UIGraphicsBeginImageContext(size);
    CGRect rect = {{0,0}, size};
    [imgSrc drawInRect:rect];
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return compressedImg;
}
-(void)PostNetWorkJSONWithURLStr:(NSString *)URLstr  whitdic:(NSMutableDictionary *)dic theReturnBlock:(Urlreturnobjblock)block{
    
    NSString *url=[[NSString alloc]init];
    
    NSString *useragent=[NSString stringWithFormat:@"%@ %@ %@ %@",[self getCurrentDeviceModel],[self getIOSVersion],[self getcarrierName],[self getNetWorkType]];
    
    if ([URLstr rangeOfString:@"public"].location !=NSNotFound) {
        url=[NSString stringWithFormat:@"%@%@",k_baseurl,URLstr];
    }else{
        url=[NSString stringWithFormat:@"%@%@",k_sbaseurl,URLstr];
    }
    NSString *encodeurl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *myurl=[NSURL URLWithString:encodeurl];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:myurl];
    [request setRequestMethod:@"POST"];
    //    [request setAllowCompressedResponse:YES];
    //    request.shouldCompressRequestBody=YES;
    [request setTimeOutSeconds:10];
    NSLog(@"%@",request);
//    if ([dic objectForKey:@"kkdoctors"]) {
//    
//    }
   if (dic!=nil) {
    
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        request.postBody=tempJsonData;
    }
//    }else if (dic!=nil){
//       
//        
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[dic objectForKey:@"kkdoctors"]
//                                                               options:NSJSONWritingPrettyPrinted
//                                                                 error:nil];
//            
//            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
//            request.postBody=tempJsonData;
//
//    }
    
    
    //处理POST请求
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]!=nil&&[url rangeOfString:@"protected"].location ==NSNotFound) {
        NSString *ContentDispositionstr=[NSString stringWithFormat:@"form-data;name=%@",@"\"user-info\""];
        NSMutableDictionary *headerdic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"application/json; charset=UTF-8",@"Content-Type",ContentDispositionstr,@"Content-Disposition",@"8bit",@"Content-Transfer-Encoding",[NSString stringWithFormat:@"CYSTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]],@"Authorization",useragent,@"User-Agent",nil];
        //,@"gzip",@"Accept-Encoding"
        
        [request setRequestHeaders:headerdic];
        
        //[addValue:[NSString stringWithFormat:@"NXTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    }else if([url rangeOfString:@"protected"].location !=NSNotFound){
        NSString *subhstr=[[[url componentsSeparatedByString:@"?"] objectAtIndex:0] substringFromIndex:k_sbaseurl.length-5];
        //  //NSLog(@"%@",subhstr);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE','dd' 'MMM' 'yyyy HH':'mm':'ss z"];
        
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] ;
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
        // [request setValue:datestr forHTTPHeaderField:@"Date"];
        
        NSString *hmacstring=[NSString stringWithFormat:@"POST:%@:%@",subhstr,datestr];
        
        //[request addValue:[NSString stringWithFormat:@"NXHMAC ios1:%@",[self hmacsMD5:hmacstring key:nil]] forHTTPHeaderField:@"Authorization"];
        // NSString *ContentDispositionstr=[NSString stringWithFormat:@"form-data;name=%@",@"\"user-info\""];
        NSMutableDictionary *headerdic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:datestr,@"Date",[NSString stringWithFormat:@"CYSHMAC ios1:%@",[self hmacsMD5:hmacstring key:@"234567"]],@"Authorization",@"application/json; charset=UTF-8",@"Content-Type",useragent,@"User-Agent", nil];
        //,@"gzip",@"Accept-Encoding"
        
        
        [request setRequestHeaders:headerdic];
        
    }
    
    ////NSLog(@"%@",request.requestHeaders);
    [request setCompletionBlock:^{
         // NSData *data=[request responseData];
        NSLog(@"%zd",request.responseStatusCode);
        //     NSJSONSerialization *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        //NSLog(@"%@",json);
        if (request.responseData!=nil&&request.responseStatusCode==200){
            NSError *error = nil;
            NSData *truedata=[request responseData];
            
            // //NSLog(@"%@",request.responseHeaders);
            //NSLog(@"%zd",request.responseStatusCode);
            
            NSDictionary *mytruedic = [NSJSONSerialization JSONObjectWithData:truedata options:NSJSONReadingMutableLeaves error:&error];
            //NSLog(@"%@",mytruedic);
              NSLog(@"JSON responce: %@",mytruedic);
         
            if ([[mytruedic objectForKey:@"code"] intValue]==4007) {
               [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"请重新登录"];
            }else{
               
                NSArray *arr=[[NSArray alloc]init];
                // //NSLog(@"%@",mytruedic);
                NSNumber *num=[[NSNumber alloc]initWithInt:200];
                if (mytruedic!=nil) {
                    arr=@[num,mytruedic];
                }else{
                    arr=@[num];
                }
                block(arr);

            }
            
            
            
                
                
            
                
        } else if (request.responseData==nil){
            
                NSNumber *num=[[NSNumber alloc]initWithInt:200];
                NSArray *arr=[[NSArray alloc]init];
               
                arr=@[num];
                
                block(arr);
                
            }
        
        
    }];
    
    [request setFailedBlock:^{
         NSLog(@"%zd",request.responseStatusCode);
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"网络错误"];
        
        
    }];
//    NSLog(@"%@",request.requestHeaders);
//    NSDictionary *mytruedic = [NSJSONSerialization JSONObjectWithData:request.postBody options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"%@",mytruedic);
    [request startAsynchronous];
    
    
}

-(void)PostNetWorkJSONWithURLStr:(NSString *)URLstr  whitdic:(NSMutableArray *)arr isArr:(BOOL)isArr theReturnBlock:(Urlreturnobjblock)block{


    NSString *url=[[NSString alloc]init];
    
    NSString *useragent=[NSString stringWithFormat:@"%@ %@ %@ %@",[self getCurrentDeviceModel],[self getIOSVersion],[self getcarrierName],[self getNetWorkType]];
    
    if ([URLstr rangeOfString:@"public"].location !=NSNotFound) {
        url=[NSString stringWithFormat:@"%@%@",k_baseurl,URLstr];
    }else{
        url=[NSString stringWithFormat:@"%@%@",k_sbaseurl,URLstr];
    }
    NSString *encodeurl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *myurl=[NSURL URLWithString:encodeurl];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:myurl];
    [request setRequestMethod:@"POST"];
    //    [request setAllowCompressedResponse:YES];
    //    request.shouldCompressRequestBody=YES;
    [request setTimeOutSeconds:10];
    
    //    if ([dic objectForKey:@"kkdoctors"]) {
    //
    //    }
    //    if (dic!=nil&&![dic objectForKey:@"kkdoctors"]) {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
    
    request.postBody=tempJsonData;
    //
    //    }else if (dic!=nil){
    //
    //
    //            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[dic objectForKey:@"kkdoctors"]
    //                                                               options:NSJSONWritingPrettyPrinted
    //                                                                 error:nil];
    //
    //            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
    //            request.postBody=tempJsonData;
    //
    //    }
    
    
    //处理POST请求
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"token"]!=nil&&[url rangeOfString:@"protected"].location ==NSNotFound) {
        NSString *ContentDispositionstr=[NSString stringWithFormat:@"form-data;name=%@",@"\"user-info\""];
        NSMutableDictionary *headerdic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"application/json; charset=UTF-8",@"Content-Type",ContentDispositionstr,@"Content-Disposition",@"8bit",@"Content-Transfer-Encoding",[NSString stringWithFormat:@"CYSTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]],@"Authorization",useragent,@"User-Agent",nil];
        //,@"gzip",@"Accept-Encoding"
        
        [request setRequestHeaders:headerdic];
        
        //[addValue:[NSString stringWithFormat:@"NXTOKEN %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    }else if([url rangeOfString:@"protected"].location !=NSNotFound){
        NSString *subhstr=[[[url componentsSeparatedByString:@"?"] objectAtIndex:0] substringFromIndex:k_sbaseurl.length-5];
        //  //NSLog(@"%@",subhstr);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE','dd' 'MMM' 'yyyy HH':'mm':'ss z"];
        
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] ;
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
        // [request setValue:datestr forHTTPHeaderField:@"Date"];
        
        NSString *hmacstring=[NSString stringWithFormat:@"POST:%@:%@",subhstr,datestr];
        
        //[request addValue:[NSString stringWithFormat:@"NXHMAC ios1:%@",[self hmacsMD5:hmacstring key:nil]] forHTTPHeaderField:@"Authorization"];
        // NSString *ContentDispositionstr=[NSString stringWithFormat:@"form-data;name=%@",@"\"user-info\""];
        NSMutableDictionary *headerdic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:datestr,@"Date",[NSString stringWithFormat:@"CYSHMAC ios1:%@",[self hmacsMD5:hmacstring key:@"234567"]],@"Authorization",@"application/json; charset=UTF-8",@"Content-Type",useragent,@"User-Agent", nil];
        //,@"gzip",@"Accept-Encoding"
        
        
        [request setRequestHeaders:headerdic];
        
    }
    
    ////NSLog(@"%@",request.requestHeaders);
    [request setCompletionBlock:^{
        // NSData *data=[request responseData];
        NSLog(@"%zd",request.responseStatusCode);
        //     NSJSONSerialization *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        //NSLog(@"%@",json);
        if (request.responseData!=nil&&request.responseStatusCode==200){
            NSError *error = nil;
            NSData *truedata=[request responseData];
            // //NSLog(@"%@",request.responseHeaders);
            //NSLog(@"%zd",request.responseStatusCode);
            
            NSDictionary *mytruedic = [NSJSONSerialization JSONObjectWithData:truedata options:NSJSONReadingMutableLeaves error:&error];
            //NSLog(@"%@",mytruedic);
            
            
            NSArray *arr=[[NSArray alloc]init];
            // //NSLog(@"%@",mytruedic);
            NSNumber *num=[[NSNumber alloc]initWithInt:200];
            if (mytruedic!=nil) {
                arr=@[num,mytruedic];
            }else{
                arr=@[num];
            }
            block(arr);
            
            
            
            
            
        } else if (request.responseData==nil){
            
            NSNumber *num=[[NSNumber alloc]initWithInt:200];
            NSArray *arr=[[NSArray alloc]init];
            
            arr=@[num];
            
            block(arr);
            
        }
        
        
    }];
    
    [request setFailedBlock:^{
        NSLog(@"%zd",request.responseStatusCode);
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"网络错误"];
        
        
    }];
    [request startAsynchronous];
    
    




}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        // //NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(NSString *)hmacsMD5:(NSString *)text key:(NSString *)secret {
    //  //NSLog(@"%@",text);
    secret=@"234567";
    
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, [secretData bytes], [secretData length], [clearTextData bytes],[clearTextData length], result);
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, CC_MD5_DIGEST_LENGTH, base64Result, &theResultLength,YES);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
    ////NSLog(@"%@",base64EncodedResult);
    
    return base64EncodedResult;
}
-(NSString *)getNetWorkType{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *subviews = [[[application valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetWorkItemView = nil;
    for (id subView in subviews) {
        if ([subView isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetWorkItemView = subView;
            break;
        }
    }
    NSString *typestr=[[NSString alloc]init];
    //  //NSLog(@"%zd",[[dataNetWorkItemView valueForKey:@"dataNetworkType"]integerValue]);
    // NewNetWorkType networkType = NetWorkType_None;
    switch ([[dataNetWorkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            //NSLog(@"No wifi or cellular");
            // networkType = NetWorkType_None;
            typestr=@"No wifi or cellular";
            break;
            
        case 1:
            //NSLog(@"2G");
            //   networkType = NetWorkType_2G;
            typestr=@"2G";
            break;
            
        case 2:
            //NSLog(@"3G");
            //  networkType = NetWorkType_3G;
            typestr=@"3G";
            break;
        case 3:
            //NSLog(@"4G");
            //  networkType = NetWorkType_3G;
            typestr=@"4G";
            break;
        default:
            //NSLog(@"Wifi");
            // networkType = NetWorkType_WIFI;
            typestr=@"Wifi";
            break;
    }
    return typestr;
}

-(NSString *)getIOSVersion
{
    return [NSString stringWithFormat:@"ios %.2f",[[[UIDevice currentDevice] systemVersion] floatValue]];
}
-(NSString *)getcarrierName{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry=[carrier carrierName];
    NSData *data = [currentCountry dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",base64String);
    return base64String;
}
-(NSString *)getCurrentDeviceModel{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    NSLog(@"%@",platform);
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus (A1634)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

@end
