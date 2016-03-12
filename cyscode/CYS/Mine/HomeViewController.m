//
//  HomeViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/14.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "HomeViewController.h"
#import "LogintocysViewController.h"
#import "CallListViewController.h"
#import "OrderManagerViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDataBaseManager.h"
#import "AddPatientViewController.h"
#import "EditnameViewController.h"

#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "BannerWebViewController.h"

#import "PubilcViewController.h"
#import "DoctorTeamViewController.h"

#import "MyfansViewController.h"
#import "PatientListViewController.h"
#import "MsgListWebViewController.h"


//#define kHeightgetFloat(num) num*ScreenWidth/1136.f

@interface HomeViewController (){
    UIImageView *pimagev;
    NavBarView *mybarview;
    UIView *buttonbgv;
    UIControl *moreControl;
    UILabel *authorlabel;
    UILabel *patientAddlabel;
    BOOL haveshowmorebutton;
    UILabel *newnamelabel;
    UIButton *actionButton;
    UIButton *fansButton;
    UIButton *leftButton;
    UIButton *outcallbtn;
    UIView *redpointview;
    UIView *redpointview1;
    UIButton *odrerbtn;
    UILabel *msglabel1;
    UIButton *myplantOnbutton;
    UIImageView *arrowimagev;
    NSDictionary *docdic;
}
@property (retain, nonatomic) TAPageControl *customStoryboardPageControl;
@property (strong, nonatomic) TAPageControl *customPageControl2;
@property (strong, nonatomic) TAPageControl *customPageControl3;
@property (retain, nonatomic) UIScrollView *scrollView1;

@property (strong, nonatomic) NSArray *imagesData;
@end

@implementation HomeViewController


-(void)viewDidLoad{
    
    
    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadindex:) name:@"reloadindex" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newdatemsg:) name:@"newdatemsg" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newordermsg:) name:@"newordermsg" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newauthermsg:) name:@"newauthermsg" object:nil];
    
//    self.imagesData = @[@"image1.jpg", @"image2.jpg", @"image3.jpg", @"image4.jpg", @"image5.jpg", @"image6.jpg"];
//    self.scrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight/3*1+20)];
//    self.scrollView1.delegate = self;
//    self.scrollView1.pagingEnabled=YES;
//    
//    self.scrollView1.showsHorizontalScrollIndicator=NO;
//    self.scrollView1.showsVerticalScrollIndicator=NO;
//    self.scrollView1.directionalLockEnabled=YES;
//    self.scrollView1.alwaysBounceHorizontal=NO;
//    self.scrollView1.alwaysBounceVertical=NO;
//    self.scrollView1.contentMode=UIViewContentModeScaleToFill;
//    [self.view addSubview:self.scrollView1];
//    
//    [self setupScrollViewImages];
    
//    self.customStoryboardPageControl=[[TAPageControl alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-100/2.0, 64, 100,20)];
//    self.customStoryboardPageControl.delegate=self;
//    self.customStoryboardPageControl.numberOfPages = self.imagesData.count;
   
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // UIEdgeInsets inset   = UIEdgeInsetsMake(0, -15, 0, 0);
    // leftButton.contentEdgeInsets = inset;
    rightButton.frame = CGRectMake(ScreenWidth-35, 28, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
    //[rightButton setTitle:@"+" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:40];
    [rightButton addTarget:self action:@selector(rightbrnaction) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    //    self.navigationItem.rightBarButtonItem = backItem;
    [self.view addSubview:rightButton];
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // UIEdgeInsets inset   = UIEdgeInsetsMake(0, -15, 0, 0);
    // leftButton.contentEdgeInsets = inset;
    leftButton.frame = CGRectMake(5, 25, 32, 35);
    // [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     if ([KGetDefaultstr(@"silence")isEqualToString:@"no"]) {
        // [leftButton setTitle:@"○" forState:UIControlStateNormal];
          [leftButton setImage:[UIImage imageNamed:@"open_news"] forState:UIControlStateNormal];
     }else{
        // [leftButton setTitle:@"🚫" forState:UIControlStateNormal];
          [leftButton setImage:[UIImage imageNamed:@"close_news"] forState:UIControlStateNormal];
         
     }
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:40];
    [leftButton addTarget:self action:@selector(leftbtnaction) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    //    self.navigationItem.rightBarButtonItem = backItem;
    [self.view addSubview:leftButton];

    
    
    
    UIImageView *bannerHolderimagev=[[UIImageView alloc]init];
    bannerHolderimagev.frame=CGRectMake(0, kHeightgetFloat(128)-20, self.view.frame.size.width, kHeightgetFloat(216)+20);
    bannerHolderimagev.image=[UIImage imageNamed:@"loadbg_colour"];
    [self.view addSubview:bannerHolderimagev];
    
    
    [PublicDataService getHomePageBannerblock:^(id respdic) {
        NSArray *tmpdicarr=[respdic objectForKey:@"banners"];
        
        
        
        NSMutableArray *tmparr2=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in tmpdicarr) {
            [tmparr2 addObject:[dic objectForKey:@"image_url"]];
        }
        [bannerHolderimagev removeFromSuperview];
        NSArray *UrlStringArray =[[NSArray alloc]initWithArray:tmparr2];;
        NSLog(@"%@",UrlStringArray);
        
        NSArray *titleArray = [@"午夜寂寞 谁来陪我,唱一首动人的情歌.你问我说 快不快乐,唱情歌越唱越寂寞.谁明白我 想要什么,一瞬间释放的洒脱.灯光闪烁 不必啰嗦,我就是传说中的那个摇摆哥.我是摇摆哥 音乐会让我快乐,我是摇摆哥 我已忘掉了寂寞.我是摇摆哥 音乐会让我洒脱,我们一起唱这摇摆的歌" componentsSeparatedByString:@"."];
        
        
        //显示顺序和数组顺序一致
        //设置图片url数组,和滚动视图位置
        
        //NSLog(@"%f",216/1136.f*ScreenHeight);
        
        DCPicScrollView  *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, kHeightgetFloat(128)-20, self.view.frame.size.width, kHeightgetFloat(216)+20) WithImageUrls:UrlStringArray];
        picView.backgroundColor=KRedColor;
        
        //显示顺序和数组顺序一致
        //设置标题显示文本数组
        
        
        
        picView.titleData = titleArray;
        
        //占位图片,你可以在下载图片失败处修改占位图片
        
        picView.placeImage = [UIImage imageNamed:@"loadbg_colour"];
        
        //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
        
        [picView setImageViewDidTapAtIndex:^(NSInteger index) {
           // printf("第%zd张图片\n",index);
            [MobClick event:@"banner_invitation"];
            NSDictionary *mydic=[tmpdicarr objectAtIndex:index];
            BannerWebViewController *doctorteam=[[BannerWebViewController alloc]init];
            doctorteam.urslstr=[mydic objectForKey:@"link"];
            self.tabBarController.navigationController.navigationBar.hidden=NO;
            [self.tabBarController.navigationController pushViewController:doctorteam animated:YES];

            
            
        }];
        
        //default is 2.0f,如果小于0.5不自动播放
        picView.AutoScrollDelay = 5.0f;
        //    picView.textColor = [UIColor redColor];
        
        [self.view addSubview:picView];
        //[self.view addSubview:self.customStoryboardPageControl];
         [self.view bringSubviewToFront:mybarview];
        [self.view bringSubviewToFront:pimagev];
        [self.view bringSubviewToFront:leftButton];
        [self.view bringSubviewToFront:rightButton];
        
    }];
  
    
    
   
    
    
    
    
