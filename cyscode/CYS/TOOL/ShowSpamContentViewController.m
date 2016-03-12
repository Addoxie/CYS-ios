//
//  EditSpamContentViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/2/22.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "ShowSpamContentViewController.h"
#import "NameListViewController.h"


@interface ShowSpamContentViewController (){

    NSString *tmpmessage;
    NSMutableArray *dataarr;
    NSMutableArray *contacttmpnamearr;
    UITextView *code1tf;
    UITextView *code2tf;
    NSInteger selectedindex;
    
    UIView *blankView;
}

@end

@implementation ShowSpamContentViewController
-(void)viewDidLoad{
    [super viewDidLoad];
  //   [self.navigationController.navigationBar setTranslucent:YES];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //tmpmessage=@"UITextFieldDelegate代理里面响应return键的回调:textFieldShouldReturn:。但是 UITextView的代理UITextViewDelegate 里面并没有这样的回调。但是有别的方法可以实现：UITextViewDelegate里面有这样一个代理函数：";
    
    
    
   // dataarr=[[NSMutableArray alloc]initWithArray:[[UserDB shareInstance]findMsgs]];

    
//    if (self.contactarr!=nil) {
//          [dataarr addObject:self.contactarr];
//    }
//  
    
   
   
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    
    self.tableView.dataSource=self;
    self.tableView.separatorColor=[UIColor clearColor];
    self.title=@"群发消息";
    [self.view addSubview:self.tableView];
    
    UIButton *morebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    morebutton.frame=CGRectMake(0, ScreenHeight-49, ScreenWidth, 49);
    
    morebutton.layer.masksToBounds = YES;
    morebutton.layer.cornerRadius = 0.0;
    morebutton.layer.borderWidth = 1.0;
    morebutton.layer.borderColor = [KlightOrangeColor CGColor];
    [morebutton setTitle:@"新建群发" forState:UIControlStateNormal];
    //nextbutton.userInteractionEnabled=NO;
    morebutton.titleLabel.font=[UIFont systemFontOfSize:19.0];
    [morebutton addTarget:self action:@selector(spambuttontaction) forControlEvents:UIControlEventTouchUpInside];
    morebutton.backgroundColor=KlightOrangeColor;
    [self.view addSubview:morebutton];

    self.view.backgroundColor=KBackgroundColor;
       [self setblankview];
}
-(void)setblankview{
     [blankView removeFromSuperview];
    if (dataarr.count==0) {
        blankView=[[UIView alloc]initWithFrame:CGRectMake(0,64,ScreenWidth,ScreenHeight-64-49)];
        blankView.backgroundColor=KBackgroundColor;
        blankView.alpha=1.0;
        
        
        
        
        UIButton *addgroupbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        addgroupbutton.frame=CGRectMake(ScreenWidth/2.0-80/2.0, 200-30, 80, 80);
        
        addgroupbutton.layer.masksToBounds = YES;
        addgroupbutton.layer.cornerRadius = 6.0;
        addgroupbutton.layer.borderWidth = 1.0;
        addgroupbutton.layer.borderColor = [[UIColor clearColor] CGColor];
        [addgroupbutton setTitle:@"" forState:UIControlStateNormal];
        [addgroupbutton setImage:[UIImage imageNamed:@"group_massage_2"] forState:UIControlStateNormal];
        //nextbutton.userInteractionEnabled=NO;
        addgroupbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
        //[addgroupbutton addTarget:self action:@selector(addgroupbuttontaction) forControlEvents:UIControlEventTouchUpInside];
       // addgroupbutton.backgroundColor=KGrayColor;
        [blankView addSubview:addgroupbutton];
        
        UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-250/2.0, 290-30,250, 30)];
        detaillabel.text=[NSString stringWithFormat:@"文字信息信息分别发送给各位患者"];
        detaillabel.textColor=KtextGrayColor;
        detaillabel.numberOfLines=1;
        detaillabel.backgroundColor=KBackgroundColor;
        detaillabel.layer.cornerRadius=6.0;
        detaillabel.layer.borderColor=KBackgroundColor.CGColor;
        detaillabel.layer.borderWidth=1.0;
        
        detaillabel.textAlignment=NSTextAlignmentCenter;
        detaillabel.font=[UIFont systemFontOfSize:13.0];
        //detaillabel.userInteractionEnabled=NO;
        [blankView addSubview:detaillabel];
        
        
        
        
        [self.view addSubview:blankView];
    }

    
}
-(void)spambuttontaction{
    NameListViewController *doctorteam=[[NameListViewController alloc]init];
    doctorteam.title=@"群发消息";
    doctorteam.isSpam=YES;
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:doctorteam animated:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=NO;
     dataarr=[[NSMutableArray alloc]initWithArray:[[UserDB shareInstance]findMsgs]];
    [self setblankview];
    [self.tableView reloadData];
 //   [self.navigationController.navigationBar setTranslucent:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(NSString *)gettimestring:(NSString *)timestap{
   
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];

    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    
    
  //  NSString *timeSp = [NSString stringWithFormat:@"%d", [timestap intValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestap intValue]];
    
   // NSDate* date = [formatter dateFromString:timestap]; //------------将字符串按formatter转成nsdate
    
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeStr = [formatter stringFromDate:confromTimesp];
    
    
    NSLog(@"%@",timeStr);
    NSLog(@"%@",timestap);
    return timeStr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    HistoryMsgModel *hmodel=[dataarr objectAtIndex:indexPath.row];
    NSDictionary *tmpdatadic=[self dictionaryWithJsonString:hmodel.messagecontent];
    NSString *mssagecontent=[tmpdatadic objectForKey:@"msg"];
    
    NSArray *namearr=[tmpdatadic objectForKey:@"contacts"];
    
    NSMutableArray *tmpcontacttmpnamearr=[[NSMutableArray alloc]init];
    //   contacttmpidarr=[[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in namearr) {
        NSLog(@"%@",dic);
        [tmpcontacttmpnamearr addObject:[dic objectForKey:@"name"]];
        
    }
    
    NSString *namesstr=[tmpcontacttmpnamearr componentsJoinedByString:@","];
    UIFont *font=[UIFont systemFontOfSize:16.0];
    
    CGRect size=KStringSize(namesstr, ScreenWidth-30, font);
    
    CGRect size1=KStringSize(mssagecontent, ScreenWidth-30, font);


    return size.size.height+30+30+size1.size.height+20+50+10+30+25;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataarr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
    }
    
    
    HistoryMsgModel *hmodel=[dataarr objectAtIndex:indexPath.row];
    
    NSDictionary *tmpdatadic=[self dictionaryWithJsonString:hmodel.messagecontent];
    NSString *mssagecontent=[tmpdatadic objectForKey:@"msg"];
    
    NSArray *namearr=[tmpdatadic objectForKey:@"contacts"];
    
    
    
    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-75.0, 10,150, 30)];
    NSString *timestr=[self gettimestring:hmodel.messageid];
    
    detaillabel.text=timestr;
    detaillabel.textColor=KtextGrayColor;
    detaillabel.numberOfLines=1;
    detaillabel.backgroundColor=kimiColor(223, 224, 225, 1.0);
    detaillabel.layer.cornerRadius=6.0;
    detaillabel.clipsToBounds=YES;
    
    detaillabel.layer.masksToBounds=YES;
    detaillabel.layer.rasterizationScale = [UIScreen mainScreen].scale;

    detaillabel.layer.borderColor=kimiColor(223, 224, 225, 1.0).CGColor;
    detaillabel.layer.borderWidth=1.0;

    detaillabel.textAlignment=NSTextAlignmentCenter;
    detaillabel.font=[UIFont systemFontOfSize:13.0];
    //detaillabel.userInteractionEnabled=NO;
    [cell.contentView addSubview:detaillabel];
    
    
    NSMutableArray *tmpcontacttmpnamearr=[[NSMutableArray alloc]init];
    //   contacttmpidarr=[[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in namearr) {
        NSLog(@"%@",dic);
        [tmpcontacttmpnamearr addObject:[dic objectForKey:@"name"]];
        
    }
    
    NSString *namesstr=[tmpcontacttmpnamearr componentsJoinedByString:@","];
    UIFont *font=[UIFont systemFontOfSize:16.0];
    
    CGRect size=KStringSize(namesstr, ScreenWidth-30, font);
    
    CGRect size1=KStringSize(mssagecontent, ScreenWidth-30, font);
    
    // size.size.height+20+30+size1.size.height+20+50;

    
    
    UIView *bgv=[[UIView alloc]initWithFrame:CGRectMake(15, 50, ScreenWidth-30, size.size.height+30+30+size1.size.height+30+20+25)];
    bgv.backgroundColor=kimiColor(248, 249, 250, 1.0);
     bgv.layer.cornerRadius=10.0;
    [cell.contentView addSubview:bgv];
    
    
    
    UIView *bgv1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth-30, 30)];
    bgv1.backgroundColor=kimiColor(248, 249, 250, 1.0);
   // bgv1.layer.cornerRadius=10.0;
    [bgv addSubview:bgv1];

    
    UILabel *contactlabel=[[UILabel alloc]initWithFrame:CGRectMake(2, 5,ScreenWidth-30, 30)];
    contactlabel.text=[NSString stringWithFormat:@"%zd位收信人：",namearr.count];
    contactlabel.textColor=KtextGrayColor;
    contactlabel.numberOfLines=1;
    
    contactlabel.textAlignment=NSTextAlignmentLeft;
    contactlabel.font=[UIFont systemFontOfSize:15.0];
    //detaillabel.userInteractionEnabled=NO;
    [bgv addSubview:contactlabel];
    
    
    
    
    
    code1tf=[[UITextView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth-30, size.size.height+30)];
    // code1tf.delegate=self;
    // code1tf.placeholder=@"手机号码";
    code1tf.layer.masksToBounds = YES;
    code1tf.layer.cornerRadius = 0.0;
  //  code1tf.layer.borderWidth = 1.0;
    code1tf.text=namesstr;
    code1tf.font=font;
    NSLog(@"%@",namesstr);
    code1tf.textColor=KBlackColor;
    code1tf.backgroundColor=kimiColor(248, 249, 250, 1.0);
    //  code1tf.layer.borderColor=KLightLineColor.CGColor;
    //  code1tf.keyboardType=UIKeyboardTypeNumberPad;
    //  code1tf.tintColor=KlightOrangeColor;
    //  KtfAddpaddingView(code1tf);
    //  code1tf.text=namesstr;
    code1tf.editable=NO;
   // code1tf.layer.borderColor = [KLineColor CGColor];
    [bgv addSubview:code1tf];
    
    [bgv addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, size.size.height+30+30, ScreenWidth-30, 0.5) withimage:nil withbgcolor:KLineColor]];
    
