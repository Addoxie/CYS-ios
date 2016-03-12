//
//  NameListViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/30.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "NameListViewController.h"
#import "BATableViewKit/BATableView.h"
#import <Foundation/Foundation.h>
#import "ChineseString.h"
#import "HXViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "PatientChatViewController.h"
#import "AddPatientViewController.h"
#import "itemdetailbutton.h"

@interface NameListViewController ()<BATableViewDelegate>{
    NSMutableArray * indexTitles;
    UIButton *morebutton;
}
//@property (nonatomic, strong) BATableView *contactTableView;
@property (nonatomic, strong) NSArray * dataSource;

@end


@implementation NameListViewController
// 创建tableView
- (void) createTableView {
   
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
    // Do any additional setup after loading the view.
//    self.dataSource = @[@{@"indexTitle": @"A",@"data":@[@"adam", @"alfred", @"ain", @"abdul", @"anastazja", @"angelica"]},@{@"indexTitle": @"D",@"data":@[@"dennis" , @"deamon", @"destiny", @"dragon", @"dry", @"debug", @"drums"]},@{@"indexTitle": @"F",@"data":@[@"Fredric", @"France", @"friends", @"family", @"fatish", @"funeral"]},@{@"indexTitle": @"M",@"data":@[@"Mark", @"Madeline"]},@{@"indexTitle": @"N",@"data":@[@"Nemesis", @"nemo", @"name"]},@{@"indexTitle": @"O",@"data":@[@"Obama", @"Oprah", @"Omen", @"OMG OMG OMG", @"O-Zone", @"Ontario"]},@{@"indexTitle": @"Z",@"data":@[@"Zeus", @"Zebra", @"zed"]}];
   // [self createTableView];
    
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadpatient) name:@"reloadpatient" object:nil];
    
    if (self.isSpam) {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49) style:UITableViewStyleGrouped];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
         //self.tableView.separatorColor=KLineColor;
        [self.view addSubview:self.tableView];
        
        
        
        morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        morebutton.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
        
        morebutton.layer.masksToBounds = YES;
        morebutton.layer.cornerRadius = 0.0;
        morebutton.layer.borderWidth = 1.0;
        morebutton.layer.borderColor = [[UIColor clearColor] CGColor];
        [morebutton setTitle:@"下一步" forState:UIControlStateNormal];
        //nextbutton.userInteractionEnabled=NO;
        morebutton.titleLabel.font=[UIFont systemFontOfSize:19.0];
        [morebutton addTarget:self action:@selector(spambuttontaction) forControlEvents:UIControlEventTouchUpInside];
        morebutton.backgroundColor=KlightOrangeColor;
        [self.view addSubview:morebutton];
        
        morebutton.backgroundColor=kimiColor(209, 210, 211, 1.0);
        morebutton.userInteractionEnabled=NO;
        
        _editdataarr=[[NSMutableArray alloc]init];


    } else {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.separatorColor=[UIColor clearColor];
        [self.view addSubview:self.tableView];
        self.tableView.sectionIndexColor=KtextGrayColor;

    }

    
    
    
    
    
    
    
    
    [self loaddata];
    
    
   // UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-60, 5, 50, 30)];
    
  
    
    if (self.isSpam) {
        
        
         self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(addshowMenu)];
         // [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    } else {
         self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addshowMenu)];
         // [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    }
   // rightBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