//    pimagev=[[UIImageView alloc]initWithFrame:CGRectMake(10, ScreenHeight/3*1-60/2, 60, 60)];
//   [pimagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KGetDefaultstr(@"icon-url")]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//   
//    
//    pimagev.clipsToBounds=YES;
//    pimagev.layer.masksToBounds=YES;
//    
//    pimagev.layer.cornerRadius =30.0;
//    
//    pimagev.layer.borderWidth=1.0;
//    
//    pimagev.layer.borderColor = KlightOrangeColor.CGColor;
//    
//    pimagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    
//    
    
    UIColor *headertextcolor=kimiColor(157, 157, 157, 1.0);
    
//    newnamelabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 5, 80, 40)];
//    newnamelabel.textColor=KBlackColor;
////    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"nick-name"]) {
////        newlabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"nick-name"];
////    }else{
//        newnamelabel.text=KGetDefaultstr(@"nick-name");
//  //  }
//    newnamelabel.font=[UIFont boldSystemFontOfSize:17.0];
//    newnamelabel.textAlignment=NSTextAlignmentLeft;
    
    
    
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, kHeightgetFloat(128+216), ScreenWidth, kHeightgetFloat(88))];
    bgv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgv];
    //[bgv addSubview:newnamelabel];
    
    UIView *bgv1=[[UIView alloc]initWithFrame:CGRectMake(0,  kHeightgetFloat(128+216+88), ScreenWidth, kHeightgetFloat(88))];
    bgv1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgv1];

    actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.tag=1002;
    actionButton.frame=CGRectMake(0, 0, ScreenWidth/2.0, kHeightgetFloat(88));
    actionButton.backgroundColor=[UIColor whiteColor];
    
    [actionButton setTitle:@"患者数 " forState:UIControlStateNormal];
 //  [actionButton setImage:[UIImage imageNamed:@"patient"] forState:UIControlStateNormal];
    actionButton.titleLabel.font=[UIFont systemFontOfSize:17.0];
    [actionButton setTitleColor:KBlackColor forState:UIControlStateNormal];
    [actionButton addTarget:self action:@selector(actionButton) forControlEvents:UIControlEventTouchUpInside];
    [bgv1 addSubview:actionButton];
    
