//
//  AddPatientViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "AddPatientViewController.h"
#import "AddMyGroupViewController.h"
#import "itemdetailbutton.h"
//#import "UIImageView+AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface AddPatientViewController (){
    NavBarView *mybarview;
    itemdetailbutton *oldbutton;
    UIImageView *headpimagev;
    UIImageView *codeimagev;
    BOOL isphonenum;
    UIView *contentbgv;
}

@end

@implementation AddPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=KBlackColor;
    
    isphonenum=NO;
    
    
    
    
    
    
    
    
    
    
    
    
    
    contentbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-kWidthgetFloat(576)/2.0, 30+ScreenHeight/2.0-kHeightgetFloat(744)/2.0, kWidthgetFloat(576), kHeightgetFloat(744))];
    [self.view addSubview:contentbgv];
    [self initaddpatient];
    
    
    
    
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"添加患者";
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
    // Do any additional setup after loading the view.
    
        itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
        sentbutton.frame=CGRectMake(0, 0, kWidthgetFloat(576)/2.0, kHeightgetFloat(88));
        [sentbutton setTitle:@"扫一扫" forState:UIControlStateNormal];
        sentbutton.tag=100;
        
        [sentbutton setTitleColor:KBlackColor forState:UIControlStateNormal];
        [sentbutton setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
        
        [sentbutton addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
        sentbutton.backgroundColor=[UIColor whiteColor];
        [contentbgv addSubview:sentbutton];
        
        sentbutton.selected=YES;
        oldbutton=sentbutton;
        sentbutton.titleLabel.font=[UIFont systemFontOfSize:18.0];
     
    
    
    
    
    
  
        itemdetailbutton *sentbutton1=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
        sentbutton1.frame=CGRectMake(kWidthgetFloat(576)/2.0, 0, kWidthgetFloat(576)/2.0, kHeightgetFloat(88));
        [sentbutton1 setTitle:@"手机号" forState:UIControlStateNormal];
        sentbutton1.tag=101;
        sentbutton1.backgroundColor=KLineColor;
        [sentbutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
        [sentbutton1 setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
        
        [sentbutton1 addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
       // sentbutton1.backgroundColor=[UIColor whiteColor];
        [contentbgv addSubview:sentbutton1];
        
        
        
        sentbutton1.titleLabel.font=[UIFont systemFontOfSize:18.0];
    
    self.dataarr=[[NSMutableArray alloc]init];
    
}
-(void)headaction:(itemdetailbutton *)button{
    button.selected=YES;
    button.backgroundColor=[UIColor whiteColor];
    if (button.tag==oldbutton.tag) {
        
    } else {
        oldbutton.backgroundColor=KLineColor;
        oldbutton.selected=NO;
        oldbutton=button;
    }
    if (button.tag==100) {
        
        isphonenum=NO;
        [self initaddpatient];
        
    } else {
        isphonenum=YES;
        [self initaddpatient];
        
        
    }
    
}

-(void)initaddpatient{
    if (isphonenum) {
        [self setupphoneview];
    } else {
        [self setupcodeview];
    }
    
}


-(void)setupcodeview{
    
    for (UIView *subv in contentbgv.subviews) {
        if (![subv isKindOfClass:[itemdetailbutton class]]) {
            [subv removeFromSuperview];
        }
        
    }
    
    
    
    
    
    
    headpimagev=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(60), kHeightgetFloat(88+16), kWidthgetFloat(96), kHeightgetFloat(96))];
    [headpimagev sd_setImageWithURL:[NSURL URLWithString:KGetDefaultstr(@"icon-url")] placeholderImage:[UIImage imageNamed:@"loadbg_colour"]];
    
    
    headpimagev.clipsToBounds=YES;
    headpimagev.layer.masksToBounds=YES;
    
    headpimagev.layer.cornerRadius =kWidthgetFloat(96)/2.0;
    
    headpimagev.layer.borderWidth=1.0;
    
    headpimagev.layer.borderColor = KLineColor.CGColor;
    
    headpimagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
    [contentbgv addSubview:headpimagev];
    
    
    
    NSString *namestr=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"nick-name")];
    
    
    UIFont *strfont=[UIFont boldSystemFontOfSize:18.0];
    
    CGRect namestrsize=KStringwSize(namestr, kHeightgetFloat(48), strfont);
    
    
    
    UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(180),kHeightgetFloat((8+44+5)*2), namestrsize.size.width, kHeightgetFloat(48))];
    namelabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"nick-name")];
    namelabel.textColor=[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.0];
    namelabel.numberOfLines=1;
    namelabel.textAlignment=NSTextAlignmentLeft;
    namelabel.font=[UIFont boldSystemFontOfSize:18.0];
   // [namelabel sizeToFit];
    namelabel.userInteractionEnabled=NO;
    [contentbgv addSubview:namelabel];
    
    
    
    
    
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(namelabel.frame.origin.x+namelabel.frame.size.width+10, kHeightgetFloat((8+44+9)*2)+3,kWidthgetFloat(160), kHeightgetFloat(48))];
    titlelabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"usertitle")];
    titlelabel.textColor=kimiColor(102, 102, 102, 1.0);
    titlelabel.numberOfLines=1;
    titlelabel.font=[UIFont systemFontOfSize:13.0];
    [titlelabel sizeToFit];
    titlelabel.userInteractionEnabled=NO;
    [contentbgv addSubview:titlelabel];
    
    UILabel *schoollabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(180),kWidthgetFloat((8+44+48-24)*2) ,kWidthgetFloat(300), kHeightgetFloat(48))];
    schoollabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"userhospital")];
    schoollabel.textColor=[UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0];
    schoollabel.numberOfLines=1;
    schoollabel.font=[UIFont systemFontOfSize:15.0];
   // [schoollabel sizeToFit];
    schoollabel.userInteractionEnabled=NO;
    [contentbgv addSubview:schoollabel];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    codeimagev=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(576)/2.0-kWidthgetFloat(322)/2.0,kHeightgetFloat((8+44+48-24+24+12)*2) , kWidthgetFloat(322), kHeightgetFloat(322))];
    NSString *urlstr=[NSString stringWithFormat:@"%@public/doctor/qrcode?doctor_id=%@",k_baseurl,KGetDefaultstr(@"userid")];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [codeimagev setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"loadbg_colour"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        codeimagev.image=image;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        NSLog(@"haha %@",error);
    }];

  
    
    [contentbgv addSubview:codeimagev];
    
    
    
    
    
