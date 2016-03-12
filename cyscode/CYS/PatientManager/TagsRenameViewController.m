//
//  TagsRenameViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/13.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "TagsRenameViewController.h"

@implementation TagsRenameViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=KBackgroundColor;
    
    if (self.isadd) {
        self.title=@"添加分组";
    }else{
        self.title=@"修改标签";
    }
    
    codetf1=[[UITextField alloc]initWithFrame:CGRectMake(0, 66, ScreenWidth, 45)];
    codetf1.delegate=self;
    codetf1.textColor=KBlackColor;
    
    if (self.isadd) {
         codetf1.placeholder=@"输入分组名字创建分组";
    }else{
         codetf1.placeholder=self.tagstr;
    }
  
    codetf1.layer.cornerRadius=5.0;
    codetf1.backgroundColor=[UIColor whiteColor];
    codetf1.clearButtonMode=UITextFieldViewModeAlways;
    codetf1.returnKeyType=UIReturnKeyDone;
    codetf1.tintColor=KlightOrangeColor;
    KtfAddpaddingView(codetf1);
//    
//    [codetf1.leftView addSubview:pwimgView];
//    codetf1.leftViewMode = UITextFieldViewModeAlways;
//    codetf1.leftView.bounds=CGRectMake(0, 0, 40, 25);
    
    [self.view addSubview:codetf1];
    

    
    
    
    
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField.text isEqualToString:@""]) {
        
        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
        [[PublicTools shareInstance]creareNotificationUIView:@"输入为空"];

    }else{
        
        if (self.isadd) {
           // NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:textField.text,@"tag", nil];
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您确定用《%@》创建分组吗",codetf1.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertview show];

           
        } else {
            [PatientDataService updateTagWithTagid:self.tagid tagStr:textField.text block:^(id respdic) {
                [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
                [[PublicTools shareInstance]creareNotificationUIView:@"修改成功"];
                [self.delegate reloadrenametags];
                [self.navigationController popViewControllerAnimated:YES];
                
            }];

        }
    }
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        
        [PatientDataService addTagWithTagstr:codetf1.text block:^(id respdic) {
            // NSDictionary *dic=(NSDictionary *)respdic;
            [self.delegate reloadrenametags];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

@end