//    
    UIImageView *actionimagev1=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(24),kHeightgetFloat(16), kHeightgetFloat(56), kHeightgetFloat(56))];
    
    actionimagev1.image=[UIImage imageNamed:@"patient"];

    [actionButton addSubview:actionimagev1];

    
    
    
    
    patientAddlabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-35, 0, 30, kHeightgetFloat(88))];
    patientAddlabel.textColor=[UIColor redColor];
    patientAddlabel.textAlignment=NSTextAlignmentRight;
    patientAddlabel.font=[UIFont boldSystemFontOfSize:12.0];
    
    [bgv1 addSubview:patientAddlabel];
    
    
    
    
    
    fansButton=[UIButton buttonWithType:UIButtonTypeCustom];
    fansButton.tag=1002;
    fansButton.frame=CGRectMake(ScreenWidth/2.0, 0, ScreenWidth/2.0, kHeightgetFloat(88));
    fansButton.backgroundColor=[UIColor whiteColor];
    [fansButton setTitle:@"粉丝数 " forState:UIControlStateNormal];
    
 //   [fansButton setImage:[UIImage imageNamed:@"fans"] forState:UIControlStateNormal];
   // [fansButton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
     fansButton.titleLabel.font=[UIFont systemFontOfSize:17.0];
    [fansButton setTitleColor:KBlackColor forState:UIControlStateNormal];
    [fansButton addTarget:self action:@selector(fansbtnaction) forControlEvents:UIControlEventTouchUpInside];
    [bgv1 addSubview:fansButton];
    UIImageView *fansimagev1=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(24),kHeightgetFloat(16), kHeightgetFloat(56), kHeightgetFloat(56))];
    
    fansimagev1.image=[UIImage imageNamed:@"fans"];
    
    [fansButton addSubview:fansimagev1];

    
    
   // [self.view addSubview:pimagev];
    
    
   
    
    
    
    
    
    
    
    
    UIButton *mycaibutton=[[UIManager shareInstance] getbuttonWithtitle:@"" theFrame:CGRectMake(0, 0, ScreenWidth/2.0, kHeightgetFloat(88)) theButtonImage:nil];
    mycaibutton.titleLabel.font=[UIFont boldSystemFontOfSize:11.0];
    [mycaibutton setTitleColor:headertextcolor forState:UIControlStateNormal];
    
    
   // NSString *contentstring=[NSString stringWithFormat:@"%@",@"待出诊 10"];
    
  //  [self setRichNumberWithLabel:mycailabel1 Color:KGreenColor FontSize:9.0];
    
    
    
    
  //  mycailabel1.font=[UIFont boldSystemFontOfSize:13.0];
   
    
    NSString *namestr=KGetDefaultstr(@"nick-name");
    
    
     UIFont *strfont=[UIFont systemFontOfSize:17.0];
    
    CGRect namestrsize=KStringwSize(namestr, 40, strfont);
    newnamelabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, namestrsize.size.width, kHeightgetFloat(88))];
    newnamelabel.textColor=KBlackColor;
    //newnamelabel.backgroundColor=KRedColor;
    //    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"nick-name"]) {
    //        newlabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"nick-name"];
    //    }else{
    newnamelabel.text=KGetDefaultstr(@"nick-name");
    //  }
   
    newnamelabel.font=[UIFont systemFontOfSize:17.0];
    newnamelabel.textAlignment=NSTextAlignmentLeft;

    [mycaibutton addSubview:newnamelabel];
    
    authorlabel=[[UILabel alloc]initWithFrame:CGRectMake(newnamelabel.frame.origin.x+newnamelabel.frame.size.width+5, kHeightgetFloat(88)/2.0-10.0, 50, 20)];
    authorlabel.text=@"";
    authorlabel.textAlignment=NSTextAlignmentCenter;
    authorlabel.font=[UIFont boldSystemFontOfSize:12.0];
    
    authorlabel.textAlignment=NSTextAlignmentCenter;
    
    authorlabel.textColor=[UIColor whiteColor];
    authorlabel.layer.masksToBounds = YES;
    authorlabel.layer.cornerRadius = 10.0;
    authorlabel.layer.borderWidth = 1.0;
    authorlabel.layer.borderColor = [[UIColor clearColor] CGColor];

     [mycaibutton addSubview:authorlabel];
    
    
   // mycaibutton.layer.borderWidth=1.0;
//    mycaibutton.layer.borderColor=kimiColor(168, 176, 117, 1).CGColor;
//    mycaibutton.backgroundColor=kimiColor(168, 176, 117, 1);
   
  //  [mycaibutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mycaibutton addTarget:self action:@selector(mycaibuttonaction) forControlEvents:UIControlEventTouchUpInside];
    [bgv addSubview:mycaibutton];
    
  //
    
    
    myplantOnbutton=[[UIManager shareInstance] getbuttonWithtitle:@"" theFrame:CGRectMake(ScreenWidth/2.0,  0, ScreenWidth/2.0, kHeightgetFloat(88)) theButtonImage:nil];
    myplantOnbutton.titleLabel.font=[UIFont boldSystemFontOfSize:11.0];
     [myplantOnbutton setTitleColor:headertextcolor forState:UIControlStateNormal];
  //  myplantOnbutton.layer.borderWidth=1.0;
//    myplantOnbutton.layer.borderColor=kimiColor(168, 176, 117, 1).CGColor;
//    myplantOnbutton.backgroundColor=kimiColor(168, 176, 117, 1);
   
   // [myplantOnbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    msglabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, kHeightgetFloat(88)/2.0-20.0, ScreenWidth/2.0-23, 40)];
   
    msglabel1.font=[UIFont systemFontOfSize:15.0];
    msglabel1.textAlignment=NSTextAlignmentRight;
    msglabel1.textColor=KlightOrangeColor;
    
    // NSString *contentstring=[NSString stringWithFormat:@"%@",@"待出诊 10"];
    
   // [self setRichNumberWithLabel:myplantlabel1 Color:KRedColor FontSize:9.0];
    
    
    
 //   myplantlabel1.textAlignment=NSTextAlignmentCenter;
 //   myplantlabel1.font=[UIFont boldSystemFontOfSize:13.0];
    [myplantOnbutton addSubview:msglabel1];

    
   //  [self setRichNumberWithLabel:mycailabel1 Color:KRedColor FontSize:15.0];
    
    [myplantOnbutton addTarget:self action:@selector(myplantOnbuttonaction) forControlEvents:UIControlEventTouchUpInside];
    [bgv addSubview:myplantOnbutton];
    
    
    
    UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 0.7)];
    linev.backgroundColor=KLightLineColor;
    [bgv1 addSubview:linev];

    UIView *linev1=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2.0,0.0, 1.0, kHeightgetFloat(88))];
    linev1.backgroundColor=KLightLineColor;
    [bgv1 addSubview:linev1];

    
//    UIView *linev1=[[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-130)/3, 10, 1.2, 20)];
//    linev1.backgroundColor=headertextcolor;
//    [myplantOnbutton addSubview:linev1];
    
//    UIButton *connectOnbutton=[[UIManager shareInstance] getbuttonWithtitle:@"" theFrame:CGRectMake(130+(ScreenWidth-130)/3*2, 5, (ScreenWidth-130)/3, 40) theButtonImage:nil];
//    connectOnbutton.titleLabel.font=[UIFont boldSystemFontOfSize:9.0];
//     [connectOnbutton setTitleColor:headertextcolor forState:UIControlStateNormal];
//    connectOnbutton.layer.borderWidth=1.0;
//    connectOnbutton.layer.borderColor=kimiColor(168, 176, 117, 1).CGColor;
//    connectOnbutton.backgroundColor=kimiColor(168, 176, 117, 1);
    
   // [connectOnbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    