//    [rightBtn addTarget:self action:@selector(addshowMenu) forControlEvents:UIControlEventTouchUpInside];
//    //  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
   // [self.navigationController.navigationBar  addSubview:rightBtn];

    
}
-(void)loaddata{
    
    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    [hud showInView:self.view];
    [hud dismissAfterDelay:5];
    [PatientDataService getallPatientsblock:^(id respdic) {
        NSLog(@"%@",respdic);
        
        NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
        NSArray *sourcearr=[[NSArray alloc]initWithArray:[respdic objectForKey:@"content"]];
        self.title=[NSString stringWithFormat:@"我的患者（%zd）",sourcearr.count];
        // NSMutableArray *tmparr=[[NSMutableArray alloc]init];
        
        NSMutableArray *sorttmpnamearr=[ChineseString SortArray:sourcearr];
        
        for (NSString *name in sorttmpnamearr) {
            for (NSDictionary *sortdic in sourcearr) {
                if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
                    [turenamearr addObject:sortdic];
                }
            }
        }
        
        
        NSMutableArray *indexarr=[[NSMutableArray alloc]init];
        
        for (NSString *name in sorttmpnamearr) {
            if (![indexarr containsObject:[self firstCharactor:name]]) {
                [indexarr addObject:[self firstCharactor:name]];
            }
        }
        
        
        
        NSMutableArray *turedataarr=[[NSMutableArray alloc]init];
        
        for (NSString *indexstr in indexarr) {
            NSMutableDictionary *turedatadic=[[NSMutableDictionary alloc]init];
            [turedatadic setObject:indexstr forKey:@"indexTitle"];
            //[indexarr addObject:[self firstCharactor:name]];
            NSMutableArray *tmparr=[[NSMutableArray alloc]init];
            for (NSDictionary *sortdic in turenamearr) {
                NSMutableDictionary *tmpdic1=[[NSMutableDictionary alloc]initWithDictionary:sortdic];
                if ([indexstr isEqualToString:[self firstCharactor:[sortdic objectForKey:@"name"]]]) {
                    [tmpdic1 setObject:@"unselect" forKey:@"selectstate"];
                    [tmparr addObject:tmpdic1];
                }
            }
            [turedatadic setObject:tmparr forKey:@"data"];
            [turedataarr addObject:turedatadic];
        }
        self.dataSource=turedataarr;
        [hud dismiss];
        
        
        
        indexTitles = [NSMutableArray array];
        for (NSDictionary * sectionDictionary in self.dataSource) {
            [indexTitles addObject:sectionDictionary[@"indexTitle"]];
        }
        //return indexTitles;
        
        //[self createTableView];
        [self.tableView reloadData];
        NSLog(@"%@",indexarr);
        NSLog(@"%@",turenamearr);
        
    }];
    

}
-(void)reloadpatient{
    [self loaddata];
}
-(void)addshowMenu{
    
    if (self.isSpam) {
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } else {
        AddPatientViewController *addpvc=[[AddPatientViewController alloc]init];
        //        doctorteam.teamarr=self.teamarr;
        //        doctorteam.participatedTeamarr=self.participatedTeamarr;
        //        doctorteam.invitationarr=self.invitationarr;
        self.navigationController.navigationBar.hidden=NO;
        //
        [self.navigationController pushViewController:addpvc animated:YES];
    }
  

}
-(void)spambuttontaction{
    
    
    if (_editdataarr.count>0) {
        EditSpamContentViewController *editspamvc=[[EditSpamContentViewController alloc]init];
        editspamvc.title=@"群发";
        editspamvc.contactarr=_editdataarr;
        [self.navigationController pushViewController:editspamvc animated:YES];
    } else {
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"请选择患者"];
    }
   
    
    
    
}
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
//- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
//    NSMutableArray * indexTitles = [NSMutableArray array];
//    for (NSDictionary * sectionDictionary in self.dataSource) {
//        [indexTitles addObject:sectionDictionary[@"indexTitle"]];
//    }
//    return indexTitles;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
-(NSArray *)tableViewAtIndexes:(NSIndexSet *)indexes{
    return indexTitles;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataSource[section][@"indexTitle"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr=(NSArray *)self.dataSource[section][@"data"];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    for (UIView *subv in cell.subviews) {
        [subv removeFromSuperview];
    }
    NSDictionary *dic=self.dataSource[indexPath.section][@"data"][indexPath.row];
    
    //cell.textLabel.text = [dic objectForKey:@"name"];
      NSArray *arr=(NSArray *)self.dataSource[indexPath.section][@"data"];
    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
  
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    if (self.isSpam) {
          imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10+35, 8, 44, 44)];
    }else{
          imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 44, 44)];
    }
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =22.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [cell addSubview:imagev];
    
    UILabel *label=[[UILabel alloc]init];
    
    if (self.isSpam) {
      label.frame=CGRectMake(95, 15, 90, 30);
    }else{
        label.frame=CGRectMake(66, 15, 90, 30);
    }
    label.textColor=KBlackColor;
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:17.0];
    label.backgroundColor=[UIColor clearColor];
    [cell addSubview:label];
    
    //label.text=
