//
//  WebBarCodeViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/2.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "WebBarCodeViewController.h"

#import "AddMyGroupViewController.h"
#import "itemdetailbutton.h"
//#import "UIImageView+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIKit+AFNetworking.h"

#import "AFHTTPRequestOperation.h"

@interface WebBarCodeViewController (){
    NavBarView *mybarview;
    itemdetailbutton *oldbutton;
    UIImageView *headpimagev;
    UIImageView *codeimagev;
    BOOL isphonenum;
    UIView *contentbgv;
}

@end

@implementation WebBarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=KBlackColor;
    
    isphonenum=NO;
    
    
    contentbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-300/2.0, ScreenHeight/2.0-400/2.0, 300, 400)];
    [self.view addSubview:contentbgv];
    [self initaddpatient];
    
    
    
    
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"添加个人患者";
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
    sentbutton.frame=CGRectMake(0, 400-44, 300/2.0, 44);
    [sentbutton setTitle:@"微信朋友" forState:UIControlStateNormal];
     [sentbutton setImage:[UIImage imageNamed:@"wechat_48px"] forState:UIControlStateNormal];
    sentbutton.tag=100;
    sentbutton.backgroundColor=[UIColor whiteColor];
    [sentbutton setTitleColor:KBlackColor forState:UIControlStateNormal];
   // [sentbutton setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
    
    [sentbutton addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
    //sentbutton.backgroundColor=[UIColor whiteColor];
    [contentbgv addSubview:sentbutton];
    
   // sentbutton.selected=YES;
   // oldbutton=sentbutton;
    sentbutton.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
    
    
    
    
    
    
    
    itemdetailbutton *sentbutton1=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
    sentbutton1.frame=CGRectMake(300/2.0, 400-44, 300/2.0, 44);
    [sentbutton1 setTitle:@"朋友圈" forState:UIControlStateNormal];
     [sentbutton1 setImage:[UIImage imageNamed:@"monent_48px"] forState:UIControlStateNormal];
    sentbutton1.tag=101;
    sentbutton1.backgroundColor=[UIColor whiteColor];
    [sentbutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
   // [sentbutton1 setTitleColor:KlightOrangeColor forState:UIControlStateSelected];
    
    [sentbutton1 addTarget:self action:@selector(headaction:) forControlEvents:UIControlEventTouchUpInside];
    // sentbutton1.backgroundColor=[UIColor whiteColor];
    [contentbgv addSubview:sentbutton1];
    
    
    
    sentbutton1.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
    
    
    [contentbgv addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(300/2.0, 400-44, 1, 44) withimage:nil withbgcolor:KLightLineColor] ];
    
    [contentbgv addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 400-44, 300, 1) withimage:nil withbgcolor:KLightLineColor] ];
    
    self.dataarr=[[NSMutableArray alloc]init];
    
}
-(void)headaction:(itemdetailbutton *)button{
//    button.selected=YES;
//    button.backgroundColor=[UIColor whiteColor];
//    if (button.tag==oldbutton.tag) {
//        
//    } else {
//        oldbutton.backgroundColor=KLineColor;
//        oldbutton.selected=NO;
//        oldbutton=button;
//    }
    if (button.tag==100) {
        //微信好友
//        isphonenum=NO;
//        [self initaddpatient];
        
        
        JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
      
        [HUD showInView:self.view];
        [HUD dismissAfterDelay:10.0];

        
        [DocTeamDataService getBarCodeShareinfoblock:^(id respdic) {
           
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
        
        
        [DocTeamDataService getBarCodeShareinfoblock:^(id respdic) {
            
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
    
    
    
    
    
    
    headpimagev=[[UIImageView alloc]initWithFrame:CGRectMake(30, 20, 60, 60)];
    [headpimagev sd_setImageWithURL:[NSURL URLWithString:KGetDefaultstr(@"icon-url")] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    
    
    headpimagev.clipsToBounds=YES;
    headpimagev.layer.masksToBounds=YES;
    
    headpimagev.layer.cornerRadius =30.0;
    
    headpimagev.layer.borderWidth=2.0;
    
    headpimagev.layer.borderColor = KLineColor.CGColor;
    
    headpimagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
    [contentbgv addSubview:headpimagev];
    
    UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 10, 60, 40)];
    namelabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"nick-name")];
    namelabel.textColor=[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.0];
    namelabel.numberOfLines=1;
    namelabel.textAlignment=NSTextAlignmentLeft;
    namelabel.font=[UIFont fontWithName:@"DIN Condensed" size:18.0];
    // [namelabel sizeToFit];
    namelabel.userInteractionEnabled=NO;
    [contentbgv addSubview:namelabel];
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(170, 20,100, 30)];
    titlelabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"usertitle")];
    titlelabel.textColor=[UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0];
    titlelabel.numberOfLines=1;
    titlelabel.font=[UIFont systemFontOfSize:15.0];
   // [titlelabel sizeToFit];
    titlelabel.userInteractionEnabled=NO;
    [contentbgv addSubview:titlelabel];
    
    UILabel *schoollabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 50,170, 30)];
    schoollabel.text=[NSString stringWithFormat:@"@%@",KGetDefaultstr(@"userhospital")];
    schoollabel.textColor=[UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0];
    schoollabel.numberOfLines=1;
    schoollabel.font=[UIFont systemFontOfSize:15.0];
  //  [schoollabel sizeToFit];
    schoollabel.userInteractionEnabled=NO;
    [contentbgv addSubview:schoollabel];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [UIImageView setSharedImageCache:[UIImageView sharedImageCache]];
    
   
    NSString *urlstr=[NSString stringWithFormat:@"%@public/doctor/qrcode?doctor_id=%@",k_baseurl,KGetDefaultstr(@"userid")];
    
   // [self  getredictImageurl:urlstr];
     codeimagev=[[UIImageView alloc]initWithFrame:CGRectMake(300/2.0-100.0, 400/2.0-100.0+20+20-50, 200, 200)];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [codeimagev setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:kPlaceholderimage] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        codeimagev.image=image;
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        NSLog(@"haha %@",error);
    }];
    
    
    [contentbgv addSubview:codeimagev];
    
    
    
    
    
    
    UILabel *masklabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 300, 200, 30)];
    masklabel.text=[NSString stringWithFormat:@"%@",@"微信扫一扫上面的二维码关注我的橙医生账号"];
    masklabel.textColor=KLineColor;
    masklabel.numberOfLines=2;
    masklabel.textAlignment=NSTextAlignmentCenter;
    
    masklabel.font=[UIFont systemFontOfSize:13.0];
    [masklabel sizeToFit];
    masklabel.userInteractionEnabled=NO;
    [contentbgv addSubview:masklabel];
    