//    UILabel *connecttlabel1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, (ScreenWidth-130)/3, 40)];
//    connecttlabel1.text=@"已完成 38";
//    connecttlabel1.font=[UIFont boldSystemFontOfSize:11.0];
//    connecttlabel1.textAlignment=NSTextAlignmentLeft;
//    // NSString *contentstring=[NSString stringWithFormat:@"%@",@"待出诊 10"];
//    
//    [self setRichNumberWithLabel:connecttlabel1 Color:KlightOrangeColor FontSize:9.0];
//    
//    
//    
//    connecttlabel1.textAlignment=NSTextAlignmentCenter;
// //   connecttlabel1.font=[UIFont boldSystemFontOfSize:13.0];
//    [connectOnbutton addSubview:connecttlabel1];
//    
//    
//    [connectOnbutton addTarget:self action:@selector(connectOnbuttonaction) forControlEvents:UIControlEventTouchUpInside];
//    [bgv addSubview:connectOnbutton];
  
    
    
    NSLog(@"%f",ScreenWidth);
    
    NSLog(@"%f",ScreenHeight);
    
    
    
    
  
    
    
    UIImageView *imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(132), kWidthgetFloat(588), kWidthgetFloat(124), kWidthgetFloat(124))];
    
    imagev1.image=[UIImage imageNamed:@"arrangement"];
    
    imagev1.layer.cornerRadius =kWidthgetFloat(124)/2.0;
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
   
    outcallbtn=[[UIButton alloc]initWithFrame:imagev1.frame];
  
    
    
    [self.view addSubview:imagev1];
    [self.view addSubview:outcallbtn];
    
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(132), imagev1.frame.origin.y+kWidthgetFloat(124)+kHeightgetFloat(16), kWidthgetFloat(124), 20)];
    label1.text=@"出诊安排";
    label1.textColor=KBlackColor;
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:15.0];
    [outcallbtn addTarget:self action:@selector(outcallaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:label1];
    
    
    
    
 
    
    UIImageView *imagev2=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(384), kWidthgetFloat(588), kWidthgetFloat(124), kWidthgetFloat(124))];
    
    imagev2.image=[UIImage imageNamed:@"reservation"];
    imagev2.layer.cornerRadius =kWidthgetFloat(124)/2.0;
    [self.view addSubview:imagev2];
    odrerbtn=[[UIButton alloc]initWithFrame:imagev2.frame];
    
    
    [self.view addSubview:odrerbtn];
    [odrerbtn addTarget:self action:@selector(connectOnbuttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(384), imagev1.frame.origin.y+kWidthgetFloat(124)+kHeightgetFloat(16), kWidthgetFloat(124), 20)];
    label2.text=@"我的预约";
    label2.textColor=KBlackColor;
    label2.textAlignment=NSTextAlignmentCenter;
    label2.font=[UIFont systemFontOfSize:15.0];
    [self.view addSubview:label2];

    
    
    
    
    
   
    UIImageView *imagev3=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(132), kWidthgetFloat(778)+20, kWidthgetFloat(124), kWidthgetFloat(124))];
    
    imagev3.image=[UIImage imageNamed:@"individual_homepage"];
     imagev3.layer.cornerRadius =30.0;
    [self.view addSubview:imagev3];
    
    UIButton *btn3=[[UIButton alloc]initWithFrame:imagev3.frame];
    // btn3.backgroundColor=[UIColor blueColor];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(personalhomepageaction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(132), kWidthgetFloat(778+124+16)+20, kWidthgetFloat(124), 20)];
    label3.text=@"个人主页";
    label3.textColor=KBlackColor;
    label3.textAlignment=NSTextAlignmentCenter;
    label3.font=[UIFont systemFontOfSize:15.0];
    [self.view addSubview:label3];
    
    
    
    
    UIImageView *imagev4=[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(384), kWidthgetFloat(778)+20, kWidthgetFloat(124), kWidthgetFloat(124))];
    
    imagev4.image=[UIImage imageNamed:@"doc_team"];
    imagev4.layer.cornerRadius =30.0;
    UIButton *btn4=[[UIButton alloc]initWithFrame:imagev4.frame];
    
    //btn4.backgroundColor=[UIColor greenColor];
    [self.view addSubview:imagev4];
    [self.view addSubview:btn4];

   
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(384), kWidthgetFloat(778+124+16)+20, kWidthgetFloat(124), 20)];
    label4.text=@"医生团队";
    label4.textColor=KBlackColor;
    label4.textAlignment=NSTextAlignmentCenter;
    label4.font=[UIFont systemFontOfSize:15.0];
    [self.view addSubview:label4];
    
    
    
    
    [btn4 addTarget:self action:@selector(teamaction) forControlEvents:UIControlEventTouchUpInside];
    
 //   [self.view addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(ScreenWidth/2, ScreenHeight/3*1+50+10, 1, ScreenHeight-(ScreenHeight/3*1+50)-70) withimage:nil withbgcolor:KLineColor] ];

   // [self.view addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(50, (ScreenHeight-(ScreenHeight/3*1+50)-50)/2+(ScreenHeight/3*1+50), ScreenWidth-100, 1) withimage:nil withbgcolor:KLineColor] ];
    
    
    
    
    
    
    // TAPageControl from storyboard
    
 
    
    
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"我的诊所";
    mybarview.isRoot=YES;
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview hidebacktbtn];
  //  mybarview.alpha=0.0;
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    [self.view bringSubviewToFront:actionButton];
    [self.view bringSubviewToFront:fansButton];
