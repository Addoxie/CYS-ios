//
//  InvitefriendsViewController.m
//  ByShare
//
//  Created by 谢阳晴 on 14/12/5.
//  Copyright (c) 2014年 谢阳晴. All rights reserved.
//

#import "InvitefriendsViewController.h"
#import "ZCAddressBook.h"
#import "pinyin.h"
#import "JGProgressHUD.h"
#import "itemdetailbutton.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


#import "itemdetailbutton.h"

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface InvitefriendsViewController (){
    UISegmentedControl *segmentctrl;
    UIBarButtonItem *sureitem;
    UISwitch *myswitch;
    UILabel *contactcountlable;
    NSInteger mytruecontactcount;
    JGProgressHUD *HUD;
    itemdetailbutton *invitebutton;
    itemdetailbutton *sentbutton;
    NSMutableArray *arr;
    NSMutableArray *indexarr;
    NavBarView *mybarview;
    UIView *bgview;
    UIButton *backbutton;
    UIButton *backbutton1;
    UIView *mybgv;
    UIButton *morebutton;
}

@end

@implementation InvitefriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
    arr=[[NSMutableArray alloc]init];
    indexarr=[[NSMutableArray alloc]init];
    self.dataArr=[[NSMutableArray alloc]init];
    self.indexdataArr=[[NSArray alloc]init];
    self.indexdataArr=[[ZCAddressBook shareControl]sortMethod];

    NSArray *itemsnamearr=@[@"By Email",@"By Text"];
    segmentctrl=[[UISegmentedControl alloc]initWithItems:itemsnamearr];
    segmentctrl.frame=CGRectMake(-3, 64, ScreenWidth+6, 46);
    segmentctrl.selectedSegmentIndex=0;
    segmentctrl.backgroundColor=[UIColor whiteColor];
    segmentctrl.tintColor=[UIColor grayColor];
    segmentctrl.selectedSegmentIndex=1;
    

  
    
    UIBarButtonItem *nilitem=[[UIBarButtonItem alloc]init];
    self.navigationItem.rightBarButtonItem=nilitem;
    self.indexdataArr=[[NSArray alloc]init];
    self.indexdataArr=[[ZCAddressBook shareControl]sortMethod];
    
    self.thedatadic=[[NSMutableDictionary alloc]init];
    self.thedatadic=[[[ZCAddressBook shareControl]getPersonInfo] objectForKey:@"dic"];
    self.tmpdatadic=[[NSMutableDictionary alloc]init];
    self.tmpdatadic=[[[ZCAddressBook shareControl]getPersonInfo] objectForKey:@"dic"];
   
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight-104) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:) name:@"UITextFieldTextDidEndEditingNotification" object:self.textfield];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditingChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.textfield];
    
    mybgv=[[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 60)];
    mybgv.backgroundColor=KBackgroundColor;
    
    self.textfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 40)];
    self.textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textfield.delegate=self;
    self.textfield.layer.masksToBounds = YES;
    self.textfield.layer.cornerRadius = 3.0;
    self.textfield.layer.borderWidth = 1.0;
    self.textfield.layer.borderColor = [[UIColor clearColor] CGColor];
    
    self.textfield.backgroundColor=[UIColor whiteColor];
    self.textfield.placeholder=@"🔍 输入联系人姓名";
    self.textfield.tintColor=KlightOrangeColor;
    [mybgv addSubview:self.textfield];
    
    backbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    backbutton.frame=CGRectMake(ScreenWidth-70, 0, 60, 60);
    backbutton.tag=3011;
    [backbutton setTitle:@"取消" forState:UIControlStateNormal];
    [backbutton setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backbtnaction:) forControlEvents:UIControlEventTouchUpInside];
   // [mybgv addSubview:backbutton];
    
    backbutton1=[UIButton buttonWithType:UIButtonTypeCustom];
    backbutton1.tag=3012;
    backbutton1.frame=CGRectMake(ScreenWidth-70, 0, 60, 60);
    [backbutton1 setTitle:@"完成" forState:UIControlStateNormal];
    [backbutton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backbutton1 addTarget:self action:@selector(backbtnaction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:mybgv];
    
    

    
    if (self.needsearch) {
        
        [self.textfield becomeFirstResponder];
    }

    
    //区头索引字母的颜色
    
    
    self.tableView.sectionIndexColor = KLineColor;
    
       //索引的背景颜色
    
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    mybarview.navbarTitle=[NSString stringWithFormat:@"%@",@"手机通讯录"];
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    self.selecteddataArr=[[NSMutableArray alloc]init];
        

    
    
    morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(ScreenWidth-65, 29, 65, 30);;
    
    [morebutton setTitle:@"保存" forState:UIControlStateNormal];
    //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
   // [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
    
    [mybarview addSubview:morebutton];
    
    
    // Do any additional setup after loading the view.
}
-(void)morebuttonaction{
    NSLog(@"%@",self.selecteddataArr);
    if (self.selecteddataArr.count!=0||self.haveselecteddataArr.count!=0) {
//        [PatientDataService invitePatientWithPatientID:editdataarr teamId:self.docteamid block:^(id responsedic) {
//            [hud dismiss];
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"已添加"];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"addmembers" object:nil];
//            if (self.isnewteam) {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }else{
//                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//            }
//        }];
        
        
       // if (self.haveselecteddataArr.count!=0) {
           // self.selecteddataArr=[[NSMutableArray alloc]initWithArray:self.haveselecteddataArr];
        [self.selecteddataArr addObjectsFromArray:self.haveselecteddataArr];
      //  }
        
        [self.delegate sentselectedcontacts:self.selecteddataArr];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"您还没选择联系人"];
        
    }

    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [bgview removeFromSuperview];