//    UILabel *numberlabel=[[UILabel alloc]initWithFrame:CGRectMake(300/2.0, 400-70,100, 30)];
//    numberlabel.text=[NSString stringWithFormat:@"%@",KGetDefaultstr(@"usercheng_num")];
//    numberlabel.textColor=KlightOrangeColor;
//    numberlabel.numberOfLines=1;
//    numberlabel.font=[UIFont systemFontOfSize:18.0];
//    
//    numberlabel.userInteractionEnabled=NO;
//    [contentbgv addSubview:numberlabel];
//    
//    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 400-40,300, 30)];
//    detaillabel.text=[NSString stringWithFormat:@"%@",@""];
//    detaillabel.textColor=[UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0];
//    detaillabel.numberOfLines=1;
//    detaillabel.textAlignment=NSTextAlignmentCenter;
//    detaillabel.font=[UIFont systemFontOfSize:12.0];
//    
//    detaillabel.userInteractionEnabled=NO;
//    [contentbgv addSubview:detaillabel];
    
    contentbgv.backgroundColor=[UIColor whiteColor];
    contentbgv.layer.cornerRadius=10.0;
    contentbgv.layer.masksToBounds = YES;
    contentbgv.layer.cornerRadius = 10.0;
    contentbgv.layer.borderWidth = 1.0;
    contentbgv.layer.borderColor = [[UIColor clearColor] CGColor];
    
}



