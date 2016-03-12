//
//  AddDoctorViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "AddDoctorViewController.h"
#import "InvitefriendsViewController.h"
#import "ViewController.h"
#import "Masonry.h"
#import "Scan_VC.h"
#import "QRCodeGenerator.h"
#import "ContactManagerViewController.h"
#import "InviteDoctorViewController.h"

#import "UIImageView+AFNetworking.h"
#import "UIKit+AFNetworking.h"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

@interface AddDoctorViewController (){
    NavBarView *mybarview;
    UITextField *code1tf;
     NSTimer*_timer;
}
@property(nonatomic,strong)UIButton*scanBtn;
@property(nonatomic,strong)UITextField*textField;
@property(nonatomic,strong)UIButton*creatBtn;
@property(nonatomic,strong)UIImageView*outImageView;

@end

@implementation AddDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(barcoderesult:) name:@"barcoderesult" object:nil];
    
    self.view.backgroundColor=KBackgroundColor;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight-44+49) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    
    self.tableView.backgroundColor=KBackgroundColor;

    
    
    
    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=[NSString stringWithFormat:@"%@",@"添加医生"];
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
    // Do any additional setup after loading the view.
}
-(void)barcoderesult:(NSNotification *)sender{
    NSString *resultstr=(NSString *)sender.object;
    NSLog(@"%@",resultstr);
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:5];
    

    [UserDataService getDocInfoWithDocId:resultstr block:^(id respdic) {
        
        NSDictionary *dic=(NSDictionary *)respdic;
        NSLog(@"%@",respdic);
        
        
        
        
        [DocTeamDataService invitedoctorWithdocID:[dic objectForKey:@"id"] teamId:self.docteamid block:^(id respdic1) {
            [hud dismiss];
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"结果" message:@"邀请已发送" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            NSLog(@"%@",respdic1);
        }];
        
        
        
        
        
       
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isneedTimeLine) {
        return 4;
    } else {
        return 3;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        if (self.isfromPersonCenter) {
            return 0.0;
        }else{
            return 50;
        }
       
    }else if (indexPath.row==1) {
        return 35;
    }else if (indexPath.row==2) {
        return 50;
    }else if (indexPath.row==3) {
        return 50;
    }else if (indexPath.row==4) {
        return 80;
    }else{
        return 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myviewcell"];
    }
    
    if (indexPath.row==0) {
        if (self.isfromPersonCenter) {
            
        }else{
        code1tf=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth-20, 40)];
        code1tf.delegate=self;
        code1tf.placeholder=@"🔍 输入姓名添加医生";
        code1tf.layer.masksToBounds = YES;
        code1tf.layer.cornerRadius =0.0;
        code1tf.layer.borderWidth = 0.0;
        
        code1tf.keyboardType=UIKeyboardTypeNumberPad;
        code1tf.tintColor=KlightOrangeColor;
        KtfAddpaddingView(code1tf);
        code1tf.userInteractionEnabled=NO;
        code1tf.layer.borderColor = [kimiColor(232, 232, 233, 1) CGColor];
        [self.view addSubview:code1tf];
        
        //[code1tf addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 59, ScreenWidth-30, 1) withimage:nil withbgcolor:KLineColor]];
        code1tf.leftViewMode = UITextFieldViewModeAlways;
        //code1tf.leftView.bounds=CGRectMake(0, 0, 40, 25);
            [cell addSubview:code1tf];
        }
    }else if (indexPath.row==1) {
        cell.backgroundColor=KBackgroundColor;
        
        UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,ScreenWidth, 35)];
        detaillabel.text=@"医生还没有橙子号？立即邀请医生加入医生诊所";
      
        detaillabel.textColor=KtextGrayColor;
        detaillabel.numberOfLines=1;
        detaillabel.textAlignment=NSTextAlignmentLeft;
        detaillabel.font=[UIFont systemFontOfSize:15.0];
        
        detaillabel.userInteractionEnabled=NO;
        [cell addSubview:detaillabel];
        

    }else if (indexPath.row==2) {
        
       
        //=[[UIImageView alloc]init];
        
        
        
        //   imagev.frame=CGRectMake(10, 8, 44, 44);
        
       
        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50/2.0-25/2.0, 27, 24)];
        imagev.clipsToBounds=YES;
        
        imagev.layer.masksToBounds=YES;
        imagev.layer.cornerRadius =0.0;
        imagev.layer.borderColor = [UIColor clearColor].CGColor;
        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:@"wechat_56px"]];
        [cell addSubview:imagev];
        
        UILabel *label=[[UILabel alloc]init];
        
        
        label.frame=CGRectMake(45, 10, 90, 30);
    
        label.textColor=KBlackColor;
        label.text=@"微信好友";
        label.textAlignment=NSTextAlignmentLeft;
        label.font=[UIFont systemFontOfSize:16.0];
        label.backgroundColor=[UIColor clearColor];
        [cell addSubview:label];

        
      
