//
//  FirstinfoViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/11.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLImageCrop.h"

#import "UserUIcontrol.h"

#import "NavBarView.h"

@interface FirstinfoViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,MLImageCropDelegate,usercontroldelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,navbardelegate>

@end