//    
//    UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(288/2.0-60, 372-105, 60, 30)];
//    masklabel.text=[NSString stringWithFormat:@"%@",@"橙子号"];
//    masklabel.textColor=[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.0];
//    masklabel.numberOfLines=1;
//    masklabel.textAlignment=NSTextAlignmentRight;
//    masklabel.font=[UIFont systemFontOfSize:18.0];
//    
//    masklabel.userInteractionEnabled=NO;
//    [contentbgv addSubview:masklabel];
//    
//    UILabel *numberlabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(576)/2.0, kHeightgetFloat((372-105)*2) ,kWidthgetFloat(200), kHeightgetFloat(60))];
//    numberlabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"usercheng_num")];
//    numberlabel.textColor=KlightOrangeColor;
//    numberlabel.numberOfLines=1;
//    numberlabel.font=[UIFont systemFontOfSize:18.0];
//    
//    numberlabel.userInteractionEnabled=NO;
//    [contentbgv addSubview:numberlabel];
    
    
    UILabel *desclabel=[[UILabel alloc]init];
    desclabel.text=@" 微信扫一扫上面的二维码\n关注我的橙医生账号";
    desclabel.frame=CGRectMake(kWidthgetFloat(576)/2.0-kWidthgetFloat(322)/2.0, kHeightgetFloat((372-90)*2),kWidthgetFloat(322), kHeightgetFloat(60));
    
    desclabel.textAlignment=NSTextAlignmentCenter;
    desclabel.textColor=kimiColor(153, 153, 153, 1);
    desclabel.font=[UIFont systemFontOfSize:14.0];
    desclabel.backgroundColor=[UIColor clearColor];
    desclabel.numberOfLines=0;
    
    [desclabel setLineBreakMode: UILineBreakModeCharacterWrap];
    
    
    [desclabel sizeToFit];

    desclabel.center=CGPointMake(kWidthgetFloat(576)/2.0, kHeightgetFloat((372-90)*2)+desclabel.frame.size.height/2.0);