//    [backbutton removeFromSuperview];
//    [self.view addSubview:backbutton1];
    
    bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 84, ScreenWidth, ScreenHeight-84)];
    
    textField.frame=CGRectMake(10, 10, ScreenWidth-90, 40);
    mybgv.frame=CGRectMake(0, 24, ScreenWidth, 60);
    [mybgv addSubview:backbutton];
    self.tableView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
    mybarview.hidden=YES;
    bgview.backgroundColor=[UIColor blackColor];
    bgview.tag=3003;
    bgview.alpha=0.6;
    [self.view addSubview:bgview];
    
}
-(void)backbtnaction:(UIButton *)button{
    
    if (button.tag==3012) {
        [self.textfield resignFirstResponder];
        [self.selecteddataArr removeAllObjects];
    }else{
        for (UIView *subv in self.view.subviews) {
            if (subv==bgview) {
                [subv removeFromSuperview];
            }
        }

        [self.textfield resignFirstResponder];
      //  [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
     [bgview removeFromSuperview];
    for (UIView *subv in self.view.subviews) {
        if (subv==bgview) {
            [subv removeFromSuperview];
        }
    }
    textField.frame=CGRectMake(10, 10, ScreenWidth-20, 40);
    mybgv.frame=CGRectMake(0, 64, ScreenWidth, 60);
    [backbutton removeFromSuperview];
    [backbutton1 removeFromSuperview];
    self.tableView.frame=CGRectMake(0, 104, ScreenWidth, ScreenHeight-104);
    mybarview.hidden=NO;

}
- (void)textViewEditingChanged:(NSNotification *)sender{
    if (self.textfield.text.length==0) {
        [backbutton1 removeFromSuperview];
        [mybgv addSubview:backbutton];
    }else{
        [backbutton removeFromSuperview];
        [mybgv addSubview:backbutton1];
       
    }
}
- (void)textViewEditChanged:(NSNotification *)sender{
    
    if (self.textfield.text.length==0) {
        //[bgview removeFromSuperview];
//        bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 84, ScreenWidth, ScreenHeight-84)];
//        bgview.backgroundColor=[UIColor blackColor];
//        bgview.alpha=0.6;
//        [self.view addSubview:bgview];
        self.thedatadic=[[[ZCAddressBook shareControl]getPersonInfo] objectForKey:@"dic"];

        [self.tableView reloadData];
    }else{
        //处理数据
       // [bgview removeFromSuperview];
        [self.tmpdatadic removeAllObjects];
        self.tmpdatadic=[[NSMutableDictionary alloc]init];
       self.tmpdatadic=[[[ZCAddressBook shareControl]getPersonInfo] objectForKey:@"dic"];
        self.resultdatadic=[[NSMutableDictionary alloc]init];
        
        NSArray *keyarr=[self.tmpdatadic allKeys];
       
        for (int i=0;i<keyarr.count;i++) {
        NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:i]];
            NSMutableArray *myarr=[self.tmpdatadic objectForKey:key];
            NSMutableArray *tmparr=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in myarr) {
                
                
                if([[dic objectForKey:@"name"] rangeOfString:self.textfield.text].location !=NSNotFound)//
                {
                    [tmparr addObject:dic];
                }
                
                 
            }
            [self.resultdatadic setObject:tmparr forKey:key];
            
        }
        
        [self.thedatadic removeAllObjects];
        self.thedatadic=self.resultdatadic;
