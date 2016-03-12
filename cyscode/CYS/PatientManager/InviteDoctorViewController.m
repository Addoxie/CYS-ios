//
//  InviteDoctorViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/29.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "InviteDoctorViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIKit+AFNetworking.h"


@interface InviteDoctorViewController ()

@end

@implementation InviteDoctorViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title=@"邀请医生";
    self.view.backgroundColor=KBackgroundColor;
    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0/2.0-60/2.0+10, 150, 70, 60)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =0.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:@"wechat_56px"]];
    [self.view addSubview:imagev];

    
    
    
    UIButton *addgroupbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    addgroupbutton.frame=CGRectMake(25+20, 200, ScreenWidth/2.0-50, 50);
    
    addgroupbutton.layer.masksToBounds = YES;
    addgroupbutton.layer.cornerRadius = 6.0;
    addgroupbutton.layer.borderWidth = 1.0;
    addgroupbutton.layer.borderColor = [[UIColor clearColor] CGColor];
    [addgroupbutton setTitle:@"微信好友" forState:UIControlStateNormal];
    [addgroupbutton setTitleColor:KGrayColor forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    addgroupbutton.titleLabel.font=[UIFont systemFontOfSize:19.0];
    [addgroupbutton addTarget:self action:@selector(addgroupbuttontaction) forControlEvents:UIControlEventTouchUpInside];
    //addgroupbutton.backgroundColor=KlightOrangeColor;
    [self.view addSubview:addgroupbutton];
    
    
    
    
    
    UIImageView *imagev1;
    //=[[UIImageView alloc]init];
    
    
    imagev1 =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0+ScreenWidth/2.0/2.0-60/2.0-20, 150, 60, 60)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    imagev1.clipsToBounds=YES;
    
    imagev1.layer.masksToBounds=YES;
    imagev1.layer.cornerRadius =0.0;
    imagev1.layer.borderColor = [UIColor clearColor].CGColor;
    imagev1.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [imagev1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:@"monent_56px"]];
    [self.view addSubview:imagev1];
    
    
    
    
    UIButton *addgroupbutton1=[UIButton buttonWithType:UIButtonTypeCustom];
    addgroupbutton1.frame=CGRectMake(ScreenWidth/2.0+25.0-20, 200, ScreenWidth/2.0-50, 50);
    
    addgroupbutton1.layer.masksToBounds = YES;
    addgroupbutton1.layer.cornerRadius = 6.0;
    addgroupbutton1.layer.borderWidth = 1.0;
    addgroupbutton1.layer.borderColor = [[UIColor clearColor] CGColor];
    [addgroupbutton1 setTitle:@"朋友圈" forState:UIControlStateNormal];
    [addgroupbutton1 setTitleColor:KGrayColor forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    addgroupbutton1.titleLabel.font=[UIFont systemFontOfSize:19.0];
    [addgroupbutton1 addTarget:self action:@selector(addgroupbuttontaction1) forControlEvents:UIControlEventTouchUpInside];
   // addgroupbutton1.backgroundColor=KlightOrangeColor;
    [self.view addSubview:addgroupbutton1];

    
    
    
    
    
    

}
-(void)addgroupbuttontaction{
     [MobClick event:@"center_invitation"];
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    
    [HUD showInView:self.view];
    [HUD dismissAfterDelay:10.0];
    
    
    [DocTeamDataService getBarCodeShareinfoblock:^(id respdic) {
        
        NSDictionary *datadic=(NSDictionary *)respdic;
        
        
        UIImageView *imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0/2.0-80/2.0, 150, 80, 80)];
        imagev1.layer.masksToBounds=YES;
        imagev1.layer.cornerRadius =0.0;
        imagev1.layer.borderColor = [UIColor clearColor].CGColor;
        imagev1.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imagev1.alpha=0.0;
        [self.view addSubview:imagev1];

        
        NSString *urlstr=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]];
        
        NSLog(@"%@",urlstr);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        
        [imagev1 setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:kPlaceholderimage] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [HUD dismiss];
            [UMSocialData defaultData].extConfig.wechatSessionData.url = [datadic objectForKey:@"url"];
            [UMSocialData defaultData].extConfig.wechatSessionData.title = [datadic objectForKey:@"title"];
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
            
            
            
            [imagev1 removeFromSuperview];
            
            
            UMSocialUrlResource *resource=[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeWeb url:[datadic objectForKey:@"url"]];
            
            
            
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:[datadic objectForKey:@"text"] image:image location:nil urlResource:resource presentedController:self completion:^(UMSocialResponseEntity * response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    //                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                    //                [alertView show];
                    
                } else if(response.responseCode != UMSResponseCodeCancel) {
                    
                    //                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                    //                [alertView show];
                }
            }];
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            [HUD dismiss];
            NSLog(@"haha %@",error);
        }];
        
    }];

}

-(void)addgroupbuttontaction1{
    
    
    
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    
    [HUD showInView:self.view];
    [HUD dismissAfterDelay:10.0];
    
    
    [DocTeamDataService getBarCodeShareinfoblock:^(id respdic) {
        [MobClick event:@"center_invitation"];
        NSDictionary *datadic=(NSDictionary *)respdic;
        
        
        UIImageView *imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0+ScreenWidth/2.0/2.0-80/2.0, 150, 80, 80)];
        imagev1.layer.masksToBounds=YES;
        imagev1.layer.cornerRadius =0.0;
        imagev1.layer.borderColor = [UIColor clearColor].CGColor;
        imagev1.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imagev1.alpha=0.0;
        [self.view addSubview:imagev1];
        
        NSString *urlstr=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]];
        
        NSLog(@"%@",urlstr);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        
        [imagev1 setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:kPlaceholderimage] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [HUD dismiss];
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = [datadic objectForKey:@"url"];
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = [datadic objectForKey:@"title"];
            
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
            
            [imagev1 removeFromSuperview];
            
            
            UMSocialUrlResource *resource=[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeWeb url:[datadic objectForKey:@"url"]];
            
            
            
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:[datadic objectForKey:@"text"] image:image location:nil urlResource:resource presentedController:self completion:^(UMSocialResponseEntity * response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    //                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                    //                [alertView show];
                    
                } else if(response.responseCode != UMSResponseCodeCancel) {
                    
                    //                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                    //                [alertView show];
                }
            }];
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            [HUD dismiss];
            NSLog(@"haha %@",error);
        }];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden=YES;
}


@end
