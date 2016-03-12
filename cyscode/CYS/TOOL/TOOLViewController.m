//
//  TOOLViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/16.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "TOOLViewController.h"
#import "NameListViewController.h"



@interface TOOLViewController (){
    NavBarView *mybarview;
    UIView *blankView;
}

@end

@implementation TOOLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=KlightOrangeColor;
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize=CGSizeMake((ScreenWidth-1.5)/2, (ScreenHeight-64-49-4)/3);
    
    CGFloat paddingX=0.3;
    CGFloat paddingY=0.8;
    
    //每个格子的上左下右的间隔
    flowLayout.sectionInset=UIEdgeInsetsMake(paddingX, paddingX, paddingY, paddingX);
    flowLayout.minimumLineSpacing = paddingY;
    flowLayout.minimumInteritemSpacing=paddingX;
    // self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:flowLayout];
    UICollectionView *collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,64,ScreenWidth,ScreenHeight) collectionViewLayout:flowLayout];
    collectionview.scrollEnabled=NO;
    collectionview.dataSource=self;
    collectionview.delegate=self;
    collectionview.backgroundColor=KLineColor;
    
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:collectionview];
  
    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=@"工具箱";
    mybarview.isRoot=YES;
    [mybarview hidebacktbtn];
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
   // mybarview.alpha=0.7;
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    
    
    [blankView removeFromSuperview];
    
    blankView=[[UIView alloc]initWithFrame:CGRectMake(0,64,ScreenWidth,ScreenHeight)];
    blankView.backgroundColor=KBackgroundColor;
    blankView.alpha=1.0;
    
    
//    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(kWidthgetFloat(132), 80, kWidthgetFloat(124), kWidthgetFloat(124))];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    imagev.image=[UIImage imageNamed:@"group_massage3x"];
    
    
   //
//    // imagev.image=[UIImage imageNamed:@"KAKA"];
//    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
//    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [blankView addSubview:imagev];
    
    
    
    
    UIButton *addgroupbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    addgroupbutton.frame=imagev.frame;
    
//    addgroupbutton.layer.masksToBounds = YES;
//    addgroupbutton.layer.cornerRadius = 6.0;
//    addgroupbutton.layer.borderWidth = 1.0;
//    addgroupbutton.layer.borderColor = [[UIColor clearColor] CGColor];
//    
//    [addgroupbutton setImage:[UIImage imageNamed:@"group_massage3x"] forState:UIControlStateNormal];
//    //nextbutton.userInteractionEnabled=NO;
//    addgroupbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    [addgroupbutton addTarget:self action:@selector(addgroupbuttontaction) forControlEvents:UIControlEventTouchUpInside];
   // addgroupbutton.backgroundColor=KlightOrangeColor;
    [blankView addSubview:addgroupbutton];
    
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidthgetFloat(132), 80+kWidthgetFloat(124)+5,kWidthgetFloat(124), 30)];
    titlelabel.text=[NSString stringWithFormat:@"群发信息"];
    titlelabel.textColor=KBlackColor;
    titlelabel.numberOfLines=1;
    titlelabel.backgroundColor=KBackgroundColor;
    titlelabel.layer.cornerRadius=6.0;
    titlelabel.layer.borderColor=KBackgroundColor.CGColor;
    titlelabel.layer.borderWidth=1.0;
    //[titlelabel sizeToFit];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont systemFontOfSize:15.0];
    //detaillabel.userInteractionEnabled=NO;
    [blankView addSubview:titlelabel];


    
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-250/2.0, 80+kWidthgetFloat(124)+5+30,250, 30)];
    detaillabel.text=[NSString stringWithFormat:@"更多功能将稍后发布，敬请期待！"];
    detaillabel.textColor=KtextGrayColor;
    detaillabel.numberOfLines=1;
    detaillabel.backgroundColor=KBackgroundColor;
    detaillabel.layer.cornerRadius=6.0;
    detaillabel.layer.borderColor=KBackgroundColor.CGColor;
    detaillabel.layer.borderWidth=1.0;
    
    detaillabel.textAlignment=NSTextAlignmentCenter;
    detaillabel.font=[UIFont systemFontOfSize:14.0];
    //detaillabel.userInteractionEnabled=NO;
    [blankView addSubview:detaillabel];

    
    
    
    [self.view addSubview:blankView];
    
    
    
    //    UIView *bgv10=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    //    bgv10.backgroundColor=[UIColor whiteColor];
    //    [self.view addSubview:bgv10];
    
    
    // Do any additional setup after loading the view.
}

-(void)addgroupbuttontaction{
    
    
    
    if ([KGetDefaultstr(@"userstatus") isEqualToString:@"AUDIT_PASSED"]) {
        ShowSpamContentViewController *doctorteam=[[ShowSpamContentViewController alloc]init];
        doctorteam.title=@"群发消息";
        //  doctorteam.isSpam=YES;
        self.tabBarController.navigationController.navigationBar.hidden=NO;
        [self.tabBarController.navigationController pushViewController:doctorteam animated:YES];
    }else{
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"您还没有通认证，请在个人中心申请认证" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
//        ShowSpamContentViewController *doctorteam=[[ShowSpamContentViewController alloc]init];
//        doctorteam.title=@"群发消息";
//        //  doctorteam.isSpam=YES;
//        self.tabBarController.navigationController.navigationBar.hidden=NO;
//        [self.tabBarController.navigationController pushViewController:doctorteam animated:YES];
    }

 

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:@"toolbox"];
 //[self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)itemactionWithType:(NSInteger)typeindex{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =nil;
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    for (UIView *viewd in [cell.contentView subviews]) {
        [viewd removeFromSuperview];
    }
    
    UIImageView *imagev4=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-1)/2/2-60/2, (ScreenHeight-64-49-3)/3/2-60/2-10, 60, 60)];
    
   
    
    [cell addSubview:imagev4];
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-1)/2/2-100/2, imagev4.frame.origin.y+60+10, 100, 20)];
    
    label4.textAlignment=NSTextAlignmentCenter;
    label4.font=[UIFont systemFontOfSize:13.0];
    [cell addSubview:label4];
    if (indexPath.row==0) {
        imagev4.image=[UIImage imageNamed:@"tmp"];
        label4.text=@"医生团队";
    }else  if (indexPath.row==1){
        imagev4.image=[UIImage imageNamed:@"tmp"];
        label4.text=@"医生团队";
    }else  if (indexPath.row==2){
        imagev4.image=[UIImage imageNamed:@"tmp"];
        label4.text=@"医生团队";
    }else  if (indexPath.row==3){
        imagev4.image=[UIImage imageNamed:@"tmp"];
        label4.text=@"医生团队";
    }else  if (indexPath.row==4){
        imagev4.image=[UIImage imageNamed:@"tmp"];
        label4.text=@"医生团队";
    }else if (indexPath.row==5){
        imagev4.image=[UIImage imageNamed:@"tmp"];
        label4.text=@"医生团队";
    }
    
    
    

    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
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