//        NSLog(@"%@",self.tmpdatadic);
//        NSLog(@"%@",self.thedatadic);
        
        [self.tableView reloadData];
      

        
        
        
    }
    
    
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
    
    
    if (self.haveselecteddataArr.count==0) {
        [self.selecteddataArr removeAllObjects];
        [self.delegate sentselectedcontacts:self.selecteddataArr];
        [self.navigationController popViewControllerAnimated:YES];

    }else{
       [self.navigationController popViewControllerAnimated:YES];
    }
    
    
   
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [bgview removeFromSuperview];
    return YES;
}
-(void)cancleitemaction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitbtnaction{
    
//    
//    for (NSInteger i=10000; i<self.dataArr.count+10000; i++) {
//        
//        itemdetailbutton *button=(itemdetailbutton *)[self.view viewWithTag:i+1];
//    
//        if (button.havePressed==YES) {
//            [self.dataArr removeObjectAtIndex:i-10000];
//            NSIndexPath *path=[NSIndexPath indexPathForItem:i-10000+1 inSection:0];
//            [arr addObject:path];
//        }
//       
//     
////    }
//    if (myswitch.on==NO) {
//        if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]!=nil) {
//            NSLog(@"%@",arr);
//           
//          
//            [self.tableView beginUpdates];
//             [self.dataArr removeObjectsInArray:indexarr];
//             [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationLeft];
//            
//            [self.tableView endUpdates];
//            [self.tableView reloadData];
//        
//            [indexarr removeAllObjects];
//            [arr removeAllObjects];
//    }
//
//    }else{
//        
//        if ([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]!=nil) {
//          NSLog(@"%zd",arr.count);
//          [self.tableView beginUpdates];
//          [self.dataArr removeAllObjects];
//          [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationLeft];
//          
//          [self.tableView endUpdates];
//            [arr removeAllObjects];
//
//    }
//    }
//    
    
}
-(void)segmentaction:(UISegmentedControl *)segment{
//    [self.tableView removeFromSuperview];
//    if (segment.selectedSegmentIndex==0) {
//         self.navigationItem.rightBarButtonItem=sureitem;
//        self.dataArr=[[[ZCAddressBook shareControl]getPersonInfo] objectForKey:@"emaildic"];
//        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 46, ScreenWidth, ScreenHeight-46-64-49) style:UITableViewStylePlain];
//        self.tableView.delegate=self;
//        self.tableView.dataSource=self;
//        [self.view addSubview:self.tableView];
//        UIView *mailiconv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
//        mailiconv.backgroundColor=[UIColor whiteColor];
//        UIImageView *iconimagev=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-80/2, 100/2-80/2, 80, 80)];
//        iconimagev.image=[UIImage imageNamed:@"touxiang"];
//        [mailiconv addSubview:iconimagev];
//        self.tableView.tableHeaderView=mailiconv;
//         [self.tableView reloadData];
//    } else {
//        UIBarButtonItem *nilitem=[[UIBarButtonItem alloc]init];
//        self.navigationItem.rightBarButtonItem=nilitem;
//        self.indexdataArr=[[NSArray alloc]init];
//        self.indexdataArr=[[ZCAddressBook shareControl]sortMethod];
//        
//        self.thedatadic=[[NSMutableDictionary alloc]init];
//        self.thedatadic=[[[ZCAddressBook shareControl]getPersonInfo] objectForKey:@"dic"];
//     
//       self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, ScreenHeight-46-64-49) style:UITableViewStyleGrouped];
//        self.tableView.delegate=self;
//        self.tableView.dataSource=self;
//        [self.view addSubview:self.tableView];
//        //区头索引字母的颜色
//        
//        
//        self.tableView.sectionIndexColor = [UIColor redColor];
//        
//        
//        
//        //索引的背景颜色
//        
//
//        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//        UIView *mailiconv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
//         mailiconv.backgroundColor=[UIColor whiteColor];
//        UIImageView *iconimagev=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-80/2, 100/2-80/2, 80, 80)];
//        iconimagev.image=[UIImage imageNamed:@"touxiang"];
//        [mailiconv addSubview:iconimagev];
//        self.tableView.tableHeaderView=mailiconv;
//        [self.tableView reloadData];
//    }
//    
   
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (segmentctrl.selectedSegmentIndex==1) {
        NSMutableArray *indices = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
        for (int i = 0; i < 27; i++)
            [indices addObject:[[ALPHA substringFromIndex:i] substringToIndex:1]];
        //[indices addObject:@"\ue057"]; // <-- using emoji
        return indices;
    } else {
        return nil;
    }
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (segmentctrl.selectedSegmentIndex==0) {
        return 1;
    } else {
        return [[self.thedatadic allKeys]count];
    }
  
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ( segmentctrl.selectedSegmentIndex==1) {
        
        
        if ([[self.thedatadic allKeys] objectAtIndex:section]==nil) {
            return nil;
        }else{
            NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
            NSArray *arr=(NSArray *)[self.thedatadic objectForKey:key];
            if ([arr count]!=0) {
                return key;
            }else{
               return nil;
           
            }
        }
    } else {
        return nil;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    
    if ([[self.thedatadic allKeys] objectAtIndex:section]==nil) {
        return 0;
    }else{
        NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
        NSArray *arr=(NSArray *)[self.thedatadic objectForKey:key];
        if ([arr count]!=0) {
           
                return 30;
            
        }else{
            return 0;
            
        }
    }}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (segmentctrl.selectedSegmentIndex==0) {
        return self.dataArr.count+1;
    }else{
    NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:section]];
        NSArray *arr=(NSArray *)[self.thedatadic objectForKey:key];
    return [arr count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    if (segmentctrl.selectedSegmentIndex==0) {
//        if (indexPath.row==0) {
//            contactcountlable=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, ScreenWidth/2, 40)];
//            contactcountlable.textAlignment=NSTextAlignmentLeft;
//            contactcountlable.text=[NSString stringWithFormat:@"%zd %@",mytruecontactcount,@" contacts picked"];
//            contactcountlable.font=[UIFont systemFontOfSize:13.0];
//            [cell addSubview:contactcountlable];
//            UILabel *eventlabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2+35, 2, 60, 40)];
//            eventlabel.textAlignment=NSTextAlignmentLeft;
//            eventlabel.text=[NSString stringWithFormat:@"%@",@"Invite all"];
//            eventlabel.font=[UIFont systemFontOfSize:13.0];
//            [cell addSubview:eventlabel];
//            myswitch=[[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth-60, 6, 80, 44-6*2)];
//            //self.myswitch.on;
//            [myswitch addTarget:self action:@selector(myswitchAction:) forControlEvents:UIControlEventValueChanged];
//            myswitch.onTintColor=[UIColor redColor];
//            [cell.contentView addSubview:myswitch];
//            
//            
//        } else {
//            NSDictionary *dic=[[NSDictionary alloc]init];
//            dic=[self.dataArr objectAtIndex:indexPath.row-1];
//            cell.textLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//            cell.detailTextLabel.text=[dic objectForKey:@"email"];
//            invitebutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
//            invitebutton.frame=CGRectMake(ScreenWidth-90, 2, 80, 40);
//            invitebutton.tag=indexPath.row+10000;
//            invitebutton.havePressed=NO;
//            invitebutton.layer.masksToBounds = YES;
//            invitebutton.layer.cornerRadius = 6.0;
//            invitebutton.layer.borderWidth = 1.0;
//            invitebutton.layer.borderColor = [[UIColor whiteColor] CGColor];
//            [invitebutton setTitle:@"Invite" forState:UIControlStateNormal];
//            [invitebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            invitebutton.backgroundColor=[UIColor redColor];
//            [invitebutton addTarget:self action:@selector(inviteaction:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:invitebutton];
//        }
    } else {
       
      
       
      
//        sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
//        sentbutton.frame=CGRectMake(ScreenWidth-110, 5, 80, 40-6);
//        sentbutton.tag=indexPath.row+20000;
//        sentbutton.buttonlocation=indexPath.section;
//        sentbutton.layer.masksToBounds = YES;
//        sentbutton.layer.cornerRadius = 6.0;
//        sentbutton.layer.borderWidth = 1.0;
//        sentbutton.layer.borderColor = [KlightOrangeColor CGColor];
//        [sentbutton setTitle:@"邀请" forState:UIControlStateNormal];
//        [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        sentbutton.backgroundColor=KlightOrangeColor;
//        [sentbutton addTarget:self action:@selector(sentmsgaction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:sentbutton];
        
        
        
        
       
        // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
        
        
//        if (self.isaddpatient) {
//            sentbutton.frame=CGRectMake(ScreenWidth-70, 2, 40, 40);
//            [sentbutton setTitle:@"添加" forState:UIControlStateNormal];
//            
//        }else{
//            sentbutton.frame=CGRectMake(ScreenWidth-70, 10, 40, 40);
//            [sentbutton setTitle:@"邀请" forState:UIControlStateNormal];
//
//        }
        
        NSDictionary *dic=[[NSDictionary alloc]init];
        NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:indexPath.section]];
        dic=[[self.thedatadic objectForKey:key] objectAtIndex:indexPath.row];
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        cell.detailTextLabel.text=[dic objectForKey:@"telphone"];
        NSLog(@"%@",dic);
        
        itemdetailbutton *checkbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
        checkbutton.tag=indexPath.row+200000000;
        checkbutton.frame=CGRectMake(ScreenWidth-70, 2, 40, 40);
        checkbutton.buttonlocation=indexPath.section;
        checkbutton.keystr=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:indexPath.section]];
        checkbutton.layer.masksToBounds = YES;
        checkbutton.layer.cornerRadius = 20.0;
        checkbutton.layer.borderWidth = 1.0;
        checkbutton.layer.borderColor = [[UIColor clearColor] CGColor];
        
        
        
        
        
        
        
        if ([dic objectForKey:@"selectstate"]) {
            if ([[dic objectForKey:@"selectstate"]isEqualToString:@"unselect"]) {
                // [sentbutton setImage:[UIImage imageNamed:@"tmp"] forState:UIControlStateNormal];
                checkbutton.selected=NO;
                checkbutton.havePressed=NO;
            }else{
                
                checkbutton.selected=YES;
                checkbutton.havePressed=YES;
            }
            
        }
        
        if (self.haveselecteddataArr.count!=0) {
            for (NSDictionary *tmpdic in self.haveselecteddataArr) {
                if ([[dic objectForKey:@"name"]isEqualToString:[tmpdic objectForKey:@"name"]]) {
                    checkbutton.selected=YES;
                    checkbutton.havePressed=YES;
                }
            }
        }
        
        
        [checkbutton setImage:[UIImage imageNamed:@"select_1"] forState:UIControlStateNormal];
        [checkbutton setImage:[UIImage imageNamed:@"select_2"] forState:UIControlStateSelected];
        // [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        checkbutton.backgroundColor=[UIColor clearColor];
        checkbutton.section=indexPath.section;
        [checkbutton addTarget:self action:@selector(editaction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:checkbutton];
        
        
        
        
        
        
        
        
        
        
        
        

    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)editaction:(itemdetailbutton *)button{
    
  
    
    
    
//    for (NSDictionary *tmpdic in self.selecteddataArr) {
//        if ([[dic objectForKey:@"name"]isEqualToString:[tmpdic objectForKey:@"name"]]) {
//            checkbutton.selected=YES;
//            checkbutton.havePressed=YES;
//        }
//    }
    
    
    
    
    
    if (button.havePressed==NO) {
        
        button.selected=YES;
        button.havePressed=YES;
        
        
        
        
       // NSDictionary *dic=[[NSDictionary alloc]init];
        NSString *key=button.keystr;
        
        NSMutableArray *tmparr=[[NSMutableArray alloc]initWithArray:[self.thedatadic objectForKey:key]];
        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]initWithDictionary:self.thedatadic];

        
        NSMutableDictionary *datadic=[[NSMutableDictionary alloc]initWithDictionary:[tmparr objectAtIndex:button.tag-200000000]];

        
        
        [datadic setValue:@"selected" forKey:@"selectstate"];
        
        [tmparr replaceObjectAtIndex:button.tag-200000000 withObject:datadic];
        
        [tmpdic setObject:tmparr forKey:key];
        
        [self.thedatadic removeAllObjects];
        
        self.thedatadic=tmpdic;
        
        [self.selecteddataArr addObject:datadic];
        
        
        
        
