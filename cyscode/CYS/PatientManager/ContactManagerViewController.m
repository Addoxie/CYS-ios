//
//  ContactManagerViewController.m
//  CYS
//
//  Created by 谢阳晴 on 15/12/23.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import "ContactManagerViewController.h"
#import "ZCAddressBook.h"
#import "pinyin.h"
#import "JGProgressHUD.h"
#import "itemdetailbutton.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "SearchNameViewController.h"
#import "AddDoctorViewController.h"
#import "ChineseString.h"

@interface ContactManagerViewController (){
    UISegmentedControl *segmentctrl;
    UIBarButtonItem *sureitem;
    UISwitch *myswitch;
    UILabel *contactcountlable;
    NSInteger mytruecontactcount;
    JGProgressHUD *HUD;
    itemdetailbutton *invitebutton;
    itemdetailbutton *sentbutton1;
    NSMutableArray *arr;
    NSMutableArray *indexarr;
    NavBarView *mybarview;
    UIView *bgview;
    UIButton *backbutton;
    UIButton *backbutton1;
    UIView *mybgv;
    
    UIButton *morebutton;
    UIView *buttonbgv;
    BOOL ismanager;
    UIControl *moreControl;
    BOOL haveshowmorebutton;
    NSInteger pagenum;
    NSMutableArray *dataarr;
    BOOL haveNextPage;
    BOOL isedit;
    BOOL havefooter;
    NSMutableArray *editdataarr;
    NSMutableArray *tmpdataarr;
    NSMutableArray *olddocarr;
}

@end