-(void)setupphoneview{
    
//    for (UIView *subv in contentbgv.subviews) {
//        if (![subv isKindOfClass:[itemdetailbutton class]]) {
//            [subv removeFromSuperview];
//        }
//        
//    }
//    
//    
//    UILabel *textf=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, 300.0-20, 150)];
//    textf.text=@"云端软件平台，采用应用虚拟化技术，集软件搜索、下载、使用、管理、备份等多种功能为一体，为网民搭建软件资源、软件应用和软件服务平台，改善目前软件获取和使用的方式，带给你简单流畅、方便快捷的全新体验。更有人名云端，也有王菲同名歌曲等。";
//    textf.font=[UIFont systemFontOfSize:14.0];
//    textf.textColor=KBlackColor;
//    textf.numberOfLines=0;
//    [textf sizeToFit];
//    [contentbgv addSubview:textf];
//    
//    
//    
//    
//    
//    
//    
//    
    
    
    if (self.dataarr.count==0) {
        
        
        
        
        
//        UIButton *addcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        addcontactbutton.frame=CGRectMake(30, 170, 105, 30);
//        
//        addcontactbutton.layer.masksToBounds = YES;
//        addcontactbutton.layer.cornerRadius = 4.0;
//        addcontactbutton.layer.borderWidth = 1.0;
//        addcontactbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        [addcontactbutton setTitle:@"添加手机号" forState:UIControlStateNormal];
//        [addcontactbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
//        [addcontactbutton addTarget:self action:@selector(addcontactbuttonaction) forControlEvents:UIControlEventTouchUpInside];
//        //getcontactbutton.backgroundColor=KlightOrangeColor;
//        addcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
//        [contentbgv addSubview:addcontactbutton];
//        
//        
//        
//        
//        
//        
//        
//        UIButton *getcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        getcontactbutton.frame=CGRectMake(30*2+105, 170, 105, 30);
//        
//        getcontactbutton.layer.masksToBounds = YES;
//        getcontactbutton.layer.cornerRadius = 4.0;
//        getcontactbutton.layer.borderWidth = 1.0;
//        getcontactbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        [getcontactbutton setTitle:@"通讯录选择" forState:UIControlStateNormal];
//        [getcontactbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
//        [getcontactbutton addTarget:self action:@selector(getcontactaction) forControlEvents:UIControlEventTouchUpInside];
//        //getcontactbutton.backgroundColor=KlightOrangeColor;
//        getcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
//        [contentbgv addSubview:getcontactbutton];
        
        
        //        self.usernametf=[[UITextField alloc]initWithFrame:CGRectMake(15, 200, 300-30, 60)];
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
        //        [self.usernametf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 49, 300-100, 1) withimage:nil withbgcolor:KlightOrangeColor]];
        
        
//        UIButton *sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        sentcodebutton.frame=CGRectMake(0, 400-33, 300, 33);
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
//        
        
        
        
        
        
        
        
        
        
    }else{
        
        //    if (needsecure) {
        //        textf.secureTextEntry=YES;
        //    }
        //  return textf;
        
//        
//        UIButton *addcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        addcontactbutton.frame=CGRectMake(30, 170, 105, 30);
//        
//        addcontactbutton.layer.masksToBounds = YES;
//        addcontactbutton.layer.cornerRadius = 4.0;
//        addcontactbutton.layer.borderWidth = 1.0;
//        addcontactbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        [addcontactbutton setTitle:@"添加手机号" forState:UIControlStateNormal];
//        [addcontactbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
//        [addcontactbutton addTarget:self action:@selector(addcontactbuttonaction) forControlEvents:UIControlEventTouchUpInside];
//        //getcontactbutton.backgroundColor=KlightOrangeColor;
//        addcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
//        [contentbgv addSubview:addcontactbutton];
//        
//        
//        
//        
//        
//        
//        
//        UIButton *getcontactbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        getcontactbutton.frame=CGRectMake(30*2+105, 170, 105, 30);
//        
//        getcontactbutton.layer.masksToBounds = YES;
//        getcontactbutton.layer.cornerRadius = 4.0;
//        getcontactbutton.layer.borderWidth = 1.0;
//        getcontactbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        [getcontactbutton setTitle:@"通讯录选择" forState:UIControlStateNormal];
//        [getcontactbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
//        [getcontactbutton addTarget:self action:@selector(getcontactaction) forControlEvents:UIControlEventTouchUpInside];
//        //getcontactbutton.backgroundColor=KlightOrangeColor;
//        getcontactbutton.titleLabel.font=[UIFont systemFontOfSize:17.0];
//        [contentbgv addSubview:getcontactbutton];
//        
//        
        
        
        
        //        UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
        //        flowLayout.itemSize=CGSizeMake(300, 30);
        //
        //        CGFloat paddingY=1;
        //        CGFloat paddingX=1;
        //        //每个格子的上左下右的间隔
        //        flowLayout.sectionInset=UIEdgeInsetsMake(paddingX, paddingX, paddingY, paddingX);
        //        flowLayout.minimumLineSpacing = paddingY;
        //        flowLayout.minimumInteritemSpacing=paddingX;
//        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 202, 300.0, 400-150-50-33)];
//        
//        self.tableView.backgroundColor=[UIColor whiteColor];
//        self.tableView.separatorColor=[UIColor clearColor];
//        self.tableView.dataSource=self;
//        self.tableView.delegate=self;
//        //        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
//        [contentbgv addSubview:self.tableView];
//        
//        UIButton *sentcodebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//        sentcodebutton.frame=CGRectMake(0, 400-33, 300, 33);
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
    for (UIView *sbv in cell.contentView.subviews) {
        [sbv removeFromSuperview];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    
    NSDictionary *dic=[self.dataarr objectAtIndex:indexPath.row];
    
    //    cell.textLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    //    cell.detailTextLabel.text=[dic objectForKey:@"telphone"];
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0,300-30, 30)];
    detaillabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    detaillabel.textColor=KBlackColor;
    detaillabel.numberOfLines=1;
    
    detaillabel.textAlignment=NSTextAlignmentLeft;
    detaillabel.font=[UIFont systemFontOfSize:15.0];
    //detaillabel.userInteractionEnabled=NO;
    [cell.contentView addSubview:detaillabel];
    // cell.layer.cornerRadius=5.0;
    cell.layer.borderColor=KBackgroundColor.CGColor;
    cell.layer.borderWidth=1.0;
    //    cell.backgroundColor=KBackgroundColor;
    
    
    
    UIButton *tagbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    tagbutton.frame=CGRectMake(300-30, 5, 20, 20);
    
    tagbutton.tag=indexPath.row;
    //tagbutton.backgroundColor=KlightOrangeColor;
    [tagbutton setTitle:@"#" forState:UIControlStateNormal];
    [tagbutton setTitleColor:KLineColor forState:UIControlStateNormal];
    [tagbutton addTarget:self action:@selector(tagbuttonaction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:tagbutton];
    
    
    
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
    
    if (![self myisPureInt:self.usernametf.text]||self.usernametf.text.length!=11) {
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:@"请输入手机号"];
    }else{
        
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
        
        [[PublicTools shareInstance]setmyPview:self.view];
        [[PublicTools shareInstance]creareNotificationUIView:@"已发送"];
        
    }
    
    
    
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