//        NSLog(@"%@",tmparr);
//        
//        NSLog(@"%@",tmpdic);

   
        
    }else{
        button.selected=NO;
        button.havePressed=NO;
        
       // NSMutableDictionary *datadic;
        
        // NSDictionary *dic=[[NSDictionary alloc]init];
        NSString *key=button.keystr;
        
        NSMutableArray *tmparr=[[NSMutableArray alloc]initWithArray:[self.thedatadic objectForKey:key]];
        NSMutableDictionary *tmpdic=[[NSMutableDictionary alloc]initWithDictionary:self.thedatadic];
        
        
         NSMutableDictionary *datadic=[[NSMutableDictionary alloc]initWithDictionary:[tmparr objectAtIndex:button.tag-200000000]];
        
        
        
        [datadic setValue:@"unselect" forKey:@"selectstate"];
        
        [tmparr replaceObjectAtIndex:button.tag-200000000 withObject:datadic];
        
        // NSLog(@"%@",tmparr);
        
        
        [tmpdic setObject:tmparr forKey:key];
        
       //  NSLog(@"%@",tmpdic);
        
        [self.thedatadic removeAllObjects];
        
        self.thedatadic=tmpdic;
        
        [self.selecteddataArr removeObject:datadic];
        
        
        
        NSMutableArray *tmphaveselecteddataArr=[[NSMutableArray alloc]initWithArray:self.haveselecteddataArr];
        
        if (tmphaveselecteddataArr.count!=0) {
            for (NSDictionary *tmpdic in tmphaveselecteddataArr) {
                if ([[datadic objectForKey:@"name"]isEqualToString:[tmpdic objectForKey:@"name"]]) {
                      [self.haveselecteddataArr removeObject:tmpdic];
                }
            }
        }
    }
   [self.tableView reloadData];
    
}



