//    UIView *bgv10=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    bgv10.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:bgv10];
    
  //  [self showlogin];
    // Do any additional setup after loading the view.
      [self setupmoreview];
    
    
    
    
    
    [self loadhomepageInfo];
    
    UIView *borderview=[[UIView alloc]initWithFrame:CGRectMake(0, kHeightgetFloat(520), ScreenWidth, 12)];
    borderview.backgroundColor=kimiColor(240, 239, 245, 1);
    [self.view addSubview:borderview];
    
    UIView *borderview1=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-12-49, ScreenWidth, 12)];
    borderview1.backgroundColor=kimiColor(240, 239, 245, 1);
    [self.view addSubview:borderview1];

    
      
}
-(void)personalhomepageaction{
    [MobClick event:@"personal_homepage"];
    NSLog(@"%@",docdic);
    
    DoctorHomePageWebViewController *dochomewebVC=[[DoctorHomePageWebViewController alloc]init];
    dochomewebVC.urslstr=[NSString stringWithFormat:@"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/doctorHomePage.html?doctor_id=%@",[docdic objectForKey:@"id"]];
    [self.tabBarController.navigationController pushViewController:dochomewebVC animated:YES];
    
}
-(void)newdatemsg:(NSNotification *)sender{
//    
//    [redpointview removeFromSuperview];
//    
//    redpointview=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(outcallbtn.frame)/2-60/2+50, CGRectGetHeight(outcallbtn.frame)/2-60/2-10, 10, 10)];
//    redpointview.backgroundColor=[UIColor clearColor];
//    redpointview.layer.cornerRadius=5.0;
//    [outcallbtn addSubview:redpointview];
//    
//    
//    
//    [NotificationService findUnreadMessagesWithMsgType:@"NOTIF_TYPE_DOCTOR_SET_AVAILABLE_TIME_REMIND" block:^(id respdic) {
//        NSMutableArray *tmparr=[[NSMutableArray alloc]initWithArray:[respdic objectForKey:@"content"]];
//        if (tmparr.count>0) {
//            redpointview.backgroundColor=[UIColor redColor];
//        }
//    }];
    
   

}
-(void)newordermsg:(NSNotification *)sender{
    
    
    
    [self loadordercount];
    
    
  
}

-(void)fansbtnaction{
    [MobClick endEvent:@"fans_num"];
    MyfansViewController *doctorteam=[[MyfansViewController alloc]init];
    //        doctorteam.teamarr=self.teamarr;
    //        doctorteam.participatedTeamarr=self.participatedTeamarr;
    //        doctorteam.invitationarr=self.invitationarr;
    self.navigationController.navigationBar.hidden=NO;
    //
    [self.navigationController pushViewController:doctorteam animated:YES];
    
}
-(void)newauthermsg:(NSNotification *)sender{
    [self loadhomepageInfo];
}

