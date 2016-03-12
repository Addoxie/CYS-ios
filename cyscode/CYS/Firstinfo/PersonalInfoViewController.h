//
//  PersonalInfoViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/2/19.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WebEnterViewController.h"
#import "HospitalWebViewController.h"
#import "MLImageCrop.h"

#import "UserUIcontrol.h"
#import "DescriptionViewController.h"
#import "SpecialViewController.h"


@interface PersonalInfoViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,navbardelegate,WebEnterViewControllerdelegate,HospitalWebViewControllerdelegate,usercontroldelegate,MLImageCropDelegate,DescriptionViewControllerdelegate,SpecialViewControllerdelegate>
@property(nonatomic,retain)NSString *urslstr;

@property(nonatomic,assign)BOOL isPersonal;
@end