-(void)sentmsgaction:(itemdetailbutton *)button{
     NSString *key=[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:button.buttonlocation]];
     NSDictionary *dic=[[NSDictionary alloc]init];
    dic=[[self.thedatadic objectForKey:key] objectAtIndex:button.tag-20000];
    NSString *phonenum=[dic objectForKey:@"telphone"];

    
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if([MFMessageComposeViewController canSendText])
        
    {
        
        controller.body = @"hello";
        
        controller.recipients = @[phonenum];
        
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
    
}
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
   }

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
        else if (result == MessageComposeResultSent)
            NSLog(@"Message sent");
            else 
                NSLog(@"Message failed");  
}
-(void)myswitchAction:(UISwitch *)theswitch{
    if (theswitch.on==YES) {
        for (NSInteger i=10000; i<self.dataArr.count+10000; i++) {
            itemdetailbutton *button=(itemdetailbutton *)[self.tableView viewWithTag:i+1];
            button.havePressed=YES;
            [arr addObject:[NSIndexPath indexPathForItem:i-10000+1 inSection:0]];
            button.backgroundColor=[UIColor grayColor];
        }
    } else {
        for (NSInteger i=10000; i<self.dataArr.count+10000; i++) {
            itemdetailbutton *button=(itemdetailbutton *)[self.tableView viewWithTag:i+1];
            button.havePressed=NO;
            button.backgroundColor=[UIColor redColor];
        }
        [arr removeAllObjects];
    }
    
   
    
}
-(void)inviteaction:(itemdetailbutton *)button{

    if (button.havePressed==YES) {
        button.selected=YES;
        button.backgroundColor=[UIColor grayColor];
        
        NSIndexPath *path=[NSIndexPath indexPathForRow:button.tag-10000 inSection:0];
    
        NSDictionary *dic=[self.dataArr objectAtIndex:button.tag-10000-1];
        [indexarr addObject:dic];
        
        [arr addObject:path];
        NSLog(@"%@",arr);
        button.havePressed=NO;
    }else{
        button.selected=NO;
        button.havePressed=YES;
        button.backgroundColor=[UIColor redColor];
        NSIndexPath *path=[NSIndexPath indexPathForRow:button.tag-10000 inSection:0];
        [arr removeObject:path];
        NSDictionary *dic=[self.dataArr objectAtIndex:button.tag-10000-1];
        [indexarr removeObject:dic];

    }
    

}

@end