-(void)loadhomepageInfo{
    [UserDataService getSelfInfoWithblock:^(id respdic) {
        NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:respdic];
        docdic=[[NSDictionary alloc]initWithDictionary:respdic];
        NSString *namestr=[dic objectForKey:@"name"];
        
        
        UIFont *strfont=[UIFont systemFontOfSize:17.0];
        
        CGRect namestrsize=KStringwSize(namestr, 40, strfont);
        newnamelabel.frame=CGRectMake(15, 0, namestrsize.size.width, kHeightgetFloat(88));
   
        
        authorlabel.frame=CGRectMake(newnamelabel.frame.origin.x+newnamelabel.frame.size.width+5, kHeightgetFloat(88)/2.0-10.0, 50, 20);
        
        //NSLog(@"%@",dic);
        if ([[dic objectForKey:@"status"] isEqualToString:@"AUDIT_PASSED"]) {
            authorlabel.text=[NSString stringWithFormat:@"%@",@"已认证"];
                authorlabel.backgroundColor=KlightOrangeColor;
        }else{
            authorlabel.text=[NSString stringWithFormat:@"%@",@"未认证"];
                authorlabel.backgroundColor=KlightOrangeColor;
        }
        
        
        newnamelabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        [pimagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        
    }];
    
    [PublicDataService getHomePageInfoblock:^(id respdic) {
        NSDictionary *dic=[[NSDictionary alloc]initWithDictionary:respdic];
        [fansButton setTitle:[NSString stringWithFormat:@" 粉丝数 %@",[dic objectForKey:@"total_fans"]] forState:UIControlStateNormal];
        [actionButton setTitle:[NSString stringWithFormat:@" 患者数 %@",[dic objectForKey:@"total_patient"]] forState:UIControlStateNormal];
       
        if ([[dic objectForKey:@"total_new_patient_today"] integerValue]!=0) {
            patientAddlabel.text=[NSString stringWithFormat:@"+ %@",[dic objectForKey:@"total_new_patient_today"]];

        }
               //        NSLog(@"%@",dic);
        //        NSLog(@"%@",dic);
    }];
    
    
//消息处理
//    [redpointview removeFromSuperview];
//    
//    redpointview=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(outcallbtn.frame)/2-60/2+50, CGRectGetHeight(outcallbtn.frame)/2-60/2-10, 10, 10)];
//    redpointview.backgroundColor=[UIColor clearColor];
//    redpointview.layer.cornerRadius=5.0;
//    [outcallbtn addSubview:redpointview];
    
    
    
//    [NotificationService findUnreadMessagesWithMsgType:@"NOTIF_TYPE_DOCTOR_SET_AVAILABLE_TIME_REMIND" block:^(id respdic) {
//        NSMutableArray *tmparr=[[NSMutableArray alloc]initWithArray:[respdic objectForKey:@"content"]];
//        if (tmparr.count>0) {
//            redpointview.backgroundColor=[UIColor redColor];
//        }
//    }];
    
  
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [self loadordercount];
    
    
}
-(void)loadordercount{
    [OrderDataService getAllOrderCountblock:^(id resparr) {
         [redpointview1 removeFromSuperview];
        NSMutableArray *tmparr=[[NSMutableArray alloc]initWithArray:resparr];
        NSLog(@"%@",tmparr);
        for (NSDictionary *orderdic in tmparr) {
            if ([[orderdic objectForKey:@"count"] integerValue]>0) {
               
                
                redpointview1=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(outcallbtn.frame)/2-60/2+50, CGRectGetHeight(outcallbtn.frame)/2-60/2-10, 8, 8)];
                redpointview1.backgroundColor=[UIColor redColor];
                redpointview1.layer.cornerRadius=4.0;
                [odrerbtn addSubview:redpointview1];
                
                MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;
                tabbarVC.ordermsgcount=@"12";
                
               
                [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
                
                
                
                return;
                
            }else{
                
                
            }
        }
        
    }];
    
    [NotificationService getAllUnreadMessagesCountblock:^(id respdic) {
        
        msglabel1.text=@"";
       [arrowimagev removeFromSuperview];
        
       // NSLog(@"%@",respdic);
        
        NSDictionary *dic=(NSDictionary *)respdic;
        if (![[[dic objectForKey:@"count"] stringValue] isEqualToString:@"0"]) {
            NSLog(@"no new order");
            MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;
            tabbarVC.msgcount=@"12";
            msglabel1.text=[NSString stringWithFormat:@"您有%zd条新消息 ",[[dic objectForKey:@"count"] integerValue]];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
            
            
           
            arrowimagev=[[UIImageView alloc]init];
            //=[[UIImageView alloc]init];
            arrowimagev.frame=CGRectMake(ScreenWidth/2.0-20, kHeightgetFloat(88)/2.0-8.0, 10, 16);
            arrowimagev.image=[UIImage imageNamed:@"arrow"];
            
            // imagev.image=[UIImage imageNamed:@"KAKA"];
            //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
            
            [myplantOnbutton addSubview:arrowimagev];
            [myplantOnbutton bringSubviewToFront:arrowimagev];
        
        }else{
            MainTabBarController *tabbarVC=(MainTabBarController *)self.tabBarController;
            tabbarVC.msgcount=@"0";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];

        }
        
        
    }];


}
-(void)actionButton{
    [MobClick endEvent:@"patient_num"];
    PatientListViewController *addpvc=[[PatientListViewController alloc]init];
    //        doctorteam.teamarr=self.teamarr;
    //        doctorteam.participatedTeamarr=self.participatedTeamarr;
    //        doctorteam.invitationarr=self.invitationarr;
    self.navigationController.navigationBar.hidden=NO;
    //
    [self.navigationController pushViewController:addpvc animated:YES];
}
-(void)outcallaction{
    
    [MobClick event:@"visit"];
    
    if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
        
        OutCallViewController *VC=[[OutCallViewController alloc]init];
        VC.delegate=self;
        NSString *tokenstr=KGetDefaultstr(@"token");
        NSLog(@"%@",tokenstr);
        NSString *encodetoken =[self encodeString:tokenstr];
        
        
        
        NSLog(@"%@",encodetoken);
        
        VC.urslstr=[NSString stringWithFormat:@"http://rm.chengyisheng.com.cn:8080/app/doctor/toVisitArrange.htm?token=%@",encodetoken];
        NSLog(@"%@",VC.urslstr);
        //生产机
        //   VC.urslstr=[NSString stringWithFormat:@"http://wxtest.chengyisheng.com.cn/app/doctor/toVisitArrange.htm?token=%@",encodetoken];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
       
        
    }else{
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"您还没有通认证，请在个人中心申请认证" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"去认证", nil];
        [alertview show];
    }
  
}
-(void)webOutCallDealtdataMethodname:(NSString *)methodname stringval:(NSString *)stringval{
    
//    [redpointview removeFromSuperview];
//    
//    redpointview=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(outcallbtn.frame)/2-60/2+50, CGRectGetHeight(outcallbtn.frame)/2-60/2-10, 10, 10)];
//    redpointview.backgroundColor=[UIColor clearColor];
//    redpointview.layer.cornerRadius=5.0;
//    [outcallbtn addSubview:redpointview];
//    
//    
//    
//    [NotificationService findUnreadMessagesWithMsgType:@"NOTIF_TYPE_DOCTOR_SET_AVAILABLE_TIME_REMIND" block:^(id respdic) {
//        NSMutableArray *tmparr=[[NSMutableArray alloc]initWithArray:[respdic objectForKey:@"content"]];
//        if (tmparr.count>0) {
//            redpointview.backgroundColor=[UIColor redColor];
//        }
//    }];

}
-(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

-(void)reloadindex:(NSNotification *)sender{
//      newnamelabel.text=KGetDefaultstr(@"nick-name");
//     [pimagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KGetDefaultstr(@"icon-url")]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    //if (!KGetDefaultstr(@"usertitle")||!KGetDefaultstr(@"nick-name")||!KGetDefaultstr(@"userhospital")) {
//    PubilcViewController *VC=[[PubilcViewController alloc]init];
//    VC.isreg=YES;
//    VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"authentication.html"];
//    // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
//    [self presentViewController:nav animated:YES completion:nil];
    // }
    [self loadhomepageInfo];

}
-(void)rightbrnaction{
//    AddPatientViewController *invitepatientvc=[[AddPatientViewController alloc]init];
//    invitepatientvc.title=@"添加患者";
//    [self.navigationController pushViewController:invitepatientvc animated:YES];
    
    
    
    if (haveshowmorebutton==YES) {
        [buttonbgv removeFromSuperview];
        [moreControl removeFromSuperview];
        haveshowmorebutton=NO;
        
    } else {
        
        moreControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        moreControl.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [moreControl addTarget:self action:@selector(moreControlaction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarController.view addSubview:moreControl];
        [self.tabBarController.view addSubview:buttonbgv];
        
        
        
        haveshowmorebutton=YES;
    }
    
}
-(void)moreControlaction:(UIControl *)control{
    [control removeFromSuperview];
    [buttonbgv removeFromSuperview];
    
    haveshowmorebutton=NO;
    
}

-(void)leftbtnaction{
    

    if ([KGetDefaultstr(@"silence")isEqualToString:@"yes"]) {
       // [leftButton setTitle:@"○" forState:UIControlStateNormal];
         [leftButton setImage:[UIImage imageNamed:@"open_news"] forState:UIControlStateNormal];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"no" forKey:@"silence"];
        [defaults synchronize];
        [MobClick event:@"set_voice_true"];
         [RCIM sharedRCIM].disableMessageAlertSound=NO;
    }else{
       // [leftButton setTitle:@"🚫" forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"close_news"] forState:UIControlStateNormal];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"yes" forKey:@"silence"];
        [defaults synchronize];
        [MobClick event:@"set_voice_false"];
         [RCIM sharedRCIM].disableMessageAlertSound=YES;
   
    }
   

    
    
    
}
#pragma actions

-(void)showlogin{
    
    
    
  }

-(void)teamaction{
    
// self.navigationController.navigationBar.hidden=YES;
    DoctorTeamViewController *doctorteam=[[DoctorTeamViewController alloc]init];
    //        doctorteam.teamarr=self.teamarr;
    //        doctorteam.participatedTeamarr=self.participatedTeamarr;
    //        doctorteam.invitationarr=self.invitationarr;
    self.navigationController.navigationBar.hidden=NO;
    //
    [self.navigationController pushViewController:doctorteam animated:YES];
}

-(void)setRichNumberWithLabel:(UILabel*)label Color:(UIColor *) color FontSize:(CGFloat)size
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSString *temp = nil;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize screensize = rect.size;
    CGFloat width = screensize.width;
    CGFloat height = screensize.height;
    NSLog(@"print %f,%f",width,height);
    for(int i =0; i < [attributedString length]; i++)
    {
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        if( [self isInt:temp]  ){
            
            if (width<=320.0) {
                [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 color, NSForegroundColorAttributeName,
                                                 [UIFont boldSystemFontOfSize:11.0],NSFontAttributeName, nil]
                                          range:NSMakeRange(i, 1)];

            } else {
                [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 color, NSForegroundColorAttributeName,
                                                 [UIFont boldSystemFontOfSize:15.0],NSFontAttributeName, nil]
                                          range:NSMakeRange(i, 1)];

            }
            
            
            
        }else{
            if (width<=320.0) {
                [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 kimiColor(157, 157, 157, 1.0), NSForegroundColorAttributeName,
                                                 [UIFont boldSystemFontOfSize:10.0],NSFontAttributeName, nil]
                                          range:NSMakeRange(i, 1)];
            } else {
                [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 kimiColor(157, 157, 157, 1.0), NSForegroundColorAttributeName,
                                                 [UIFont boldSystemFontOfSize:13.0],NSFontAttributeName, nil]
                                          range:NSMakeRange(i, 1)];
            }
            
            
            
        }
    }
    
    label.attributedText = attributedString;
}
- (BOOL)isInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}



