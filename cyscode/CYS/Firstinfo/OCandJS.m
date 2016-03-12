//
//  OCandJS.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/5.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "OCandJS.h"

@implementation OCandJS


-(void)getCurrentUserAuthTokenWithwebView:(UIWebView *)webview{
    
    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]]]];
    NSLog(@"JS返回值：%@",str);
}
-(void)uploadImageWithwebView:(UIWebView *)webview{
   // [self selectPictureAction];
}
-(void)setResultToJSWithwebView:(UIWebView *)webview{
    NSString *resultstr=[NSString stringWithFormat:@"haha"];
    NSString *str = [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@');",[NSString stringWithFormat:@"%@",resultstr]]];
}
@end
