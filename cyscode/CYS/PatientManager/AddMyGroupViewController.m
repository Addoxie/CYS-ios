//
//  AddMyGroupViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "AddMyGroupViewController.h"
#import "AddDoctorViewController.h"
#import "SearchNameViewController.h"

@interface AddMyGroupViewController (){

    NavBarView *mybarview;
}

@end

@implementation AddMyGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor=KBackgroundColor;
    
    UILabel *numberlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 200-30,ScreenWidth, 30)];
    numberlabel.text=[NSString stringWithFormat:@"%@",@"您尚未邀请医生加入团队"];
    numberlabel.textColor=KBlackColor;
    numberlabel.numberOfLines=1;
    numberlabel.textAlignment=NSTextAlignmentCenter;
    numberlabel.font=[UIFont systemFontOfSize:15.0];
    
    numberlabel.userInteractionEnabled=NO;
    [self.view addSubview:numberlabel];
    
   
    
    UIButton *adddoctorbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    adddoctorbutton.frame=CGRectMake(30, 200, ScreenWidth-60, 50);
    
    adddoctorbutton.layer.masksToBounds = YES;
    adddoctorbutton.layer.cornerRadius = 6.0;
    adddoctorbutton.layer.borderWidth = 1.0;
    adddoctorbutton.layer.borderColor = [[UIColor blueColor] CGColor];
    [adddoctorbutton setTitle:@"马上邀请医生" forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    adddoctorbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [adddoctorbutton addTarget:self action:@selector(adddoctorbuttonaction) forControlEvents:UIControlEventTouchUpInside];
    adddoctorbutton.backgroundColor=[UIColor blueColor];
    [self.view addSubview:adddoctorbutton];
    
    
    
    
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 360-30,ScreenWidth, 30)];
    detaillabel.text=[NSString stringWithFormat:@"%@",@"您尚未添加患者"];
    detaillabel.textColor=KBlackColor;
    detaillabel.numberOfLines=1;
    detaillabel.textAlignment=NSTextAlignmentCenter;
    detaillabel.font=[UIFont systemFontOfSize:15.0];
    
    detaillabel.userInteractionEnabled=NO;
    [self.view addSubview:detaillabel];

    UIButton *addpatientbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    addpatientbutton.frame=CGRectMake(30, 360, ScreenWidth-60, 50);
    
    addpatientbutton.layer.masksToBounds = YES;
    addpatientbutton.layer.cornerRadius = 6.0;
    addpatientbutton.layer.borderWidth = 1.0;
    addpatientbutton.layer.borderColor = [KGreenColor CGColor];
    [addpatientbutton setTitle:@"马上添加患者" forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    addpatientbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [addpatientbutton addTarget:self action:@selector(addpatientbuttonaction) forControlEvents:UIControlEventTouchUpInside];
    addpatientbutton.backgroundColor=KGreenColor;
    [self.view addSubview:addpatientbutton];

    
    
    
    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=[NSString stringWithFormat:@"%@(我的团队)",self.title];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // self.navigationController.navigationBar.hidden=NO;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)adddoctorbuttonaction{
    AddDoctorViewController *editnamevc=[[AddDoctorViewController alloc]init];
    //editnamevc.isrootvc=NO;
    editnamevc.docteamid=self.docteamid;
    [self.navigationController pushViewController:editnamevc animated:YES];
}
-(void)addpatientbuttonaction{
    SearchNameViewController *editnamevc=[[SearchNameViewController alloc]init];
    //editnamevc.isrootvc=NO;
    editnamevc.isnewteam=YES;
    editnamevc.docteamid=self.docteamid;
    [self.navigationController pushViewController:editnamevc animated:YES];
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

@end