//    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 372-80,288, 30)];
//    detaillabel.text=[NSString stringWithFormat:@"%@",@"微信扫一扫上面的二维码\n关注我的橙医生账号"];
//    detaillabel.textColor=[UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0];
//    detaillabel.numberOfLines=0;
//    detaillabel.textAlignment=NSTextAlignmentCenter;
//    detaillabel.font=[UIFont systemFontOfSize:12.0];
//    
//    detaillabel.userInteractionEnabled=NO;
//    [detaillabel sizeToFit];
    [contentbgv addSubview:desclabel];
    
    
    
    
//    
//    UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(10, kHeightgetFloat(88)/2.0-22/2.0, 27, 22)];
//    imagev.clipsToBounds=YES;
//    
//    imagev.layer.masksToBounds=YES;
//    imagev.layer.cornerRadius =0.0;
//    imagev.layer.borderColor = [UIColor clearColor].CGColor;
//    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    
//     imagev.image=[UIImage imageNamed:@"wechat_56px"];
//    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    //[imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:@"wechat_56px3x"]];
    

    
    itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
    sentbutton.frame=CGRectMake(0, kHeightgetFloat(744)-kHeightgetFloat(88), kWidthgetFloat(576)/2.0, kHeightgetFloat(88));
    [sentbutton setTitle:@"  微信朋友" forState:UIControlStateNormal];
     [sentbutton setImage:[UIImage imageNamed:@"wechat_56px"] forState:UIControlStateNormal];
    sentbutton.tag=1000;
    sentbutton.backgroundColor=[UIColor whiteColor];
    [sentbutton setTitleColor:KBlackColor forState:UIControlStateNormal];
    // [sentbutton setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
    
    [sentbutton addTarget:self action:@selector(headshareaction:) forControlEvents:UIControlEventTouchUpInside];
    //sentbutton.backgroundColor=[UIColor whiteColor];
    [contentbgv addSubview:sentbutton];
   // [sentbutton addSubview:imagev];
    // sentbutton.selected=YES;
    // oldbutton=sentbutton;
    sentbutton.titleLabel.font=[UIFont systemFontOfSize:18.0];
    
    
    
    
    
    
    
    itemdetailbutton *sentbutton1=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
    sentbutton1.frame=CGRectMake(kWidthgetFloat(576)/2.0, kHeightgetFloat(744)-kHeightgetFloat(88), kWidthgetFloat(576)/2.0, kHeightgetFloat(88));
    [sentbutton1 setTitle:@"  朋友圈" forState:UIControlStateNormal];
    [sentbutton1 setImage:[UIImage imageNamed:@"monent_56px"] forState:UIControlStateNormal];
    sentbutton1.tag=1001;
    sentbutton1.backgroundColor=[UIColor whiteColor];
    [sentbutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
    // [sentbutton1 setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
    
    [sentbutton1 addTarget:self action:@selector(headshareaction:) forControlEvents:UIControlEventTouchUpInside];
    // sentbutton1.backgroundColor=[UIColor whiteColor];
    [contentbgv addSubview:sentbutton1];
    
    
    
    sentbutton1.titleLabel.font=[UIFont systemFontOfSize:18.0];
    
    
    [contentbgv addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(kWidthgetFloat(576)/2.0, kHeightgetFloat(744)-kHeightgetFloat(88), 1, kHeightgetFloat(88)) withimage:nil withbgcolor:KLightLineColor] ];
    
    [contentbgv addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, kWidthgetFloat(744)-kWidthgetFloat(88), kWidthgetFloat(576), 1) withimage:nil withbgcolor:KLightLineColor] ];
    
    
    
    contentbgv.backgroundColor=[UIColor whiteColor];
    contentbgv.layer.cornerRadius=10.0;
    contentbgv.layer.masksToBounds = YES;
    contentbgv.layer.cornerRadius = 10.0;
    contentbgv.layer.borderWidth = 1.0;
    contentbgv.layer.borderColor = [[UIColor clearColor] CGColor];
    
}

