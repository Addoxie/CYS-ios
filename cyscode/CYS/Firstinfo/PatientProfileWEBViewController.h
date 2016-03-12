//
//  PatientProfileWEBViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/3/4.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientHealthDataViewController.h"
#import "HXViewController.h"

@protocol PatientProfileWEBViewControllerdelegate <NSObject>

-(void)PatientProfileWEBMethodname:(NSString *)methodname stringval:(NSString *)stringval type:(NSInteger)type;

@end

@interface PatientProfileWEBViewController : UIViewController<navbardelegate,UITextFieldDelegate,UIAlertViewDelegate,UIWebViewDelegate,HXViewControllerdelegate>

@property(nonatomic,retain)NSString *methodname;

@property(nonatomic,retain)NSString *docteamid;

@property(nonatomic,retain)NSString *patientid;

@property(nonatomic,retain)NSString *targetid;

@property(nonatomic,assign)BOOL isnewteam;

@property(nonatomic,assign)BOOL isgroup;

@property(nonatomic,retain)UITextField *codetf1;

@property(nonatomic,assign) id <PatientProfileWEBViewControllerdelegate> delegate;

@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,retain)NSString *oldname;

@property(nonatomic,assign)BOOL needhidemorebtn;

-(void)loadprofileurl:(NSString *)profileurlstr;


@end