@implementation ContactManagerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    editdataarr=[[NSMutableArray alloc]init];
    self.isneedadd=YES;
    pagenum=0;
    haveNextPage=YES;
    dataarr=[[NSMutableArray alloc]init];
    if (self.dataArr.count!=0) {
        dataarr=self.dataArr;
        havefooter=NO;
    }else{
         havefooter=YES;
    }
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
    
   self.frienddataArr=[[NSMutableArray alloc]init];
    
    isedit=NO;
    
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
    self.tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditChanged:) name:@"UITextFieldTextDidEndEditingNotification" object:self.textfield];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewEditingChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.textfield];
    
    mybgv=[[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 60)];
    mybgv.backgroundColor=KBackgroundColor;
    
    
    
    
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
    [backbutton1 setTitle:@"搜索" forState:UIControlStateNormal];
    [backbutton1 setTitleColor:KlightOrangeColor forState:UIControlStateNormal];
    [backbutton1 addTarget:self action:@selector(backbtnaction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    if (dataarr.count==0) {
        [self.view addSubview:mybgv];
      
    }else{
     self.tableView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
    }
    
    
    self.tableView.backgroundColor=KBackgroundColor;
    if (self.needsearch) {
        
        [self.textfield becomeFirstResponder];
    }
    
    
//    //区头索引字母的颜色
//    
//    
//    self.tableView.sectionIndexColor = KLineColor;
//    
//    //索引的背景颜色
//    
//    
//    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    // Do any additional setup after loading the view.
    mybarview=[[NavBarView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 64)];
    mybarview.delegate=self;
    [mybarview setnavcanclecolor:[UIColor whiteColor]];
    if (self.isaddpatient) {
        mybarview.navbarTitle=[NSString stringWithFormat:@"%@",@"所有患者"];

    }else{
        mybarview.navbarTitle=[NSString stringWithFormat:@"%@",@"团队成员"];

    }
    [mybarview setnavcancletitle:@" 返回"];
    [mybarview setnavcancletimage:@"back"];
    mybarview.backgroundColor=KlightOrangeColor;
    [self.view addSubview:mybarview];
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    bgv.backgroundColor=KlightOrangeColor;
    [self.view addSubview:bgv];
    
    
    self.textfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-20, 40)];
    self.textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textfield.delegate=self;
    self.textfield.layer.masksToBounds = YES;
    self.textfield.layer.cornerRadius = 3.0;
    self.textfield.layer.borderWidth = 1.0;
    self.textfield.layer.borderColor = [[UIColor clearColor] CGColor];
    self.textfield.returnKeyType=UIReturnKeySearch;
    self.textfield.backgroundColor=[UIColor whiteColor];
    self.textfield.placeholder=@"🔍 输入姓名添加医生";
    self.textfield.tintColor=KlightOrangeColor;
    [mybgv addSubview:self.textfield];

    if (self.isnotneedmoreaction) {
        
    }else{
        morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        morebutton.frame=CGRectMake(ScreenWidth-65, 29, 65, 30);
        
        [morebutton setTitle:@"..." forState:UIControlStateNormal];
        //morebutton.titleLabel.font=[UIFont systemFontOfSize:30.0];
        //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
        [morebutton setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
        [morebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [morebutton addTarget:self action:@selector(morebuttonaction) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (self.hideRbtn) {
         morebutton.hidden=YES;   
        }
        //morebutton.hidden=YES;
        [mybarview addSubview:morebutton];
        
        [self setupmoreview];

    }
    if (havefooter) {
    
    [self addHeader];
    [self addFooter];
        
   }
    
    
//    [DocTeamDataService getTeamMembersWithteamId:self.docteamid block:^(id doctorDatadic) {
//        
//
//        
//        self.frienddataArr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
//        [self.tableView reloadData];
//    }];
    
    // Do any additional setup after loading the view.
    
}
-(void)morebuttonaction{
    
    if (isedit) {
        
        if (editdataarr.count!=0) {
            
            
            
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"确定删除医生？该医生导入的患者将会移出团队" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertview show];

        } else {
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"你还没选择"];
        }
        
        
    }else{
    //更多
    if (haveshowmorebutton==YES) {
        [buttonbgv removeFromSuperview];
        [moreControl removeFromSuperview];
        haveshowmorebutton=NO;
        
    } else {
        
        moreControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        moreControl.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [moreControl addTarget:self action:@selector(moreControlaction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:moreControl];
        [self.view addSubview:buttonbgv];
        
        
        
        haveshowmorebutton=YES;
    }
  }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    if (editdataarr.count==0) {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:@"尚未选择医生！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        return;

    }
   
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1) {
        JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];
        [hud dismissAfterDelay:5];
        
        [DocTeamDataService deletingdoctorsfromteamWithteamId:self.docteamid doctors:editdataarr block:^(id dic) {
            isedit=NO;
            [hud dismiss];
            //[self.tableView reloadData];
            [editdataarr removeAllObjects];
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"删除成功"];
            [self.delegate reloadmembers];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];

    }else if (buttonIndex==2) {
        //删除
        JGProgressHUD *hud=[[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
        [hud showInView:self.view];
        [hud dismissAfterDelay:5];
        
        [DocTeamDataService deletingdoctorsfromteamWithteamId:self.docteamid doctors:editdataarr block:^(id dic) {
            isedit=NO;
            [hud dismiss];
            //[self.tableView reloadData];
            [editdataarr removeAllObjects];
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"删除成功"];
            [self.delegate reloadmembers];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];

    }
}
-(void)moreControlaction:(UIControl *)control{
    [control removeFromSuperview];
    [buttonbgv removeFromSuperview];
    
    haveshowmorebutton=NO;
    
}



-(void)setupmoreview{
    if (self.isaddpatient) {
        
        
        buttonbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-133, 66, 130, 45*2)];
        buttonbgv.layer.cornerRadius=4.0;
        buttonbgv.backgroundColor=[UIColor whiteColor];
        // buttonbgv.alpha=0.7;
        
        
        
        
        NSArray *namearr=@[@"添加患者",@"删除患者"];
        NSArray *moreimagearr=@[@"xiangmuxinxi",@"xiangmudingdan",@"yuyueqianwang",@"xinxiaoxiliebiao"];
        for (int i=0; i<2; i++) {
            UIButton *morebutton1=[UIButton buttonWithType:UIButtonTypeCustom];
            morebutton1.frame=CGRectMake(0, 45*i, 130, 45);
            morebutton1.tag=1000000+i;
            [morebutton1 setImage:[UIImage imageNamed:[moreimagearr objectAtIndex:i]] forState:UIControlStateNormal];
            //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
            [morebutton1 setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 12, 130-21-15)];
            [morebutton1 setTitle:[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]] forState:UIControlStateNormal];
            morebutton1.layer.borderWidth=1.0;
            morebutton1.layer.borderColor=[UIColor clearColor].CGColor;
            morebutton1.titleLabel.font=[UIFont boldSystemFontOfSize:19.0];
            //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
            //[morebutton setImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
            [morebutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
            [morebutton1 addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonbgv addSubview:morebutton1];
            if (i!=1) {
                UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 45-0.7, 130, 0.7)];
                linev.backgroundColor=KLineColor;
                [morebutton1 addSubview:linev];
            }
        }
        
    } else {
        buttonbgv=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-133, 80, 130, 45*2)];
        buttonbgv.layer.cornerRadius=4.0;
        buttonbgv.backgroundColor=[UIColor whiteColor];
        //        buttonbgv.alpha=0.7;
        
        //        triageleview=[[TriangleView alloc]init];
        //
        //        triageleview.topPoint=CGPointMake(ScreenWidth-51, 66);
        //        triageleview.leftPoint=CGPointMake(ScreenWidth-51-5, 80);
        //        triageleview.rightPoint=CGPointMake(ScreenWidth-51+5, 80);
        //        triageleview.backgroundColor=[UIColor whiteColor];
        
        //        const CGFloat kArrowWidth = 10;
        
        // Draw Bezier arrow on top consists of 3 points
        
        NSArray *namearr=@[@"添加医生",@"删除医生"];
        NSArray *moreimagearr=@[@"xiangmuxinxi",@"xiangmuxinxi",@"xiangmudingdan",@"yuyueqianwang",@"xinxiaoxiliebiao"];
        for (int i=0; i<2; i++) {
            UIButton *morebutton1=[UIButton buttonWithType:UIButtonTypeCustom];
            morebutton1.frame=CGRectMake(0, 45*i, 130, 45);
            morebutton1.tag=1000000+i;
            [morebutton1 setImage:[UIImage imageNamed:[moreimagearr objectAtIndex:i]] forState:UIControlStateNormal];
            //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
            [morebutton1 setImageEdgeInsets:UIEdgeInsetsMake(12, 15, 12, 130-21-15)];
            [morebutton1 setTitle:[NSString stringWithFormat:@"%@",[namearr objectAtIndex:i]] forState:UIControlStateNormal];
            morebutton1.layer.borderWidth=1.0;
            morebutton1.layer.borderColor=[UIColor clearColor].CGColor;
            morebutton1.titleLabel.font=[UIFont boldSystemFontOfSize:19.0];
            //[canclebutton setImage:[UIImage imageNamed:@"backArrow.png"] forState:UIControlStateNormal];
            //[morebutton setImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
            [morebutton1 setTitleColor:KBlackColor forState:UIControlStateNormal];
            [morebutton1 addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonbgv addSubview:morebutton1];
            if (i!=1) {
                UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(0, 45-0.7, 130, 0.7)];
                linev.backgroundColor=KLineColor;
                [morebutton1 addSubview:linev];
            }
        }
        
    }
    
}