-(void)headshareaction:(itemdetailbutton *)button{
        //    button.selected=YES;
        //    button.backgroundColor=[UIColor whiteColor];
        //    if (button.tag==oldbutton.tag) {
        //
        //    } else {
        //        oldbutton.backgroundColor=KLineColor;
        //        oldbutton.selected=NO;
        //        oldbutton=button;
        //    }
        if (button.tag==1000) {
            //微信好友
            //        isphonenum=NO;
            //        [self initaddpatient];
            
            
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
            
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:10.0];
            
            
            [PatientDataService getInvitePatientsShareInfoblock:^(id respdic) {
                
                NSDictionary *datadic=(NSDictionary *)respdic;
                
                
                UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
                imagev.center=contentbgv.center;
                [self.view addSubview:imagev];
                
                NSString *urlstr=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]];
                
                NSLog(@"%@",urlstr);
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
                
                [imagev setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:kPlaceholderimage] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    [HUD dismiss];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = [datadic objectForKey:@"url"];
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = [datadic objectForKey:@"title"];
                    
                    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
                    
                    
                    
                    [imagev removeFromSuperview];
                    
                    
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
            
            
            
        } else {
            JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
            
            [HUD showInView:self.view];
            [HUD dismissAfterDelay:10.0];
            
            
           [PatientDataService getInvitePatientsShareInfoblock:^(id respdic) {
                
                NSDictionary *datadic=(NSDictionary *)respdic;
                
                
                UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
                imagev.center=contentbgv.center;
                [self.view addSubview:imagev];
                
                NSString *urlstr=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]];
                
                NSLog(@"%@",urlstr);
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
                
                [imagev setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:kPlaceholderimage] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    [HUD dismiss];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [datadic objectForKey:@"url"];
                    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [datadic objectForKey:@"title"];
                    
                    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
                    
                    
                    
                    [imagev removeFromSuperview];
                    
                    
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
}
    