-(void)mycaibuttonaction{
    
}
-(void)myplantOnbuttonaction{
    
    [MobClick event:@"to_message"];
    MsgListWebViewController *VC=[[MsgListWebViewController alloc]init];
  //  VC.delegate=self;
    //VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/message.html"];
     VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"message.html"];
    // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
    
    [self.tabBarController.navigationController pushViewController:VC animated:YES];


}
-(void)connectOnbuttonaction{
    
    [MobClick endEvent:@"order_count"];
    if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
        
        OrderManagerViewController *doctorteam=[[OrderManagerViewController alloc]init];
        self.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.tabBarController.navigationController pushViewController:doctorteam animated:YES];
        
    }else{
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"您还没有通认证，请在个人中心申请认证" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"去认证", nil];
        [alertview show];
    }

    
  
//    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dic = [userd dictionaryRepresentation];
//    for (NSString *key in [dic allKeys]) {
//        if (![key isEqualToString:@"pushtoken"]&&![key isEqualToString:@"isneedpush"]&&![key isEqualToString:@"isneedshow"]&&![key isEqualToString:@"firstStart"]&&![key isEqualToString:@"localasttime"]) {
//            [userd removeObjectForKey:key];
//            [userd synchronize];
//            
//        }
//        
//    }
//    [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//    [[PublicTools shareInstance]creareNotificationUIView:@"已注销"];


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        PubilcViewController *VC=[[PubilcViewController alloc]init];
        VC.isreg=YES;
        
        //http://192.168.1.117:8080/view/authentication.html
        // VC.urslstr=[NSString stringWithFormat:@"http://192.168.1.117:8080/view/authentication.html"];
        VC.urslstr=[NSString stringWithFormat:@"%@%@",k_webbaseurl,@"authentication.html"];
        // @"http://rm.chengyisheng.com.cn:8080/app_web/app_doctor_web/view/authentication.html";
        //        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
        //        UIViewController *basevc=[self.viewControllers objectAtIndex:self.selectedIndex];
        [self.tabBarController.navigationController pushViewController:VC animated:YES];

        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [MobClick endEvent:@"my_clinic"];