-(void)deleteaction{
    UIButton *morebutton1=[UIButton buttonWithType:UIButtonTypeCustom];

    morebutton1.tag=1000001;;
    [self buttonaction:morebutton1];
}
-(void)buttonaction:(UIButton *)button{
    [moreControl removeFromSuperview];
    [buttonbgv removeFromSuperview];
    
    haveshowmorebutton=NO;
    
    if (self.isaddpatient) {
        
        if (button.tag==1000000) {
            
            
            SearchNameViewController *editnamevc=[[SearchNameViewController alloc]init];
            //editnamevc.isrootvc=NO;
            editnamevc.docteamid=self.docteamid;
            [self.navigationController pushViewController:editnamevc animated:YES];
            
        } else {
            
        }
        
    }else{
        
        if (button.tag==1000000) {
            
            AddDoctorViewController *editnamevc=[[AddDoctorViewController alloc]init];
            //editnamevc.isrootvc=NO;
            editnamevc.docteamid=self.docteamid;
            [self.navigationController pushViewController:editnamevc animated:YES];

            
        } else {
            tmpdataarr=dataarr;
            [morebutton setTitle:@"删除" forState:UIControlStateNormal];
            isedit=YES;
            self.isaddshowall=NO;
            [self.tableView reloadData];

            
            
        }
   
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
    
    
    if (self.textfield.text.length==0) {
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"您的输入为空"];

    }else{
        
        if (self.isaddpatient) {
            
            
        }else{
            
           // if (haveNextPage) {
                pagenum=0;
                [DocTeamDataService getDocArrWithName:self.textfield.text pageNum:pagenum block:^(id resultArrDic) {
                    
                    dataarr=[resultArrDic objectForKey:@"content"];
                    
                    if ([[resultArrDic objectForKey:@"has_next"] boolValue]==true) {
                        haveNextPage=YES;
                        pagenum++;
                    } else {
                        haveNextPage=NO;
                    }
                    
                    
                    
                    [DocTeamDataService getTeamMembersWithteamId:self.docteamid block:^(id doctorDatadic) {
                          self.frienddataArr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
                        NSLog(@"%@",self.frienddataArr);
                         [self.tableView reloadData];
                    }];
                    
                    
                    
                    
                    
                    
                   
                }];
//            } else {
//                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//                [[PublicTools shareInstance]creareNotificationUIView:@"没有更多数据了"];
//                
//                
//            }
            

        }
        
    }
    
    
    
    
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
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isneedload) {
        [DocTeamDataService getTeamMembersWithteamId:self.docteamid block:^(id doctorDatadic) {
            
            
            
            self.teammemberarr=[doctorDatadic objectForKey:@"members"];
            self.ownerdatadic=[doctorDatadic objectForKey:@"owner"];
//            groupnamelabel.text=[NSString stringWithFormat:@"%@团队",[[doctorDatadic objectForKey:@"owner"] objectForKey:@"name"]];
//            //[self.tableView reloadData];
//            hotsplabel.text=[[doctorDatadic objectForKey:@"owner"] objectForKey:@"hospital"];
            
            NSMutableArray *tmparr=[[NSMutableArray alloc]init];
            
            NSMutableArray *tmpnamearr=[[NSMutableArray alloc]init];
            NSMutableArray *tmptimearr=[[NSMutableArray alloc]init];
            
            for (NSDictionary *dic in self.teammemberarr) {
                //  [tmparr addObject:[dic objectForKey:@"doctor"]];
                
                
                
                if ( [[dic objectForKey:@"status"] integerValue]==0) {
                    NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
                    NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
                    [mdic setValue:@"0" forKey:@"status"];
                    [tmptimearr addObject:mdic];
                } else {
                    NSDictionary *tmpdic=[dic objectForKey:@"doctor"];
                    NSMutableDictionary *mdic=[[NSMutableDictionary alloc]initWithDictionary:tmpdic];
                    [mdic setValue:@"1" forKey:@"status"];
                    
                    [tmpnamearr addObject:mdic];
                }
                
                
            }
            
            NSMutableArray *sorttmpnamearr=[ChineseString SortArray:tmpnamearr];
            
            
            NSLog(@"%@",sorttmpnamearr);
            
            NSMutableArray *turenamearr=[[NSMutableArray alloc]init];
            for (NSString *name in sorttmpnamearr) {
                for (NSDictionary *sortdic in tmpnamearr) {
                    if ([name isEqualToString:[sortdic objectForKey:@"name"]]) {
                        [turenamearr addObject:sortdic];
                    }
                }
            }
            NSMutableArray *turetimearr=[[NSMutableArray alloc]init];
            
            for (NSMutableDictionary *mdic in tmptimearr) {
                [turetimearr insertObject:mdic atIndex:0];
                
            }
            
            [tmparr addObjectsFromArray:turenamearr];
            
            [tmparr addObjectsFromArray:turetimearr];
            
            [tmparr insertObject:self.ownerdatadic atIndex:0];
            
            dataarr=[[NSMutableArray alloc]initWithArray:tmparr];
       //     tmpdocarr=[[NSMutableArray alloc]init];
            // [tmpdocarr addObjectsFromArray:tmpdocarr];
            //[self.tableView reloadData];
            
            [DocTeamDataService getTeamMembersWithteamId:self.docteamid block:^(id doctorDatadic) {
                self.frienddataArr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
                [self.tableView reloadData];
            }];
            
         //   [self showdocaction];
            
            }];
    }else{
        
    }

    
    
    if (self.isdeletedoc) {
        [self deleteaction];
    }
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
#pragma 返回
-(void)itemactionWithType:(NSInteger)typeindex{
    
    
    if (self.isfromTeamDetail) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
    
    
    if (isedit) {
        isedit=NO;
        self.isaddshowall=YES;
        [morebutton setTitle:@"...." forState:UIControlStateNormal];
         dataarr=tmpdataarr;
         [editdataarr removeAllObjects];
        [self.tableView reloadData];
    } else {
         [self.navigationController popViewControllerAnimated:YES];
    }
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
    
    }