-(void)setupphoneview{
    
    for (UIView *subv in contentbgv.subviews) {
        if (![subv isKindOfClass:[itemdetailbutton class]]) {
             [subv removeFromSuperview];
        }
       
    }
    
    
    UILabel *textf=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(20), kHeightgetFloat(112), kWidthgetFloat(576)-kWidthgetFloat(20)*2, kHeightgetFloat(200))];
    textf.text=[NSString stringWithFormat:@"我是%@医生，我已经在橙医生平台开通线上诊所。邀请您在微信上关注我的线上诊所，微信随时随地便携沟通。",KGetDefaultstr(@"nick-name")];
    textf.font=[UIFont systemFontOfSize:15.0];
    textf.textColor=kimiColor(153, 153, 153, 1.0);
    textf.numberOfLines=0;
    [textf sizeToFit];
    [contentbgv addSubview:textf];
   // textf.backgroundColor=[UIColor yellowColor];

    
    
    
    
    
    
    
    
    
    if (self.dataarr.count==0) {
        
        
        
        
        
        UIButton *addcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        addcontactbutton.frame=CGRectMake(kWidthgetFloat(48), textf.frame.origin.y+textf.frame.size.height+16, kWidthgetFloat(210), kHeightgetFloat(64));
        
                addcontactbutton.layer.masksToBounds = YES;
                addcontactbutton.layer.cornerRadius = 4.0;
                addcontactbutton.layer.borderWidth = 1.0;
                addcontactbutton.layer.borderColor = [kimiColor(148, 213, 91, 1.0) CGColor];
        [addcontactbutton setTitle:@"添加手机号" forState:UIControlStateNormal];
        [addcontactbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addcontactbutton addTarget:self action:@selector(addcontactbuttonaction) forControlEvents:UIControlEventTouchUpInside];
        addcontactbutton.backgroundColor=kimiColor(148, 213, 91, 1.0);
        addcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
        [contentbgv addSubview:addcontactbutton];

        
        
        
        
        
        
        UIButton *getcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        getcontactbutton.frame=CGRectMake(kWidthgetFloat(48)+kWidthgetFloat(210)+kWidthgetFloat(48), textf.frame.origin.y+textf.frame.size.height+16, kWidthgetFloat(210), kHeightgetFloat(64));
        
        getcontactbutton.layer.masksToBounds = YES;
        getcontactbutton.layer.cornerRadius = 4.0;
        getcontactbutton.layer.borderWidth = 1.0;
        getcontactbutton.layer.borderColor = [kimiColor(148, 213, 91, 1.0) CGColor];
        [getcontactbutton setTitle:@"通讯录选择" forState:UIControlStateNormal];
        [getcontactbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [getcontactbutton addTarget:self action:@selector(getcontactaction) forControlEvents:UIControlEventTouchUpInside];
        getcontactbutton.backgroundColor=kimiColor(148, 213, 91, 1.0);
        getcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
        [contentbgv addSubview:getcontactbutton];
        
        
//        self.usernametf=[[UITextField alloc]initWithFrame:CGRectMake(15, 200, 288-30, 60)];
//        self.usernametf.delegate=self;
//        self.usernametf.placeholder=@"手机号码";
//        self.usernametf.layer.masksToBounds = YES;
//        self.usernametf.layer.cornerRadius = 6.0;
//        self.usernametf.layer.borderWidth=0.0;
//        self.usernametf.tintColor=KlightOrangeColor;
//        KtfAddpaddingView(self.usernametf);
//        self.usernametf.keyboardType=UIKeyboardTypeNumberPad;
//       // [self.usernametf.leftView addSubview:pwimgView];
//        self.usernametf.leftViewMode = UITextFieldViewModeAlways;
//        self.usernametf.leftView.bounds=CGRectMake(0, 0, 5, 25);
//        
//        self.usernametf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
//        [contentbgv addSubview:self.usernametf];
//        [self.usernametf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, 288-100, 1) withimage:nil withbgcolor:KlightOrangeColor]];

        
        UIButton *sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        sentcodebutton.frame=CGRectMake(0, kHeightgetFloat(744)-kHeightgetFloat(88), kWidthgetFloat(576), kHeightgetFloat(88));
        
        sentcodebutton.layer.masksToBounds = YES;
        sentcodebutton.layer.cornerRadius = 0.0;
        sentcodebutton.layer.borderWidth = 0.0;
        sentcodebutton.layer.borderColor = [KlightOrangeColor CGColor];
        [sentcodebutton setTitle:@"发送" forState:UIControlStateNormal];
        [sentcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
        sentcodebutton.backgroundColor=KlightOrangeColor;
        sentcodebutton.titleLabel.font=[UIFont systemFontOfSize:18.0];
        [contentbgv addSubview:sentcodebutton];

        
        
        
        
        
        
        
        
        
    }else{
        
              //    if (needsecure) {
        //        textf.secureTextEntry=YES;
        //    }
        //  return textf;
        
        
        UIButton *addcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        addcontactbutton.frame=CGRectMake(kWidthgetFloat(48), textf.frame.origin.y+textf.frame.size.height+16, kWidthgetFloat(210), kHeightgetFloat(64));
        
        addcontactbutton.layer.masksToBounds = YES;
        addcontactbutton.layer.cornerRadius = 4.0;
        addcontactbutton.layer.borderWidth = 1.0;
        addcontactbutton.layer.borderColor = [kimiColor(148, 213, 91, 1.0) CGColor];
        [addcontactbutton setTitle:@"添加手机号" forState:UIControlStateNormal];
        [addcontactbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addcontactbutton addTarget:self action:@selector(addcontactbuttonaction) forControlEvents:UIControlEventTouchUpInside];
        addcontactbutton.backgroundColor=kimiColor(148, 213, 91, 1.0);
        addcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
        [contentbgv addSubview:addcontactbutton];
        
        
        
        
        
        
        
        UIButton *getcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        getcontactbutton.frame=CGRectMake(kWidthgetFloat(48)+kWidthgetFloat(210)+kWidthgetFloat(48), textf.frame.origin.y+textf.frame.size.height+16, kWidthgetFloat(210), kHeightgetFloat(64));
        
        getcontactbutton.layer.masksToBounds = YES;
        getcontactbutton.layer.cornerRadius = 4.0;
        getcontactbutton.layer.borderWidth = 1.0;
        getcontactbutton.layer.borderColor = [kimiColor(148, 213, 91, 1.0) CGColor];
        [getcontactbutton setTitle:@"通讯录选择" forState:UIControlStateNormal];
        [getcontactbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [getcontactbutton addTarget:self action:@selector(getcontactaction) forControlEvents:UIControlEventTouchUpInside];
        getcontactbutton.backgroundColor=kimiColor(148, 213, 91, 1.0);
        getcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
        [contentbgv addSubview:getcontactbutton];
        
        
        //        self.usernametf=[[UITextField alloc]initWithFrame:CGRectMake(15, 200, 288-30, 60)];
        //        self.usernametf.delegate=self;
        //        self.usernametf.placeholder=@"手机号码";
        //        self.usernametf.layer.masksToBounds = YES;
        //        self.usernametf.layer.cornerRadius = 6.0;
        //        self.usernametf.layer.borderWidth=0.0;
        //        self.usernametf.tintColor=KlightOrangeColor;
        //        KtfAddpaddingView(self.usernametf);
        //        self.usernametf.keyboardType=UIKeyboardTypeNumberPad;
        //       // [self.usernametf.leftView addSubview:pwimgView];
        //        self.usernametf.leftViewMode = UITextFieldViewModeAlways;
        //        self.usernametf.leftView.bounds=CGRectMake(0, 0, 5, 25);
        //
        //        self.usernametf.layer.borderColor=[kimiColor(232, 232, 233, 1) CGColor];
        //        [contentbgv addSubview:self.usernametf];
        //        [self.usernametf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, 288-100, 1) withimage:nil withbgcolor:KlightOrangeColor]];
        
        
        UIButton *sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        sentcodebutton.frame=CGRectMake(0, kHeightgetFloat(744)-kHeightgetFloat(88), kWidthgetFloat(576), kHeightgetFloat(88));
        
        sentcodebutton.layer.masksToBounds = YES;
        sentcodebutton.layer.cornerRadius = 0.0;
        sentcodebutton.layer.borderWidth = 0.0;
        sentcodebutton.layer.borderColor = [KlightOrangeColor CGColor];
        [sentcodebutton setTitle:@"发送" forState:UIControlStateNormal];
        [sentcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
        sentcodebutton.backgroundColor=KlightOrangeColor;
        sentcodebutton.titleLabel.font=[UIFont systemFontOfSize:18.0];
        [contentbgv addSubview:sentcodebutton];
        

        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, getcontactbutton.frame.origin.y+getcontactbutton.frame.size.height+kHeightgetFloat(32), kWidthgetFloat(576), kHeightgetFloat(744)-getcontactbutton.frame.origin.y-getcontactbutton.frame.size.height-kHeightgetFloat(32)-kHeightgetFloat(88))];
        
        self.tableView.backgroundColor=[UIColor whiteColor];
        self.tableView.separatorColor=[UIColor clearColor];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
//        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [contentbgv addSubview:self.tableView];
        
//        UIButton *sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        sentcodebutton.frame=CGRectMake(0, 372-44, 288, 44);
//        
//        sentcodebutton.layer.masksToBounds = YES;
//        sentcodebutton.layer.cornerRadius = 0.0;
//        sentcodebutton.layer.borderWidth = 0.0;
//        sentcodebutton.layer.borderColor = [KlightOrangeColor CGColor];
//        [sentcodebutton setTitle:@"发送" forState:UIControlStateNormal];
//        [sentcodebutton addTarget:self action:@selector(getnewCode:) forControlEvents:UIControlEventTouchUpInside];
//        sentcodebutton.backgroundColor=KlightOrangeColor;
//        sentcodebutton.titleLabel.font=[UIFont systemFontOfSize:15.0];
//        [contentbgv addSubview:sentcodebutton];

   
    }
    
    
    
//
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataarr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    for (UIView *sbv in cell.subviews) {
        [sbv removeFromSuperview];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }

  
    NSDictionary *dic=[self.dataarr objectAtIndex:indexPath.row];
    
//    cell.textLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//    cell.detailTextLabel.text=[dic objectForKey:@"telphone"];
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetHeight(cell.bounds)/2.0-30/2.0,kWidthgetFloat(576)-30, 30)];
    detaillabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    detaillabel.textColor=KBlackColor;
    detaillabel.numberOfLines=1;
    
    detaillabel.textAlignment=NSTextAlignmentLeft;
    detaillabel.font=[UIFont systemFontOfSize:16.0];
    //detaillabel.userInteractionEnabled=NO;
    [cell addSubview:detaillabel];
   // cell.layer.cornerRadius=5.0;
  //  cell.layer.borderColor=KBackgroundColor.CGColor;
  //  cell.layer.borderWidth=1.0;