//    [redpointview removeFromSuperview];
//    
//    redpointview=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(outcallbtn.frame)/2-60/2+50, CGRectGetHeight(outcallbtn.frame)/2-60/2-10, 10, 10)];
//    redpointview.backgroundColor=[UIColor clearColor];
//    redpointview.layer.cornerRadius=5.0;
//    [outcallbtn addSubview:redpointview];
   
    
    
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden=YES;
//}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
  
       self.scrollView1.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView1.frame) * self.imagesData.count, ScreenHeight/3*1);
    
}


#pragma mark - ScrollView delegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    

       self.customStoryboardPageControl.currentPage = pageIndex;

    
}


// Example of use of delegate for second scroll view to respond to bullet touch event
- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index
{
    NSLog(@"Bullet index %ld", (long)index);
  //  [self.scrollView1 scrollRectToVisible:CGRectMake(CGRectGetWidth(self.scrollView1.frame) * index, 0, CGRectGetWidth(self.scrollView1.frame), CGRectGetHeight(self.scrollView1.frame)) animated:YES];
}


#pragma mark - Utils


- (void)setupScrollViewImages
{
      UIScrollView *scrollView=self.scrollView1;
        [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.frame) * idx, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
           // imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = [UIImage imageNamed:imageName];
            [scrollView addSubview:imageView];
        }];
    
}
-(void)setupmoreview{
    
        
        
        buttonbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-155, 66, 150, 45*2)];
        buttonbgv.layer.cornerRadius=4.0;
        buttonbgv.backgroundColor=[UIColor whiteColor];
        // buttonbgv.alpha=0.7;
        
        
        
        
        NSArray *namearr=@[@"添加个人患者",@"创建医生团队"];
        NSArray *moreimagearr=@[@"add_patient",@"establish_team",@"tmp",@"xinxiaoxiliebiao"];
        for (int i=0; i<2; i++) {
            
            UIImageView *imagev;
            
             imagev =[[UIImageView alloc]initWithFrame:CGRectMake(13, 45*i+12.5, 23, 20)];
            
            
            
            
            
            imagev.clipsToBounds=YES;
            
            imagev.layer.masksToBounds=YES;
            imagev.layer.cornerRadius =0.0;
            imagev.layer.borderColor = [UIColor clearColor].CGColor;
            imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
            
            // imagev.image=[UIImage imageNamed:@"KAKA"];
            //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
            imagev.image=[UIImage imageNamed:[moreimagearr objectAtIndex:i]];
            [buttonbgv addSubview:imagev];
            
            UILabel *label=[[UILabel alloc]init];
            label.frame=CGRectMake(50, 45*i+7, 90, 30);
            label.textColor=KBlackColor;
            label.textAlignment=NSTextAlignmentLeft;
            label.font=[UIFont boldSystemFontOfSize:15.0];
            label.backgroundColor=[UIColor clearColor];
            label.text=[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]];
            [buttonbgv addSubview:label];
            
            
            
            
            UIButton *morebutton1=[UIButton buttonWithType:UIButtonTypeCustom];
            morebutton1.frame=CGRectMake(0, 45*i, 150, 45);
            morebutton1.tag=1000000+i;
            //  [morebutton1 setImage:[UIImage imageNamed:[moreimagearr objectAtIndex:i]] forState:UIControlStateNormal];
            //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
            [morebutton1 setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 12, 150-21-15)];
            //[morebutton1 setTitle:[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]] forState:UIControlStateNormal];
            morebutton1.layer.borderWidth=1.0;
            morebutton1.layer.borderColor=[UIColor clearColor].CGColor;
            morebutton1.titleLabel.font=[UIFont boldSystemFontOfSize:19.0];
            //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
            //[morebutton setImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
            [morebutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
            [morebutton1 addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonbgv addSubview:morebutton1];
            if (i!=1) {
                UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 45-0.7, 150, 0.7)];
                linev.backgroundColor=KLineColor;
                [morebutton1 addSubview:linev];
            }
        }
    
}
-(void)buttonaction:(UIButton *)button{
    [moreControl removeFromSuperview];
    [buttonbgv removeFromSuperview];
    
    haveshowmorebutton=NO;
    
    
    
    
    
    
   
        if (button.tag==1000001) {
            //            NSLog(@"%@",self.datadic);
            [MobClick endEvent:@"on_add_doctorGroup"];
            EditnameViewController *editnamevc=[[EditnameViewController alloc]init];
            //editnamevc.isrootvc=NO;
          
            //    UIStoryboard *storyboard =
            //    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //    UITabBarController *roottabbarvc = [storyboard
            //                                        instantiateViewControllerWithIdentifier:@"MainTabbarVC"];
            //    //                self.window.rootViewController = rootNavi;
            //    //roottabbarvc.navigationController.navigationBar.hidden=NO;
            self.tabBarController.navigationController.navigationBar.hidden=NO;
            //    if (self.isRoot) {
            //        [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:editnamevc animated:YES];
            //    } else {
            [self.tabBarController.navigationController pushViewController:editnamevc animated:YES];
        }else{
            [MobClick endEvent:@"on_add_patient"];
            AddPatientViewController *editnamevc=[[AddPatientViewController alloc]init];
            //editnamevc.isrootvc=NO;
            
            //    UIStoryboard *storyboard =
            //    [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //    UITabBarController *roottabbarvc = [storyboard
            //                                        instantiateViewControllerWithIdentifier:@"MainTabbarVC"];
            //    //                self.window.rootViewController = rootNavi;
            //    //roottabbarvc.navigationController.navigationBar.hidden=NO;
            self.tabBarController.navigationController.navigationBar.hidden=NO;
            //    if (self.isRoot) {
            //        [self.tabBarController.navigationController.tabBarController.navigationController pushViewController:editnamevc animated:YES];
            //    } else {
            [self.tabBarController.navigationController pushViewController:editnamevc animated:YES];

            
            
       
        }
}


@end