-(void)segmentaction:(UISegmentedControl *)segment{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataarr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isaddpatient) {
        return 60.0;

    }else{
        return 60.0;

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    
    for (UIView *subv in cell.subviews) {
        [subv removeFromSuperview];
    }
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    
    
    NSMutableDictionary *datadic=[dataarr objectAtIndex:indexPath.row];
       // cell.imageView.image=[UIImage imageNamed:@"KAKA"];
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    if (self.isaddpatient) {
        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 44, 44)];
        imagev.frame=CGRectMake(15, 8, 44, 44);
        
    }else{
        imagev =[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 44, 44)];
       //   imagev.frame=CGRectMake(10, 8, 44, 44);
        
    }
  
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =22.0;
    imagev.layer.borderColor = [UIColor clearColor].CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
   // imagev.image=[UIImage imageNamed:@"KAKA"];
  //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [cell addSubview:imagev];
    
    UILabel *label=[[UILabel alloc]init];
    
    
    if (self.isaddpatient) {
        label.frame=CGRectMake(65, 15, 160, 30);
        
    }else{
        label.frame=CGRectMake(65, 15, 160, 30);
        
    }
    label.textColor=KBlackColor;
    label.font=[UIFont systemFontOfSize:17.0];
    label.backgroundColor=[UIColor whiteColor];
    [cell addSubview:label];
    //label.text=
    NSString *contentstring=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"name"]]];
