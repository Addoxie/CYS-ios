//
//  UploadViewController.h
//  CYS
//
//  Created by 谢阳晴 on 16/1/5.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLImageCrop.h"

#import "UserUIcontrol.h"

@interface UploadViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,MLImageCropDelegate,usercontroldelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,navbardelegate>
@property(nonatomic,retain)NSString *urslstr;
@end