//
//    
    code2tf=[[UITextView alloc]initWithFrame:CGRectMake(0, size.size.height+30+30+1, ScreenWidth-30,size1.size.height+30)];
  
 //   code2tf.tintColor=KlightOrangeColor;
    // code2tf.placeholder=@"验证码";
    code2tf.layer.masksToBounds = YES;
//    code2tf.layer.cornerRadius = 6.0;
    code2tf.layer.borderWidth = 0.0;
    code2tf.font=font;
    code2tf.textColor=KBlackColor;
    code2tf.returnKeyType=UIReturnKeySend;
    code2tf.text=mssagecontent;
    code2tf.editable=NO;
    code2tf.scrollEnabled=NO;
    code2tf.backgroundColor=kimiColor(254, 255, 255, 1.0);
    //    code2tf.keyboardType=UIKeyboardTypeNumberPad;
    //    KtfAddpaddingView(code2tf);
     code2tf.layer.borderColor = KBackgroundColor.CGColor;
    [bgv addSubview:code2tf];

    [bgv addSubview:[[UIManager shareInstance]getlineviewWithFrame:CGRectMake(0, code2tf.frame.size.height+code2tf.frame.origin.y, ScreenWidth-30, 0.5) withimage:nil withbgcolor:KLineColor]];

    
    
    UIButton *tagbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    tagbutton.frame=CGRectMake(bgv.frame.size.width-65, bgv.frame.size.height-35, 60, 25);
    
    tagbutton.tag=indexPath.row;
    tagbutton.layer.cornerRadius=2.0;
    tagbutton.layer.borderColor=kimiColor(183, 184, 184, 1.0).CGColor;
    tagbutton.layer.borderWidth=1.0;
    
    //tagbutton.backgroundColor=KlightOrangeColor;
    [tagbutton setTitle:@"删除" forState:UIControlStateNormal];
    [tagbutton setTitleColor:kimiColor(183, 184, 184, 1.0) forState:UIControlStateNormal];
    [tagbutton addTarget:self action:@selector(tagbuttonaction:) forControlEvents:UIControlEventTouchUpInside];
    [bgv addSubview:tagbutton];
    
    bgv.clipsToBounds=YES;
    
    bgv.layer.masksToBounds=YES;
    bgv.layer.cornerRadius =10.0;
    bgv.layer.borderColor = [UIColor clearColor].CGColor;
    bgv.layer.rasterizationScale = [UIScreen mainScreen].scale;

    bgv.backgroundColor=kimiColor(254, 255, 255, 1.0);

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=kimiColor(239, 240, 244, 1.0);
    return cell;
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }else{
        
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *err;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                             
                                                            options:NSJSONReadingMutableContainers
                             
                                                              error:&err];
        
     if(err) {
            
        NSLog(@"json解析失败：%@",err);
            
            return nil;
            
     }
        
    return dic;
        
    }
    

}