//    cell.backgroundColor=KBackgroundColor;
    
    
    
    UIButton *tagbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    tagbutton.frame=CGRectMake(kWidthgetFloat(576)-65, CGRectGetHeight(cell.bounds)/2.0-25/2.0, 50, 25);
   
    tagbutton.tag=indexPath.row;
    //tagbutton.backgroundColor=KlightOrangeColor;
    tagbutton.layer.borderColor=KLineColor.CGColor;
    tagbutton.layer.borderWidth=0.7;
    tagbutton.layer.cornerRadius=4.0;
    [tagbutton setTitle:@"删除" forState:UIControlStateNormal];
    [tagbutton setTitleColor:KLineColor forState:UIControlStateNormal];
    [tagbutton addTarget:self action:@selector(tagbuttonaction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:tagbutton];

    
    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(15, 43.3, ScreenWidth-15, 0.7)];
    linev.backgroundColor=KLineColor;
    [cell addSubview:linev];
    
    
    return cell;
}
-(void)tagbuttonaction:(UIButton *)button{
  //  self.collectionView remo
    [self.dataarr removeObjectAtIndex:button.tag];
    
    //2.删除操作
    
  //  [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag inSection:0]]];
    if (self.dataarr.count==0) {
        [self setupphoneview];
    }else{
        [self.tableView reloadData];
    }
    
   
    
    
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat{
////    tiemViewController *focusvc=[[tiemViewController alloc]init];
////    
////    [self.navigationController pushViewController:focusvc animated:YES];
//}
-(void)numberbutonaction:(UIButton *)button{
//    tiemViewController *focusvc=[[tiemViewController alloc]init];
//    
//    [self.navigationController pushViewController:focusvc animated:YES];
    
}





-(void)weixinaction{
    
    
    
    
}
-(void)pengyouquanaction{
    
    
}
-(void)buttonaction:(UIButton *)button{
    button.selected=YES;
    button.backgroundColor=[UIColor whiteColor];
    if (oldbutton.tag==button.tag) {
        oldbutton.backgroundColor=[UIColor whiteColor];
        
    }else{
        oldbutton.backgroundColor=[UIColor grayColor];
    }
    oldbutton=button;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.usernametf resignFirstResponder];
    return YES;
}
-(void)getnewCode:(UIButton *)button{
    
    
    [self.usernametf resignFirstResponder];
   
//    if (![self myisPureInt:self.usernametf.text]||self.usernametf.text.length!=11) {
//        [[PublicTools shareInstance]setmyPview:self.view];
//        [[PublicTools shareInstance]creareNotificationUIView:@"请输入手机号"];
//    }else{
        NSLog(@"%@",self.dataarr);
        //
        //        NSString *urlstring=[NSString stringWithFormat:@"public/msisdn/verify?msisdn=%@",code1tf.text];
        //        [[PublicTools shareInstance]GetNetWorkDataWithURLStr:urlstring theReturnBlock:^(id obj) {
        //            if (obj!=nil) {
        
//        [MsisdnDataService getCaptchaCodeWithMsisdn:code1tf.text type:1 block:^(id dic) {
//            [[PublicTools shareInstance]setmyPview:self.view];
//            [[PublicTools shareInstance]creareNotificationUIView:@"验证码已发送"];
//            
//            
//        }];
//
    NSMutableArray *tmparr=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.dataarr) {
        NSString *phonenum=[dic objectForKey:@"telphone"];
        if (phonenum.length>0) {
              [tmparr addObject:phonenum];
        }
      
        
    }
    [PatientDataService InvitePatientsWithMsisdns:tmparr ShareInfoblock:^(id respdic) {
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:@"已发送"];

    }];
        
    
     //   }
    
    
    
    // Do any additional setup after loading the view.
    
    
}
- (BOOL)myisPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
-(void)getcontactaction{
    InvitefriendsViewController *invitefriendsvc=[[InvitefriendsViewController alloc]init];
    invitefriendsvc.delegate=self;
    invitefriendsvc.title=@"Invite friends";
    invitefriendsvc.haveselecteddataArr=self.dataarr;
    [self.navigationController pushViewController:invitefriendsvc animated:YES];
}
-(void)sentselectedcontacts:(NSMutableArray *)contactdataArr{
    self.dataarr=[[NSMutableArray alloc]initWithArray:contactdataArr];
    
    //[self.dataarr removeAllObjects];
    [self setupphoneview];

}
-(void)addwithdic:(NSDictionary *)tagdic{
    [self.dataarr insertObject:tagdic atIndex:0];
    [self setupphoneview];
    [self.tableView reloadData];
    
}
-(void)addcontactbuttonaction{
    AddPhoneNumberViewController *invitefriendsvc=[[AddPhoneNumberViewController alloc]init];
    invitefriendsvc.delegate=self;
    [self.navigationController pushViewController:invitefriendsvc animated:YES];
    
}
@end
