//
//  PatientListViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/28.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "PatientListViewController.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "CutomUIButton.h"
#import "ColumnViewController.h"
#import "CustomLongPressGestureRecognizer.h"
#import "OpenModel.h"
#import "HXViewController.h"
#import "PatientChatViewController.h"
#import "NameListViewController.h"

#import "AddPatientViewController.h"


@interface PatientListViewController (){
    NSIndexPath *openedpath;
    CutomUIButton *commentLongRecognizer;
    NSTimer *timer;
    NSInteger timercount;
    NSMutableArray *openmodelarr;
    NSMutableArray *tagContentarrArr;
    NSMutableArray *tmptagContentarrArr;
    OpenModel *needopenmodel;
    CutomUIButton *commentmodel;
    UIButton *morebutton;
    
    
}
@property(nonatomic,retain)NSMutableArray *contents;
@end


@implementation PatientListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    timercount=0;
    
    
    
    openmodelarr=[[NSMutableArray alloc]init];
    tagContentarrArr= [[NSMutableArray alloc]init];
    tmptagContentarrArr= [[NSMutableArray alloc]init];
    commentmodel=[[CutomUIButton alloc]init];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 3, ScreenWidth, ScreenHeight-3) style:UITableViewStyleGrouped];
   // self.tableView.SKSTableViewDelegate = self;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;

    self.tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadpatient) name:@"reloadpatient" object:nil];
    UIView *headerview= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,74)];
    self.tableView.tableHeaderView =headerview;
    headerview.backgroundColor=[UIColor whiteColor];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=headerview.frame;
    // [button setTitle:@"我的团队" forState:UIControlStateNormal];
    [button setTitleColor:KBlackColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(myteamaction) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:button];
    
    UILabel *itemlabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 12, 90, 50)];
    itemlabel.text=@"我的患者";
    itemlabel.textColor=KBlackColor;
    itemlabel.font=[UIFont systemFontOfSize:17.0];
    // itemlabel.backgroundColor=KGreenColor;
    itemlabel.textAlignment=NSTextAlignmentLeft;
    [headerview addSubview:itemlabel];
    
    
    UIImageView *imagev1=[[UIImageView alloc]init];
    //=[[UIImageView alloc]init];
    imagev1.frame=CGRectMake(ScreenWidth-18, 37-8, 10, 16);
    imagev1.image=[UIImage imageNamed:@"arrow"];
    
    imagev1.clipsToBounds=YES;
    
    imagev1.layer.masksToBounds=YES;
    imagev1.layer.cornerRadius =4.0;
    imagev1.layer.borderColor = [UIColor clearColor].CGColor;
    imagev1.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    
    [headerview addSubview:imagev1];
    UIView *borderview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
    borderview.backgroundColor=KBackgroundColor;
    [headerview addSubview:borderview];
    
    UIView *borderview1=[[UIView alloc]initWithFrame:CGRectMake(0, 62, ScreenWidth, 12)];
    borderview1.backgroundColor=KBackgroundColor;
    [headerview addSubview:borderview1];

    
    
    
    
//    
//    UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 59.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
//    lineview.backgroundColor=KLineColor;
//    lineview.alpha=0.3;
//    [headerview addSubview:lineview];

    
    
    
    [self getdata];
    self.title=@"我的患者库";
    
//    
//    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    morebutton.frame=CGRectMake(ScreenWidth-45, 29, 45, 30);
//    
//    [morebutton setTitle:@"添加" forState:UIControlStateNormal];
//    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
//    // [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
//    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [morebutton addTarget:self action:@selector(addtagbtnaction) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:morebutton];
  //  [self.view addSubview:morebutton];
 self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addtagbtnaction)];
    
    
//    [PatientDataService getTagPatientsWithTagid:nil block:^(id resparr) {
//        NSLog(@"%@",resparr);
//    }];

    self.navigationController.navigationBar.hidden=NO;
}
-(void)reloadpatient{
    [self getdata];
}