//    
    NSMutableAttributedString *astring=[[NSMutableAttributedString alloc]initWithString:contentstring];
//    
//    
//
    NSLog(@"%@",datadic);
    label.attributedText=astring;
    
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    label.text=[datadic objectForKey:@"name"];
    
//    [UserDataService getUserInfofortargetIdWithtargetId:[datadic objectForKey:@"id"] block:^(id userinfomodel) {
//        UserInfoModel *model=(UserInfoModel *)userinfomodel;
//        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        label.text=model.username;
//        
//        
//    }];
 // UILabel *desclabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-190, 7, 180, 30)];
    
    if (self.isaddpatient) {
        
        
    }else{
       // UILabel *desclabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-190, 7, 180, 30)];
        
//        if (self.isaddpatient) {
//            desclabel.frame=CGRectMake(ScreenWidth-190, 7, 180, 30);
//            
//        }else{
//            desclabel.frame=CGRectMake(65, 30, 180, 30);
//            
//        }
//        
//        desclabel.textColor=KLineColor;
//        desclabel.font=[UIFont systemFontOfSize:13.0];
//        desclabel.backgroundColor=[UIColor whiteColor];
//        [cell addSubview:desclabel];
//        desclabel.text=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"hospital"]? [NSString stringWithFormat:@"%@",[datadic objectForKey:@"hospital"]]:@""];
   
    }
    
    
    if (isedit) {
        if (indexPath.row!=0) {
            
        
        itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
        // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
        
        
        if (self.isaddpatient) {
            sentbutton.frame=CGRectMake(5, 15, 30, 30);
            [sentbutton setTitle:@"添加" forState:UIControlStateNormal];
            
        }else{
            
            sentbutton.frame=CGRectMake(5, 15, 30, 30);
            [sentbutton setTitle:@"邀请" forState:UIControlStateNormal];
            
            
            
            
            
            
            
            
            
            
        }
        sentbutton.tag=indexPath.row+200000000;
        sentbutton.buttonlocation=indexPath.section;
        sentbutton.layer.masksToBounds = YES;
        sentbutton.layer.cornerRadius = 15.0;
        sentbutton.layer.borderWidth = 1.0;
        sentbutton.layer.borderColor = [[UIColor clearColor] CGColor];
            if ([datadic objectForKey:@"selectstate"]) {
                if ([[datadic objectForKey:@"selectstate"]isEqualToString:@"unselect"]) {
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
        if (self.isaddshowall) {
            sentbutton.hidden=YES;
        }else{
            imagev.frame=CGRectMake(35, 8, 44, 44);
            label.frame=CGRectMake(85, 15, 160, 30);
           // desclabel.frame=CGRectMake(85, 30, 180, 30);
        }
      }
    } else {
        if (self.isneedadd) {
            
            
            itemdetailbutton *sentbutton=[itemdetailbutton buttonWithType:UIButtonTypeCustom];
            // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
            
            
            if (self.isaddpatient) {
                sentbutton.frame=CGRectMake(ScreenWidth-70, 15, 60, 30);
                [sentbutton setTitle:@"添加" forState:UIControlStateNormal];
                
            }else{
                sentbutton.frame=CGRectMake(ScreenWidth-70, 15, 60, 30);
                [sentbutton setTitle:@"邀请" forState:UIControlStateNormal];
                
                label.frame=CGRectMake(85, 0, 160, 30);
                UILabel *desclabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 25, 180, 30)];
                desclabel.textColor=KtextGrayColor;
                desclabel.font=[UIFont systemFontOfSize:13.0];
                desclabel.backgroundColor=[UIColor clearColor];
                [cell addSubview:desclabel];
                desclabel.text=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"hospital"]? [NSString stringWithFormat:@"%@",[datadic objectForKey:@"hospital"]]:@""];
                
                
                

//                if ([[datadic objectForKey:@"status"] integerValue]==0) {
//                    sentbutton.hidden=YES;
//                }
                
            }
            sentbutton.tag=indexPath.row+200000000;
            sentbutton.buttonlocation=indexPath.section;
            sentbutton.layer.masksToBounds = YES;
            sentbutton.layer.cornerRadius = 4.0;
            sentbutton.layer.borderWidth = 1.0;
            sentbutton.layer.borderColor = [KlightOrangeColor CGColor];
            
            [sentbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sentbutton.backgroundColor=KlightOrangeColor;
            [sentbutton addTarget:self action:@selector(sentmsgaction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:sentbutton];
            
          //  NSLog(@"%@",[datadic objectForKey:@"status"]);
            
//            if ([datadic objectForKey:@"status"] ) {
//                if ([[datadic objectForKey:@"status"] integerValue]==0) {
//                      sentbutton.hidden=YES;
//                }
//            }
            
            
            
            for (NSDictionary *tmpdic in self.frienddataArr) {
                
                if ([[[tmpdic objectForKey:@"doctor"] objectForKey:@"id"]isEqualToString:[datadic objectForKey:@"id"]]) {
                    if ([tmpdic objectForKey:@"status"] ) {
                        if ([[tmpdic objectForKey:@"status"] integerValue]==0) {
                            sentbutton.hidden=YES;
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            

            
            

            if (self.isaddshowall) {
                sentbutton.hidden=YES;
            }else{
                imagev.frame=CGRectMake(15, 8, 44, 44);
                label.frame=CGRectMake(65, 5, 160, 30);
                // desclabel.frame=CGRectMake(85, 30, 180, 30);
            }
            
        }

    }
    NSLog(@"%@",datadic);
    NSLog(@"%@",datadic);
    if (self.frienddataArr!=nil) {
        
        
        for (NSDictionary *tmpdic in self.frienddataArr) {
            
            if ([[[tmpdic objectForKey:@"doctor"] objectForKey:@"id"]isEqualToString:[datadic objectForKey:@"id"]]) {
                if ([tmpdic objectForKey:@"status"] ) {
                    if ([[tmpdic objectForKey:@"status"] integerValue]==0) {
                        
                        UILabel *sentbuttonlabel=[[UILabel alloc]init];
                        // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
                        sentbuttonlabel.frame=CGRectMake(ScreenWidth-70, 15, 60, 30);
                        sentbuttonlabel.text=@"待加入";
                        sentbuttonlabel.textColor=[UIColor grayColor];
                        sentbuttonlabel.font=[UIFont boldSystemFontOfSize:13.0];
                        [cell addSubview:sentbuttonlabel];
                        
                        if (isedit) {
                            sentbuttonlabel.hidden=YES;
                        }else{
                            sentbuttonlabel.hidden=NO;
                        }
                        
                    }else if ([[tmpdic objectForKey:@"status"] integerValue]==1){
                        
                        
                    }
                    
                }

                
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
       
    } else {
//        if ([datadic objectForKey:@"status"] ) {
//            if ([[datadic objectForKey:@"status"] integerValue]==0) {
//                
//                UILabel *sentbuttonlabel=[[UILabel alloc]init];
//                // sentbutton.frame=CGRectMake(ScreenWidth-90, 5, 80, 40-6);
//                sentbuttonlabel.frame=CGRectMake(ScreenWidth-70, 15, 60, 30);
//                sentbuttonlabel.text=@"待加入";
//                sentbuttonlabel.textColor=[UIColor grayColor];
//                sentbuttonlabel.font=[UIFont boldSystemFontOfSize:13.0];
//                [cell addSubview:sentbuttonlabel];
//                
//                if (isedit) {
//                    sentbuttonlabel.hidden=YES;
//                }else{
//                    sentbuttonlabel.hidden=NO;
//                }
//                
//            }else if ([[datadic objectForKey:@"status"] integerValue]==1){
//                
//                
//            }
//            
//        }

    }
    
    if (indexPath.row!=dataarr.count-1) {
        UIView *linev=[[UIView alloc]initWithFrame:CGRectMake(label.frame.origin.x, 59.3, ScreenWidth, 0.7)];
        linev.backgroundColor=KLineColor;
        [cell addSubview:linev];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients{
    
}



-(void)editaction:(itemdetailbutton *)button{
    
    
    
    
    if (button.havePressed==NO) {
        
        button.selected=YES;
        button.havePressed=YES;
        NSMutableDictionary *datadic=[[NSMutableDictionary alloc]initWithDictionary:[dataarr objectAtIndex:button.tag-200000000]];
        [datadic setValue:@"selected" forKey:@"selectstate"];
        
        NSMutableArray *mutaArray = [[NSMutableArray alloc] initWithArray:dataarr];
        [mutaArray replaceObjectAtIndex:button.tag-200000000 withObject:datadic];
        dataarr= [[NSMutableArray alloc] init];
        [dataarr removeAllObjects];
        dataarr = mutaArray;
        
        NSMutableDictionary *datadic1=[[NSMutableDictionary alloc]initWithDictionary:[dataarr objectAtIndex:button.tag-200000000]];
        [editdataarr addObject:[datadic1 objectForKey:@"id"]];
        [morebutton setTitle:[NSString stringWithFormat:@"删除(%zd)",editdataarr.count] forState:UIControlStateNormal];
        
        
        
    }else{
        button.selected=NO;
        button.havePressed=NO;
        
        NSMutableDictionary *datadic=[[NSMutableDictionary alloc]initWithDictionary:[dataarr objectAtIndex:button.tag-200000000]];
        
        [datadic setValue:@"unselect" forKey:@"selectstate"];
        NSMutableArray *mutaArray = [[NSMutableArray alloc] initWithArray:dataarr];
        [mutaArray replaceObjectAtIndex:button.tag-200000000 withObject:datadic];
        dataarr= [[NSMutableArray alloc] init];
        [dataarr removeAllObjects];
        dataarr = mutaArray;
        
        NSMutableDictionary *datadic1=[[NSMutableDictionary alloc]initWithDictionary:[dataarr objectAtIndex:button.tag-200000000]];
        [editdataarr removeObject:[datadic1 objectForKey:@"id"]];
        if (editdataarr.count!=0) {
            [morebutton setTitle:[NSString stringWithFormat:@"删除(%zd)",editdataarr.count] forState:UIControlStateNormal];
        }else{
            [morebutton setTitle:[NSString stringWithFormat:@"删除",editdataarr.count] forState:UIControlStateNormal];
        }

    }

//    
//    if (button.havePressed==NO) {
//        
//        button.selected=YES;
//        button.havePressed=YES;
//         NSMutableDictionary *datadic=[dataarr objectAtIndex:button.tag-200000000];
//        [editdataarr addObject:[datadic objectForKey:@"id"]];
//        
//        
//        
//    }else{
//        button.selected=NO;
//        button.havePressed=NO;
//        NSMutableDictionary *datadic=[dataarr objectAtIndex:button.tag-200000000];
//        [editdataarr removeObject:[datadic objectForKey:@"id"]];
//        if (editdataarr.count!=0) {
//            [morebutton setTitle:[NSString stringWithFormat:@"删除(%zd)",editdataarr.count] forState:UIControlStateNormal];
//        }else{
//            [morebutton setTitle:[NSString stringWithFormat:@"删除",editdataarr.count] forState:UIControlStateNormal];
//        }
//        
//    }
    
}


-(void)sentmsgaction:(itemdetailbutton *)button{
     NSMutableDictionary *datadic=[dataarr objectAtIndex:button.tag-200000000];
    [MobClick event:@"team_invitation"];
    if (self.isaddpatient) {
        //sentbutton.frame=CGRectMake(ScreenWidth-190, 7, 180, 30);
        
        
    }else{
    
        [DocTeamDataService invitedoctorWithdocID:[datadic objectForKey:@"id"] teamId:self.docteamid block:^(id responsedic) {
            button.backgroundColor=[UIColor whiteColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitle:@"已邀请" forState:UIControlStateNormal];
            button.userInteractionEnabled=NO;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addmembers" object:nil];
            [DocTeamDataService getTeamMembersWithteamId:self.docteamid block:^(id doctorDatadic) {
                self.frienddataArr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
                [self.tableView reloadData];
            }];
        }];
        
        
       // sentbutton.frame=CGRectMake(ScreenWidth-190, 15, 180, 30);
        
    }
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
//    
//    if (button.havePressed==YES) {
//        button.selected=YES;
//        button.backgroundColor=[UIColor grayColor];
//        
//        NSIndexPath *path=[NSIndexPath indexPathForRow:button.tag-10000 inSection:0];
//        
//        NSDictionary *dic=[self.dataArr objectAtIndex:button.tag-10000-1];
//        [indexarr addObject:dic];
//        
//        [arr addObject:path];
//        NSLog(@"%@",arr);
//        button.havePressed=NO;
//    }else{
//        button.selected=NO;
//        button.havePressed=YES;
//        button.backgroundColor=[UIColor redColor];
//        NSIndexPath *path=[NSIndexPath indexPathForRow:button.tag-10000 inSection:0];
//        [arr removeObject:path];
//        NSDictionary *dic=[self.dataArr objectAtIndex:button.tag-10000-1];
//        [indexarr removeObject:dic];
//        
//    }
    
    
}


- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [vc.tableView addHeaderWithCallback:^{
        
        if (self.isaddpatient) {
            
            
        }else{
        
        //if (haveNextPage) {
            pagenum=0;
            [DocTeamDataService getDocArrWithName:self.textfield.text pageNum:pagenum block:^(id resultArrDic) {
                
                dataarr=[resultArrDic objectForKey:@"content"];
                
                if ([[resultArrDic objectForKey:@"has_next"] boolValue]==true) {
                    haveNextPage=YES;
                    pagenum++;
                } else {
                    haveNextPage=NO;
                }
                
                //[self.tableView reloadData];
                [DocTeamDataService getTeamMembersWithteamId:self.docteamid block:^(id doctorDatadic) {
                    self.frienddataArr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
                    NSLog(@"%@",self.frienddataArr);
                    [self.tableView reloadData];
                }];
                [vc.tableView headerEndRefreshing];
            }];
//        } else {
//            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//            [[PublicTools shareInstance]creareNotificationUIView:@"没有更多数据了"];
//            
//            
//        }
    }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // [vc.collectionView reloadData];
            // 结束刷新
            [vc.tableView headerEndRefreshing];
        });
    }];
    
    //  #warning 自动刷新(一进入程序就下拉刷新)
    // [vc.tableView headerBeginRefreshing];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    
    
    
   

    // 添加上拉刷新尾部控件
    [vc.tableView addFooterWithCallback:^{
        
        
        
        if (self.isaddpatient) {
            
            
        }else{
        
        if (haveNextPage) {
            NSLog(@"%zd",pagenum);
            [DocTeamDataService getDocArrWithName:self.textfield.text pageNum:pagenum block:^(id resultArrDic) {
                
              //  dataarr=[resultArrDic objectForKey:@"content"];
                
                
                
                //[self.dataArr addObject:[dic objectForKey:@"content"]];
                if (dataarr.count!=0) {
                    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
                    [mutaArray addObjectsFromArray:dataarr];
                    for (NSMutableDictionary *mydic in [resultArrDic objectForKey:@"content"]) {
                        [mutaArray addObject:mydic];
                    }
                    dataarr= [[NSMutableArray alloc] init];
                    [dataarr removeAllObjects];
                    dataarr = mutaArray;

                }
                
                
                
                
                if ([[resultArrDic objectForKey:@"has_next"] boolValue]==true) {
                    haveNextPage=YES;
                    pagenum++;
                } else {
                    haveNextPage=NO;
                }
                //[self.tableView reloadData];
                [DocTeamDataService getTeamMembersWithteamId:self.docteamid block:^(id doctorDatadic) {
                    self.frienddataArr=[[NSMutableArray alloc]initWithArray:[doctorDatadic objectForKey:@"members"]];
                    NSLog(@"%@",self.frienddataArr);
                    [self.tableView reloadData];
                }];
                [vc.tableView footerEndRefreshing];
            }];
        } else {
            [self.tableView reloadData];
            [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
            [[PublicTools shareInstance]creareNotificationUIView:@"没有更多数据了"];
             [vc.tableView footerEndRefreshing];
            
            
        }
    }
        // 进入刷新状态就会回调这个Block
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.tableView reloadData];
            // 结束刷新
            [vc.tableView footerEndRefreshing];
        });
    }];
}
@end