//        UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 15,ScreenWidth, 30)];
//        detaillabel.text=[NSString stringWithFormat:@"%@",@"扫一扫添加医生"];
//        detaillabel.textColor=KBlackColor;
//        detaillabel.numberOfLines=1;
//        detaillabel.textAlignment=NSTextAlignmentLeft;
//        detaillabel.font=[UIFont systemFontOfSize:15.0];
//        
//        detaillabel.userInteractionEnabled=NO;
//        [cell addSubview:detaillabel];
//          cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
      // [cell addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(15, 59, ScreenWidth-15, 1) withimage:nil withbgcolor:KLightLineColor]];
        
    }else if (indexPath.row==3) {
//        UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 15,ScreenWidth, 30)];
//        detaillabel.text=[NSString stringWithFormat:@"%@",@"从手机通讯录导入"];
//        detaillabel.textColor=KBlackColor;
//        detaillabel.numberOfLines=1;
//        detaillabel.textAlignment=NSTextAlignmentLeft;
//        detaillabel.font=[UIFont systemFontOfSize:15.0];
//        
//        detaillabel.userInteractionEnabled=NO;
//        [cell addSubview:detaillabel];
//          cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50/2.0-26/2.0, 26, 26)];
        imagev.clipsToBounds=YES;
        
        imagev.layer.masksToBounds=YES;
        imagev.layer.cornerRadius =0.0;
        imagev.layer.borderColor = [UIColor clearColor].CGColor;
        imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        // imagev.image=[UIImage imageNamed:@"KAKA"];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:@"monent_56px"]];
        [cell addSubview:imagev];
        
        UILabel *label=[[UILabel alloc]init];
        
        
        label.frame=CGRectMake(45, 10, 90, 30);
        label.text=@"微信朋友圈";
        label.textColor=KBlackColor;
        label.textAlignment=NSTextAlignmentLeft;
        label.font=[UIFont systemFontOfSize:16.0];
        label.backgroundColor=[UIColor clearColor];
        [cell addSubview:label];
        
        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x, 0, ScreenWidth-label.frame.origin.x, 0.7)];
        linev.backgroundColor=KLineColor;
        [cell addSubview:linev];


        
    }else if (indexPath.row==4) {
//         cell.backgroundColor=KBackgroundColor;
//        UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 25,ScreenWidth, 30)];
//        detaillabel.text=[NSString stringWithFormat:@"%@",@"医生还没橙子号吗？"];
//        detaillabel.textColor=KBlackColor;
//        detaillabel.numberOfLines=1;
//        detaillabel.textAlignment=NSTextAlignmentLeft;
//        detaillabel.font=[UIFont systemFontOfSize:15.0];
//        
//        detaillabel.userInteractionEnabled=NO;
//        [cell addSubview:detaillabel];

        
    }else if (indexPath.row==5) {
//        UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 15,ScreenWidth, 30)];
//        detaillabel.text=[NSString stringWithFormat:@"%@",@"邀请医生加入橙医生诊所"];
//        detaillabel.textColor=KBlackColor;
//        detaillabel.numberOfLines=1;
//        detaillabel.textAlignment=NSTextAlignmentLeft;
//        detaillabel.font=[UIFont systemFontOfSize:15.0];
//        
//        detaillabel.userInteractionEnabled=NO;
//        [cell addSubview:detaillabel];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
//        InvitefriendsViewController *invitefriendsvc=[[InvitefriendsViewController alloc]init];
//        invitefriendsvc.needsearch=YES;
//        invitefriendsvc.title=@"Invite friends";
//        [self.navigationController pushViewController:invitefriendsvc animated:YES];
        ContactManagerViewController *editnamevc=[[ContactManagerViewController alloc]init];
        //editnamevc.isrootvc=NO;
        editnamevc.isaddpatient=NO;
        editnamevc.hideRbtn=YES;
        editnamevc.docteamid=self.docteamid;
        [self.navigationController pushViewController:editnamevc animated:YES];

    }else if (indexPath.row==1) {
        
    }else if (indexPath.row==2) {
        
        
        [self addgroupbuttontaction];
        
        
        
        
        
        
        
        
        
        
        
//        Scan_VC*vc=[[Scan_VC alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==3) {
        
        
         [self addgroupbuttontaction1];
        
        
        
        
        
        
//        InvitefriendsViewController *invitefriendsvc=[[InvitefriendsViewController alloc]init];
//        invitefriendsvc.title=@"Invite friends";
//        [self.navigationController pushViewController:invitefriendsvc animated:YES];
    }else if (indexPath.row==4) {
        
        
    }else if (indexPath.row==5) {
        InviteDoctorViewController *invitefriendsvc=[[InviteDoctorViewController alloc]init];
       // invitefriendsvc.title=@"Invite friends";
        [self.navigationController pushViewController:invitefriendsvc animated:YES];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}