-(void)morebuttonaction{
    AddPatientViewController *addpvc=[[AddPatientViewController alloc]init];
    //        doctorteam.teamarr=self.teamarr;
    //        doctorteam.participatedTeamarr=self.participatedTeamarr;
    //        doctorteam.invitationarr=self.invitationarr;
    self.navigationController.navigationBar.hidden=NO;
    //
    [self.navigationController pushViewController:addpvc animated:YES];

    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(void)myteamaction{
    NameListViewController *doctorteam=[[NameListViewController alloc]init];
    //        doctorteam.teamarr=self.teamarr;
    //        doctorteam.participatedTeamarr=self.participatedTeamarr;
    //        doctorteam.invitationarr=self.invitationarr;
    self.navigationController.navigationBar.hidden=NO;
    //
    [self.navigationController pushViewController:doctorteam animated:YES];

    
}
-(void)getdata{
   
    [PatientDataService getPatientCountofDoctorTagsblock:^(id respdataarr) {
        [tagContentarrArr removeAllObjects];
        [openmodelarr removeAllObjects];
         NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:respdataarr];
        NSLog(@"%@",arr);
      // _contents = [[NSMutableArray alloc]initWithArray: @[[[NSMutableArray alloc]initWithArray:arr]]];
        
        
        NSMutableArray *tmparr=[[NSMutableArray alloc]init];
        for (NSDictionary * dic in arr) {
            NSMutableArray *rowarr=[[NSMutableArray alloc]init];
            [rowarr addObject:dic];
            [tmparr addObject:rowarr];
          
        }
        for (int i=0; i<arr.count; i++) {
            NSDictionary * dic=(NSDictionary *)[arr objectAtIndex:i];
            OpenModel *model=[[OpenModel alloc]init];
            model.haveOpen=NO;
            model.sectionTitle=[[dic objectForKey:@"tag"] objectForKey:@"tag"];
            model.sectionid=[[dic objectForKey:@"tag"] objectForKey:@"id"];
            model.sectionnum=[NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]];
            model.havepress=NO;
            
            model.modelindexpath=[NSIndexPath indexPathForRow:i+1 inSection:0];
            //if ([[dic objectForKey:@"count"] integerValue]>0) {
                 [openmodelarr addObject:model];
          //  }
           
           
        }
//        {
//            "tag": {
//                "id": "f1f91a99-cabf-42ee-bb0d-3cce290d74f8",
//                "tag": "医生直接加的标签",
//                "sort_num": 1
//            },
//            "count": 0
//        },
      
        
        
        OpenModel *model=[[OpenModel alloc]init];
        model.haveOpen=NO;
        model.sectionTitle=@"未分组";
        model.sectionnum=[NSString stringWithFormat:@""];
        model.havepress=NO;
        model.sectionid=@"";
        model.modelindexpath=[NSIndexPath indexPathForRow:0 inSection:0];
        [openmodelarr insertObject:model atIndex:0];

        
        
        tagContentarrArr=[[NSMutableArray alloc]init];
        
        
        
        
        for (int j=0;j<openmodelarr.count; j++) {
            NSMutableArray *contenttmparr=[[NSMutableArray alloc]init];
            [tagContentarrArr addObject:contenttmparr];
            [tmptagContentarrArr addObject:contenttmparr];
        }
        
        [self.tableView reloadData];
        
        
        
//        NSMutableDictionary *untagdic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"id",@"未分组",@"tag",@"1",@"sort_num", nil];
//        
//        NSMutableDictionary *untagdic1=[[NSMutableDictionary alloc]initWithObjectsAndKeys:untagdic,@"tag",@"0",@"count",nil];
//          [tmparr addObject:@[untagdic1]];
//        
//        _contents = [[NSMutableArray alloc]initWithArray: @[[[NSMutableArray alloc]initWithArray:tmparr]]];
//        
//        [self reloadTableViewWithData:_contents];
        
       
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    timercount=0;
    
    
    [timer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return openmodelarr.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    CutomUIButton *labelbtn=[[CutomUIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [labelbtn setTitleColor:KBlackColor forState:UIControlStateNormal];
    labelbtn.section=section;
    labelbtn.isneedArrow=YES;
    labelbtn.backgroundColor=[UIColor whiteColor];
  //  label.textAlignment=NSTextAlignmentLeft;
    OpenModel *model=[openmodelarr objectAtIndex:section];
   // NSString *titlestr=[NSString stringWithFormat:@"%@(%@)",model.sectionTitle,model.sectionnum];
    //[labelbtn setTitle:titlestr forState:UIControlStateNormal];
   // [labelbtn addTarget:self action:@selector(sectionbtnaction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 0,ScreenWidth-30, 50)];
    if (section==0) {
         titlelabel.text=[NSString stringWithFormat:@"%@",model.sectionTitle];
    }else{
         titlelabel.text=[NSString stringWithFormat:@"%@",model.sectionTitle];
    }
  
    titlelabel.textColor=KBlackColor;
    titlelabel.numberOfLines=1;
    titlelabel.font=[UIFont systemFontOfSize:17.0];
    titlelabel.textAlignment=NSTextAlignmentLeft;
    //[titlelabel sizeToFit];
    //titlelabel.userInteractionEnabled=NO;
    [labelbtn addSubview:titlelabel];

    
    //if (section!=0) {
    [labelbtn addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchDown];
    [labelbtn addTarget:self action:@selector(canclebuttonaction:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside];
    
   // }
    
    
    UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-60, 0, 50, 50)];
    namelabel.text=[NSString stringWithFormat:@"%@",model.sectionnum];
    namelabel.font=[UIFont boldSystemFontOfSize:14.0];
    namelabel.textColor=KtextGrayColor;
    namelabel.textAlignment=NSTextAlignmentRight;
    [labelbtn addSubview:namelabel];
    
    
    
//    UIView *lineview=[[UIView alloc]initWithFrame:CGRectMake(0, 59.5, ScreenWidth, 1)];
//    lineview.backgroundColor=KLineColor;
//    [labelbtn addSubview:lineview];
    
//    [labelbtn addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, 0, ScreenWidth, 0.8) withimage:nil withbgcolor:KLightLineColor]];
    UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    lineview.backgroundColor=KLineColor;
    lineview.alpha=0.5;
    [labelbtn addSubview:lineview];
    return labelbtn;

}






-(void)sectionbtnaction:(CutomUIButton *)button{
    
  //  NSLog(@"Section: %zd, Row:%zd, Subrow:%zd", indexPath.section, indexPath.row, indexPath.subRow);
    
    
  //  openedpath=indexPath;
    
    
    
    for (int i=0;i<openmodelarr.count;i++) {
        OpenModel *model =[openmodelarr objectAtIndex:i];
        
        if (model.modelindexpath.row==button.section) {
            
//            needopenmodel=[[OpenModel alloc]init];
//            needopenmodel.modelindexpath=indexPath;
            if (model.haveOpen==YES) {
                
                
                //删除行
                
                
                
                
                
                
                
                
                model.haveOpen=NO;
                [button setCustomSelect:NO];
                
                
                
                
                NSMutableArray *tmparr=[[NSMutableArray alloc]initWithArray:[tmptagContentarrArr objectAtIndex:button.section]];
                
                NSInteger contentCount = [tmparr count];
                //
                NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
                
                for (NSUInteger j = 0; j < contentCount; j++) {
                    
                    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:j inSection:button.section];
                    
                    [rowToInsert addObject:indexPathToInsert];
                    
                }
                
                //[tmparr removeAllObjects];
                
               
                
                [self.tableView beginUpdates];
                [tagContentarrArr replaceObjectAtIndex:button.section withObject:@[]];
                [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
                
                
                
                
                
                
                
                
            } else {
                
                
                //插入行
                
                
             
//                needopenmodel.haveOpen=YES;
                
                
                
                
                
                
                if (model.havepress==NO) {
                    
                    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
                    [HUD showInView:self.view];
                    [HUD dismissAfterDelay:3.0];

                    
                    
                    [PatientDataService getTagPatientsWithTagid:model.sectionid block:^(id resparr) {
                        
                        
                        
                        
                        NSLog(@"%@",resparr);
                        NSLog(@"%@",resparr);
                        
                        
                          NSMutableArray *tmparr=[[NSMutableArray alloc]init];
                        
                        for (NSDictionary * dic in resparr) {
                            [tmparr addObject:dic];
                        }
                        
                        
                         [tmptagContentarrArr replaceObjectAtIndex:button.section  withObject:tmparr];
                        
                        
                        [HUD dismiss];
                        
                        
                        NSInteger contentCount = [resparr count];
                        //
                        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
                        
                        for (NSUInteger k = 0; k < contentCount; k++) {
                            
                            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:k inSection:button.section];
                            
                            [rowToInsert addObject:indexPathToInsert];
                            
                        }
                        
                        [self.tableView beginUpdates];
                        [tagContentarrArr replaceObjectAtIndex:button.section withObject:tmparr];
                        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
                        [self.tableView endUpdates];
                        
                        
                        
                        
                        model.haveOpen=YES;
                        model.havepress=YES;

                         [button setCustomSelect:YES];
                        
                        
                        
                        
                        
                        
                        
                        
                        //  [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:section inSection:0]];
                        
                    }];

                    
                    
                    
                    
                    
                    
                    
                    
                    
                    //[self loaddetailsArrWithSection:indexPath.section row:indexPath.row subrow: indexPath.subRow];
                }else{
                    
                    NSMutableArray *tmparr1=[tmptagContentarrArr objectAtIndex:button.section];
                    
                    NSLog(@"%@",tmparr1);
                    NSInteger contentCount = [tmparr1 count];
                    //
                    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
                    
                    for (NSUInteger a = 0; a < contentCount; a++) {
                        
                        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:a inSection:button.section];
                        
                        [rowToInsert addObject:indexPathToInsert];
                        
                    }
                    
                    [self.tableView beginUpdates];
                    [tagContentarrArr replaceObjectAtIndex:button.section withObject:tmparr1];
                    [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
                    [self.tableView endUpdates];

                    
                    
                    model.haveOpen=YES;
                    model.havepress=YES;

                     [button setCustomSelect:YES];
                    
                    
                    
                    
                }
                
            }
            
        }
        [openmodelarr replaceObjectAtIndex:i withObject:model];
        
    }
 
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *arr=[tagContentarrArr objectAtIndex:section];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    
    if (!cell){
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSMutableArray *myarr=[tagContentarrArr objectAtIndex:indexPath.section];
    
    NSDictionary *dic=(NSDictionary *)[myarr objectAtIndex:indexPath.row];
    // cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   // cell.backgroundColor=KBackgroundColor;
    
    
    
    
    
    
    
    
    
    
    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 40, 40)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =20.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [cell addSubview:imagev];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(62, 11, 90, 30);
    label.textColor=KBlackColor;
    label.font=[UIFont systemFontOfSize:17.0];
    label.backgroundColor=[UIColor clearColor];
    [cell addSubview:label];
    
    //label.text=
    NSString *contentstring=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    //
    NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
    //
    //
    label.attributedText=astring;
    
    
    
    
    
    [UserDataService getUserInfofortargetIdWithtargetId:[dic objectForKey:@"id"] block:^(id userinfomodel) {
        UserInfoModel *model=(UserInfoModel *)userinfomodel;
        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
        label.text=model.username;
        
        
    }];
    
    
    
    
    
    
    
    
//    
//    CutomUIButton *button=[CutomUIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(0, 0, ScreenWidth, 60);
//    button.section=indexPath.section;
//    button.row=indexPath.row;
//    button.subrow=indexPath.subRow;
//    
//    button.alpha=0.1;
//    [button addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchDown];
//    [button addTarget:self action:@selector(canclebuttonaction:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
//    [cell addSubview:button];
//    
    CutomUIButton *tagbutton=[CutomUIButton buttonWithType:UIButtonTypeCustom];
    tagbutton.frame=CGRectMake(ScreenWidth-80, 52/2.0-20/2.0, 70, 20);
    tagbutton.section=indexPath.section;
    tagbutton.layer.cornerRadius=2.0;
    tagbutton.row=indexPath.row;
    tagbutton.subrow=indexPath.subRow;
    tagbutton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    // tagbutton.backgroundColor=KlightOrangeColor;
    tagbutton.layer.borderWidth = 1.0;
    tagbutton.layer.borderColor = [KtextGrayColor CGColor];
    // tagbutton.frame=CGRectMake(ScreenWidth-70, 60/2.0-25/2.0, 60, 25);
    [tagbutton setTitle:@"添加标签" forState:UIControlStateNormal];
    [tagbutton setTitleColor:KtextGrayColor forState:UIControlStateNormal];
    [tagbutton addTarget:self action:@selector(tagbuttonaction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:tagbutton];
      NSMutableArray *arr=[tagContentarrArr objectAtIndex:indexPath.section];
    if (indexPath.row!=arr.count-1) {
        UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(62, 51, ScreenWidth-15, 1)];
        lineview.backgroundColor=KLineColor;
        lineview.alpha=0.6;
        [cell addSubview:lineview];

    }
    
   
//
        
    return cell;
}
-(void)openedit:(CutomUIButton *)mycommentmodel{
//    commentmodel=mycommentmodel;
//    
//    
//    
//    //UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"修改组名",@"编辑组顺序",@"删除该组",@"添加标签", nil];
//    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"修改名称", nil];
//    [actionsheet showInView:self.view];
    
}
-(void)deletetagaction:(CutomUIButton *)button{
    
    //    _contents = [[NSMutableArray alloc]initWithArray: @[
    //                                                        [[NSMutableArray alloc]initWithArray:@[
    //                                                        [[NSMutableArray alloc]initWithArray: @[@"分组0", @"Row0_Subrow1",@"Row0_Subrow2"]],
    //                                                         ]]]];
    
 
    
    
    
//    [PatientDataService updateTagWithTagid:[[tmpdic objectForKey:@"tag"]objectForKey:@"id"] tagStr:@"haha" block:^(id respdic) {
//        [self loaddetailsArrWithSection:button.section row:button.row subrow:button.section];
//    }];
    
    
    
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    NSLog(@"%zd",buttonIndex);
    
    
    
    if (buttonIndex==0) {
        
      
        
        OpenModel *model=[openmodelarr objectAtIndex:commentmodel.section];
        TagsRenameViewController *vc = [[TagsRenameViewController alloc] init];
        vc.delegate=self;
        vc.tagid=model.sectionid;
        vc.tagstr=model.sectionTitle;
        [self.navigationController pushViewController:vc animated:YES];

        
    }
    
    
    
}


-(void)addtagbtnaction{
    // NSDictionary *tmpdic=self.contents[commentmodel.section][commentmodel.row][0];
    TagsRenameViewController *vc = [[TagsRenameViewController alloc] init];
    vc.delegate=self;
    vc.isadd=YES;
    //    vc.tagid=[[tmpdic objectForKey:@"tag"] objectForKey:@"id"];
    //    vc.tagstr=[[tmpdic objectForKey:@"tag"] objectForKey:@"tag"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)addwithdic:(NSDictionary *)tagdic{
//    [self.selectedArray addObject:tagdic];
//    [self.tableView reloadData];
    [self getdata];
}


-(void)reloanewtagsdata{
    //排序结束
    [self getdata];
}

-(void)reloadrenametags{
    //重新命名
     [self getdata];
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"UITableViewCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    cell=nil;
//    
//    if (!cell)
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    NSDictionary *dic=(NSDictionary *)self.contents[indexPath.section][indexPath.row][indexPath.subRow];
//   // cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//  //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.backgroundColor=KBackgroundColor;
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    UIImageView *imagev;
//    //=[[UIImageView alloc]init];
//    
//    
//    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 44, 44)];
//    //   imagev.frame=CGRectMake(10, 8, 44, 44);
//    
//    
//    
//    
//    imagev.clipsToBounds=YES;
//    
//    imagev.layer.masksToBounds=YES;
//    imagev.layer.cornerRadius =22.0;
//    imagev.layer.borderColor = [UIColor clearColor].CGColor;
//    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    
//    // imagev.image=[UIImage imageNamed:@"KAKA"];
//    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
//    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//    [cell addSubview:imagev];
//    
//    UILabel *label=[[UILabel alloc]init];
//    label.frame=CGRectMake(60, 8, 90, 30);
//    label.textColor=KBlackColor;
//    label.font=[UIFont systemFontOfSize:16.0];
//    label.backgroundColor=[UIColor clearColor];
//    [cell addSubview:label];
//    
//    //label.text=
//    NSString *contentstring=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
////    
//    NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
////    
////    
//    label.attributedText=astring;
//
//    
//    
//    
//    
//    [UserDataService getUserInfofortargetIdWithtargetId:[dic objectForKey:@"id"] block:^(id userinfomodel) {
//        UserInfoModel *model=(UserInfoModel *)userinfomodel;
//        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        label.text=model.username;
//        
//        
//    }];
//
//    
//    
//    
//    
//    
//    
//    
//
//    CutomUIButton *button=[CutomUIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(0, 0, ScreenWidth, 60);
//    button.section=indexPath.section;
//     button.row=indexPath.row;
//     button.subrow=indexPath.subRow;
//    
//    button.alpha=0.1;
//    [button addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchDown];
//    [button addTarget:self action:@selector(canclebuttonaction:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
//    [cell addSubview:button];
//    
//    CutomUIButton *tagbutton=[CutomUIButton buttonWithType:UIButtonTypeCustom];
//    tagbutton.frame=CGRectMake(ScreenWidth-70, 60/2.0-25/2.0, 60, 25);
//    tagbutton.section=indexPath.section;
//    tagbutton.layer.cornerRadius=5.0;
//    tagbutton.row=indexPath.row;
//    tagbutton.subrow=indexPath.subRow;
//   // tagbutton.backgroundColor=KlightOrangeColor;
//    tagbutton.layer.borderWidth = 1.0;
//    tagbutton.layer.borderColor = [KlightOrangeColor CGColor];
//   // tagbutton.frame=CGRectMake(ScreenWidth-70, 60/2.0-25/2.0, 60, 25);
//    [tagbutton setTitle:@"编辑" forState:UIControlStateNormal];
//    [tagbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
//    [tagbutton addTarget:self action:@selector(tagbuttonaction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell addSubview:tagbutton];
//    
//    return cell;
//}



-(void)longPress:(CustomLongPressGestureRecognizer *)longPressGR{
    //self.view.userInteractionEnabled=NO;
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   // self.view.userInteractionEnabled=YES;
    if (buttonIndex==1) {
        openedpath=[NSIndexPath indexPathForRow:commentLongRecognizer.row inSection:commentLongRecognizer.section];
        openedpath.subRow=commentLongRecognizer.subrow;
        
        [self.contents[commentLongRecognizer.section][commentLongRecognizer.row] removeObjectAtIndex: commentLongRecognizer.subrow];
        
//        [self reloadTableViewWithData:self.contents];
 
    }
}


-(void)tagbuttonaction:(CutomUIButton *)button{
    NSMutableArray *myarr=[tagContentarrArr objectAtIndex:button.section];
    
    NSDictionary *dic=(NSDictionary *)[myarr objectAtIndex:button.row];//获取单个患者数据
    
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
    
//    
//    JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
//    [hud showInView:self.view];
//    [hud dismissAfterDelay:5];
//    [PatientDataService getPatientTagsWithPatientId:[dic objectForKey:@"id"] block:^(id resparr) {
//        NSArray *selectedArray=(NSArray *)resparr;
//        
//        
//        
////        NSArray *selectedArray = @[@"头条",@"热点"];
////        
//        
//        
//        
//        
//        [PatientDataService getAlltagsblock:^(id resparr1) {
//            [hud dismiss];
//             NSMutableArray *optionalArray =[[NSMutableArray alloc]initWithArray:resparr1];
//            for (NSDictionary * dic in selectedArray) {
//                if ([optionalArray containsObject:dic]) {
//                    [optionalArray removeObject:dic];
//                }
//            }
//            
//            
//            
//            
//            
//         
//
//        }];
//        
//        
////        NSArray *optionalArray = @[@"画报",@"跑步",@"值得买",@"酒香",@"LOL",@"社会"];
//        
//        
//        
//        
//        
//        
//    }];

}
-(void)reloadtagsdata{
    [self getdata];
}
- (void)canclebuttonaction:(CutomUIButton *)button{
  //  button.alpha=0.1;
    timercount=0;
    
    
    [timer invalidate];
    
   [self sectionbtnaction:button];
    
 
    commentmodel=button;
    
}

- (void)buttonaction:(CutomUIButton *)button{
    commentmodel=button;
    timercount=0;
    [timer invalidate];
    timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(deletecell:) userInfo:nil repeats:YES];
    [timer fire];
    //[[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
   
    
}
-(void)deletecell:(NSTimer *)cutimer{
  //  commentLongRecognizer.alpha=0.0;
    if (timercount<1) {
        timercount++;
       
    } else {
        timercount=0;
         [timer invalidate];
        UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"修改名称", nil];
        [actionsheet showInView:self.view];

    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSMutableArray *myarr=[tagContentarrArr objectAtIndex:indexPath.section];
    
    NSDictionary *dic=(NSDictionary *)[myarr objectAtIndex:indexPath.row];
    
//    [OrderDataService CreateorderWithPatientID:[dic objectForKey:@"id"] doctorId:nil block:^(id resp) {
//        NSLog(@"chenggong");
//    }];
    
    
    UITableViewCell *cell=(UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected=NO;
    //跳到会话
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
                conversationPageVC.patientd=[dic objectForKey:@"id"];
                //    self.tabBarController.navigationController.tabBarController.navigationController.navigationBar.hidden=NO;
                [self.navigationController pushViewController:conversationPageVC animated:YES];
    
    
                
                
                
            }];
            
            
            
            
        }];
    
        
        

    
}



@end
