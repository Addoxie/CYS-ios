//
//  MyspaceViewController.h
//  CYS
//
//  Created by 谢阳晴 on 15/12/17.
//  Copyright © 2015年 谢阳晴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLImageCrop.h"

#import "UserUIcontrol.h"

@interface MyspaceViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,MLImageCropDelegate,usercontroldelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,navbardelegate>

@end