//    NSString *contentstring=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
////    
//    NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
////    
//
    label.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
//    
//    [UserDataService getUserInfofortargetIdWithtargetId:[dic objectForKey:@"user_id"] block:^(id userinfomodel) {
//        UserInfoModel *model=(UserInfoModel *)userinfomodel;
//         [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        label.text=model.username;
//        
//        
//    }];
    
    
    
    
    if (self.isSpam) {
        
        
        
        itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
        // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
        
        
    
            sentbutton.frame=CGRectMake(10,15, 30, 30);
            [sentbutton setTitle:@"添加" forState:UIControlStateNormal];
            
      
        sentbutton.tag=indexPath.row+200000000;
        sentbutton.buttonlocation=indexPath.section;
        sentbutton.layer.masksToBounds = YES;
        sentbutton.layer.cornerRadius = 15.0;
        sentbutton.layer.borderWidth = 1.0;
        sentbutton.layer.borderColor = [[UIColor clearColor] CGColor];
        if ([dic objectForKey:@"selectstate"]) {
            if ([[dic objectForKey:@"selectstate"]isEqualToString:@"unselect"]) {
                // [sentbutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
                sentbutton.selected=NO;
                sentbutton.havePressed=NO;
            }else{
                
                sentbutton.selected=YES;
                sentbutton.havePressed=YES;
            }
        }
        
        [sentbutton setImage:[UIImage imageNamed:@"select_1"] forState:UIControlStateNormal];
        [sentbutton setImage:[UIImage imageNamed:@"select_2"] forState:UIControlStateSelected];
        // [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sentbutton.backgroundColor=[UIColor whiteColor];
        [sentbutton addTarget:self action:@selector(editaction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:sentbutton];

        
        
        
        
        
    }else{
//        CutomUIButton *tagbutton=[CutomUIButton buttonWithType:UIButtonTypeCustom];
//        tagbutton.frame=CGRectMake(ScreenWidth-75, 60/2.0-25/2.0, 60, 25);
//        //tagbutton.section=indexPath.section;
//        tagbutton.layer.cornerRadius=5.0;
//        tagbutton.section=indexPath.section;
//        tagbutton.subrow=indexPath.row;
//        // tagbutton.backgroundColor=KlightOrangeColor;
//        tagbutton.layer.borderWidth = 1.0;
//        tagbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        //tagbutton.frame=CGRectMake(ScreenWidth-70, 60/2.0-25/2.0, 60, 25);
//        [tagbutton setTitle:@"编辑" forState:UIControlStateNormal];
//        [tagbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
//        [tagbutton addTarget:self action:@selector(tagbuttonaction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:tagbutton];
//        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
//        linev.backgroundColor=KBackgroundColor;
//        [cell addSubview:linev];

    }
    
    if (self.isSpam) {
        //label.frame=CGRectMake(95, 15, 90, 30);
        if (indexPath.row!=arr.count-1) {
             [cell addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(95, 60-0.8, ScreenWidth-95, 0.8) withimage:nil withbgcolor:KLightLineColor]];
        }
       
    }else{
        if (indexPath.row!=arr.count-1) {
             [cell addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(66, 60-0.8, ScreenWidth-66, 0.8) withimage:nil withbgcolor:KLightLineColor]];
        }
       
       // label.frame=CGRectMake(66, 15, 90, 30);
    }
    
    

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
   
    return cell;
}
-(void)editaction:(itemdetailbutton *)button{
    if (button.havePressed==NO) {
        
        button.selected=YES;
        button.havePressed=YES;
        NSMutableDictionary *datadic=[[NSMutableDictionary alloc]initWithDictionary:self.dataSource[button.buttonlocation][@"data"][button.tag-200000000]];
        [self.dataSource[button.buttonlocation][@"data"][button.tag-200000000] setValue:@"selected" forKey:@"selectstate"];
        
        
        
       //  NSDictionary *dic=self.dataSource[button.buttonlocation][@"data"][button.tag-200000000];
        
        
//        NSMutableArray *mutaArray = [[NSMutableArray alloc] initWithArray:dataarr];
//        [mutaArray replaceObjectAtIndex:button.tag-200000000 withObject:datadic];
//        dataarr= [[NSMutableArray alloc] init];
//        [dataarr removeAllObjects];
//        dataarr = mutaArray;
        
     //   NSMutableDictionary *datadic1=[[NSMutableDictionary alloc]initWithDictionary:self.dataSource[button.buttonlocation][@"data"][button.tag-200000000]];
        [_editdataarr addObject:datadic];
        morebutton.backgroundColor=KlightOrangeColor;
        morebutton.userInteractionEnabled=YES;
        [morebutton setTitle:[NSString stringWithFormat:@"下一步(%zd)",_editdataarr.count] forState:UIControlStateNormal];
        
        
        
    }else{
        button.selected=NO;
        button.havePressed=NO;
        
      //  NSMutableDictionary *datadic=[[NSMutableDictionary alloc]initWithDictionary:self.dataSource[button.buttonlocation][@"data"][button.tag-200000000]];
        
        [self.dataSource[button.buttonlocation][@"data"][button.tag-200000000] setValue:@"unselect" forKey:@"selectstate"];
//        NSMutableArray *mutaArray = [[NSMutableArray alloc] initWithArray:dataarr];
//        [mutaArray replaceObjectAtIndex:button.tag-200000000 withObject:datadic];
//        dataarr= [[NSMutableArray alloc] init];
//        [dataarr removeAllObjects];
//        dataarr = mutaArray;
        
        NSMutableDictionary *datadic1=[[NSMutableDictionary alloc]initWithDictionary:self.dataSource[button.buttonlocation][@"data"][button.tag-200000000]];
        [_editdataarr removeObject:datadic1];
        
        if (_editdataarr.count!=0) {
            morebutton.backgroundColor=KlightOrangeColor;
            morebutton.userInteractionEnabled=YES;
            [morebutton setTitle:[NSString stringWithFormat:@"下一步(%zd)",_editdataarr.count] forState:UIControlStateNormal];
        }else{
            morebutton.backgroundColor=kimiColor(209, 210, 211, 1.0);
            morebutton.userInteractionEnabled=NO;
            [morebutton setTitle:[NSString stringWithFormat:@"下一步"] forState:UIControlStateNormal];
        }
//
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=self.dataSource[indexPath.section][@"data"][indexPath.row];
    
    
    
    if (self.isSpam) {
        
    } else {
        JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];
        [hud dismissAfterDelay:5];
        [IMDataService getPersonalIMInfofortargetIdWithpatientId:[dic objectForKey:@"id"] block:^(id respdic) {
            
            
            NSDictionary *tmpdatadic=(NSDictionary *)respdic;
            //        @property(nonatomic, assign) RCConversationType conversationType;
            //
            //        /*!
            //         目标会话ID
            //         */
            //        @property(nonatomic, strong) NSString *targetId;
            //
            //        /*!
            //         会话的标题
            //         */
            //        @property(nonatomic, strong) NSString *conversationTitle;
            
            [UserDataService getUserInfofortargetIdWithtargetId:[tmpdatadic objectForKey:@"initiator_id"] block:^(id usrinfomodel) {
                [hud dismiss];
                
                UserInfoModel *inmodel=(UserInfoModel *)usrinfomodel;
                RCConversationModel *model=[[RCConversationModel alloc]init];
                model.conversationType=ConversationType_PRIVATE;
                model.targetId=[tmpdatadic objectForKey:@"initiator_id"];
                model.conversationTitle=inmodel.username;
                PatientChatViewController *conversationPageVC=[[PatientChatViewController alloc]initWithChatModel:model];
                conversationPageVC.title=inmodel.username;
                conversationPageVC.model=model;
                conversationPageVC.isgroup=NO;
                conversationPageVC.patientd=[dic objectForKey:@"id"];
                //    self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
                [self.navigationController pushViewController:conversationPageVC animated:YES];
                
                
                
                
                
            }];
            
            
            
            
        }];

    }
 
}
-(void)tagbuttonaction:(CutomUIButton *)button{
     NSDictionary *dic=self.dataSource[button.section][@"data"][button.row];
    
    
    
    //NSDictionary *dic=(NSDictionary *)self.contents[button.section][button.row][button.subrow];//获取单个患者数据
    NSLog(@"%@",dic);
    HXViewController *vc = [[HXViewController alloc] init];
    vc.patientid=[dic objectForKey:@"id"];
    vc.title = self.title;
    vc.delegate=self;
    vc.view.frame = self.view.bounds;
    //    NSLog(@"qwe%@",selectedArray);
    //    [vc.selectedArray addObjectsFromArray:selectedArray];
    //    [vc.optionalArray addObjectsFromArray:optionalArray];
    // UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
    
    
   // NSDictionary *dic=(NSDictionary *)self.contents[button.section][button.row][button.subrow];//获取单个患者数据
    
//    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:5];
//    [PatientDataService getPatientTagsWithPatientId:[dic objectForKey:@"id"] block:^(id resparr) {
//        NSArray *selectedArray=(NSArray *)resparr;
//        
//        
//        
//        //        NSArray *selectedArray = @[@"头条",@"热点"];
//        //
//        
//        
//        
//        
//        [PatientDataService getAlltagsblock:^(id resparr1) {
//            [hud dismiss];
//            NSMutableArray *optionalArray =[[NSMutableArray alloc]initWithArray:resparr1];
//            for (NSDictionary * dic in selectedArray) {
//                if ([optionalArray containsObject:dic]) {
//                    [optionalArray removeObject:dic];
//                }
//            }
//            
//            
//            
//            NSDictionary *dic=(NSDictionary *)self.contents[button.section][button.row][button.subrow];//获取单个患者数据
//            
//            HXViewController *vc = [[HXViewController alloc] init];
//            vc.patientid=[dic objectForKey:@"id"];
//            vc.title = self.title;
//            vc.delegate=self;
//            vc.view.frame = self.view.bounds;
//            //    NSLog(@"qwe%@",selectedArray);
//            //    [vc.selectedArray addObjectsFromArray:selectedArray];
//            //    [vc.optionalArray addObjectsFromArray:optionalArray];
//            // UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
//            [self.navigationController pushViewController:vc animated:YES];
//            
//            HXViewController *vc = [[HXViewController alloc] init];
//            vc.patientid=[dic objectForKey:@"id"];
//            vc.title = self.title;
//            vc.delegate=self;
//            vc.view.frame = self.view.bounds;
//            [vc.selectedArray addObjectsFromArray:selectedArray];
//            [vc.optionalArray addObjectsFromArray:optionalArray];
//            // UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
//            [self.navigationController pushViewController:vc animated:YES];
//            
//        }];
//        
//        
//        //        NSArray *optionalArray = @[@"画报",@"跑步",@"值得买",@"酒香",@"LOL",@"社会"];
//        
//        
//        
//        
//        
//        
//    }];
    
}
-(void)reloadtagsdata{

}

@end