-(void)tagbuttonaction:(UIButton *)button{
    selectedindex=button.tag;
    UIAlertView  *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"是否删除该条信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        
        
        
        
         HistoryMsgModel *hmodel=[dataarr objectAtIndex:selectedindex];
        
        BOOL result=[[UserDB shareInstance]deletemsgWithMsgid:hmodel.messageid];
        
        if (result) {
            [dataarr removeObjectAtIndex:selectedindex];
            
            
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:selectedindex inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
            
            dataarr=[[NSMutableArray alloc]initWithArray:[[UserDB shareInstance]findMsgs]];
            [self setblankview];
            [self.tableView reloadData];
            
            if (dataarr.count==0) {
                if (dataarr.count==0) {
                    blankView=[[UIView alloc]initWithFrame:CGRectMake(0,64,ScreenWidth,ScreenHeight-64-49)];
                    blankView.backgroundColor=KBackgroundColor;
                    blankView.alpha=1.0;
                    
                    
                    
                    
                    UIButton *addgroupbutton=[UIButton buttonWithType:UIButtonTypeCustom];
                    addgroupbutton.frame=CGRectMake(ScreenWidth/2.0-80/2.0, 200-30, 80, 80);
                    
                    addgroupbutton.layer.masksToBounds = YES;
                    addgroupbutton.layer.cornerRadius = 6.0;
                    addgroupbutton.layer.borderWidth = 1.0;
                    addgroupbutton.layer.borderColor = [[UIColor clearColor] CGColor];
                    [addgroupbutton setTitle:@"" forState:UIControlStateNormal];
                    [addgroupbutton setImage:[UIImage imageNamed:@"group_massage_2"] forState:UIControlStateNormal];
                    //nextbutton.userInteractionEnabled=NO;
                    addgroupbutton.titleLabel.font=[UIFont systemFontOfSize:22.0];
                    //[addgroupbutton addTarget:self action:@selector(addgroupbuttontaction) forControlEvents:UIControlEventTouchUpInside];
                    // addgroupbutton.backgroundColor=KGrayColor;
                    [blankView addSubview:addgroupbutton];
                    
                    UILabel *detaillabel=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2.0-250/2.0, 290-30,250, 30)];
                    detaillabel.text=[NSString stringWithFormat:@"文字信息信息分别发送给各位患者"];
                    detaillabel.textColor=KLineColor;
                    detaillabel.numberOfLines=1;
                    detaillabel.backgroundColor=KBackgroundColor;
                    detaillabel.layer.cornerRadius=6.0;
                    detaillabel.layer.borderColor=KBackgroundColor.CGColor;
                    detaillabel.layer.borderWidth=1.0;
                    
                    detaillabel.textAlignment=NSTextAlignmentCenter;
                    detaillabel.font=[UIFont systemFontOfSize:13.0];
                    //detaillabel.userInteractionEnabled=NO;
                    [blankView addSubview:detaillabel];
                    
                    
                    
                    
                    [self.view addSubview:blankView];
                }

            }

        }
        
        
    }
}


@end
