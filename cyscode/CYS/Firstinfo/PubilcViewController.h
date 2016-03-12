//
//  PubilcViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/5.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebEnterViewController.h"
#import "HospitalWebViewController.h"
#import "MLImageCrop.h"

#import "UserUIcontrol.h"
#import "NavBarView.h"



@interface PubilcViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,navbardelegate,WebEnterViewControllerdelegate,HospitalWebViewControllerdelegate,usercontroldelegate,MLImageCropDelegate>
@property(nonatomic,retain)NSString *urslstr;
@property(nonatomic,assign)BOOL isreg;

@end