-(void)sentmark:(NSString *)markstring withType:(NSInteger)type theTouch:(CGPoint)hellotouchPoint{
    
    
}

-(void)initcode{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"原生二维码扫描-支付宝效果";
    /**
     *  ios7之前我们实现二维码扫描一般是借助第三方来实现，但是在ios7之后系统自己提供二维码扫面的方法，而且用原生的方法性能要比第三方的要好很多，今天就写个小的demo来介绍一下系统的原生二维码扫描实现的过程
     *  部分代码借鉴高少东的支付宝开源项目做了一下整理和优化
     *  二维码参考样式无非就是支付宝和微信两大巨头的样式，今天仿写一下支付宝的二维码扫描
     *  顺便熟悉一下 masonry
     *
     */
    //1.
    _scanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_scanBtn setTitle:@"scan" forState:UIControlStateNormal];
    [_scanBtn setBackgroundColor:[UIColor orangeColor]];
    [_scanBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_scanBtn];
    //2.
    _creatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_creatBtn setTitle:@"create" forState:UIControlStateNormal];
    [_creatBtn setBackgroundColor:[UIColor orangeColor]];
    [_creatBtn addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_creatBtn];
    //3.
    _outImageView=[[UIImageView alloc]init];
    _outImageView.layer.borderWidth=2.0f;
    _outImageView.layer.borderColor=[UIColor redColor].CGColor;
    _outImageView.userInteractionEnabled=YES;
    UIImage *image=[UIImage imageNamed:@"6824500_006_thumb.jpg"];
    UIImage*tempImage=[QRCodeGenerator qrImageForString:@"ssssss" imageSize:360 Topimg:image withColor:RandomColor];
    _outImageView.image=tempImage;
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [_outImageView addGestureRecognizer:longPress];
    [self.view addSubview:_outImageView];
    //4.
    _textField = [[UITextField alloc] init];
    _textField.placeholder =@"  请输入二维码内容";
    _textField.delegate = self;
    _textField.layer.masksToBounds = YES;
    _textField.returnKeyType=UIReturnKeyDefault;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = [UIFont boldSystemFontOfSize:15.0];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textField];
    
    //5.定时器
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(create) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    

}
#pragma mark-> 布局
-(void)viewDidLayoutSubviews{
    
    __weak __typeof(self)weakSelf  = self;
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(100);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(80);
        
    }];
    
    [_scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(weakSelf.textField.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weakSelf.outImageView.mas_top).offset(-10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(weakSelf.creatBtn.mas_left).offset(-10);
        make.height.mas_equalTo(80);
    }];
    
    [_creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.bottom.mas_equalTo(weakSelf.scanBtn);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(weakSelf.scanBtn.mas_right).offset(10);
    }];
    
    [_outImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(weakSelf.creatBtn.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
        
        
    }];
    
    
}
#pragma mark-> 二维码扫描
-(void)scan{
    
    Scan_VC*vc=[[Scan_VC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark-> 二维码生成
-(void)create{
    
    UIImage *image=[UIImage imageNamed:@"6824500_006_thumb.jpg"];
    NSString*tempStr;
    if(self.textField.text.length==0){
        
        tempStr=@"ddddddddd";
        
    }else{
        
        tempStr=self.textField.text;
        
    }
    UIImage*tempImage=[QRCodeGenerator qrImageForString:tempStr imageSize:360 Topimg:image withColor:RandomColor];
    
    _outImageView.image=tempImage;
    
}

#pragma mark-> 长按识别二维码
-(void)dealLongPress:(UIGestureRecognizer*)gesture{
    
    if(gesture.state==UIGestureRecognizerStateBegan){
        
        _timer.fireDate=[NSDate distantFuture];
        
        UIImageView*tempImageView=(UIImageView*)gesture.view;
        if(tempImageView.image){
            //1. 初始化扫描仪，设置设别类型和识别质量
            CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
            //2. 扫描获取的特征组
            NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:tempImageView.image.CGImage]];
            //3. 获取扫描结果
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        
    }else if (gesture.state==UIGestureRecognizerStateEnded){
        
        
        _timer.fireDate=[NSDate distantPast];
    }
    
    
}
#pragma mark->textFiel delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _timer.fireDate=[NSDate distantFuture];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    _timer.fireDate=[NSDate distantPast];
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


@end
