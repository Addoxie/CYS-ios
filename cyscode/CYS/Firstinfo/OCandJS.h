//
//  OCandJS.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/5.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCandJS : NSObject
-(void)getCurrentUserAuthTokenWithwebView:(UIWebView *)webview;
-(void)uploadImageWithwebView:(UIWebView *)webview;
-(void)setResultToJSWithwebView:(UIWebView *)webview;

@end
