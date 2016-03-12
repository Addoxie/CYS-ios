/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import <RongIMKit/RongIMKit.h>
#import "AppDelegate.h"
#import "RCDLoginViewController.h"
#import "RCDRCIMDataSource.h"
#import "RCDLoginInfo.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UIColor+RCColor.h"
//#import "RCWKRequestHandler.h"
//#import "RCWKNotifier.h"
#import "RCDCommonDefine.h"
#import "RCDHttpTool.h"
#import "AFHttpTool.h"
#import "RCDataBaseManager.h"
#import "RCDTestMessage.h"
#import "MobClick.h"

#import "FirstinfoViewController.h"

#import "MainTabBarController.h"

#import "UMSocialWechatHandler.h"




//#define RONGCLOUD_IM_APPKEY @"e0x9wycfx7flq" //offline key
#define RONGCLOUD_IM_APPKEY @"kj7swf8o70pf2" // online key

#define UMENG_APPKEY @"56cd4a21e0f55a49d70004ad"

#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)




@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   // [NSThread sleepForTimeInterval:2.0];
    i=0;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [WXApi registerApp:@"wx7e166aeb9c5b4d15" withDescription:@"zhongdianer 1.0"];
        [self.window makeKeyAndVisible];
    [[UserDB shareInstance]createTable];
    
    
    
    
    
    self.msgarr=[[NSMutableArray alloc]init];
    [UMSocialWechatHandler setWXAppId:@"wx7e166aeb9c5b4d15" appSecret:@"3013f8dd62f1554ce9301e9cb77b9120" url:@"http://www.chengyisheng.com.cn/"];
    
    [UMSocialData setAppKey:@"56cd4a21e0f55a49d70004ad"];
    
    [MobClick startWithAppkey:@"56cd4a21e0f55a49d70004ad" reportPolicy:BATCH channelId:@""];
    
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
//    [CCPCallService sharedInstance];
//    [[CCPCallService sharedInstance]setDelegate:self];
//    
//   NSInteger connettorl=[[CCPCallService sharedInstance]connectToCCP:@"sandboxapp.cloopen.com" onPort:8883 withAccount:@"8007660800000003" withPsw:@"8m8p57gw" withAccountSid:@"8a48b55151d2f2480151d32137e600ed" withAuthToken:@"2a61fdafb2c081713d38c26e53bc3a32"];
//    
//    if (connettorl==0) {
//        NSLog(@"success");
//    } else {
//        NSLog(@"fail");
//    }
//    
//    
//    [[CCPCallService sharedInstance]setSelfPhoneNumber:@"14800148000"];
//    
//    [[CCPCallService sharedInstance]setSelfName:@"hahaha"];
    
    
//    NSString *callid=[[CCPCallService sharedInstance]makeCallWithType:EVoipCallType_Voice andCalled:@"+8613761908082"];
//    
//    NSLog(@"%@",callid);
//    NSLog(@"%@",callid);
    
    
    mainv=[[MainTabBarController alloc]init];
    
    self.window.rootViewController= [[UINavigationController alloc]initWithRootViewController:mainv];
    //重定向log到本地问题
    //在info.plist中打开Application supports iTunes file sharing
    //    if (![[[UIDevice currentDevice] model] isEqualToString:@"iPhone
    //    Simulator"]) {
    //        [self redirectNSlogToDocumentFolder];
    

    //    }
    [self umengTrack];
    
//    [PatientDataService InvitePatientsWithMsisdns:@[] ShareInfoblock:^(id respdic) {
//        NSLog(@"haha");
//    }];
    
    
    /**
     *  推送说明：
     *  我们在知识库里还有推送调试页面加了很多说明，当遇到推送问题时可以去知识库里搜索还有查看推送测试页面的说明。
     *  首先必须设置deviceToken，可以搜索本文件关键字“推送处理”。模拟器是无法获取devicetoken，也就没有推送功能。
     *  当使用"开发／测试环境"的appkey测试推送时，必须用Development的证书打包，并且在后台上传"开发／测试环境"的推送证书，证书必须是development的。
     当使用"生产／线上环境"的appkey测试推送时，必须用Distribution的证书打包，并且在后台上传"生产／线上环境"的推送证书，证书必须是distribution的。
     */
    
    BOOL debugMode =NO;
    //[[NSUserDefaults standardUserDefaults] boolForKey:@"rongcloud appkey debug"];
    //debugMode是为了切换appkey测试用的，请应用忽略关于debugMode的信息，这里直接调用init。
    if (!debugMode) {
        
        //初始化融云SDK
        [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    }
    
    // 注册自定义测试消息
    [[RCIM sharedRCIM] registerMessageType:[RCDTestMessage class]];
    [[RCIMClient sharedRCIMClient]registerMessageType:RCDTestMessage.class];
    
    //设置会话列表头像和会话界面头像
    [RCIM sharedRCIM].globalConversationAvatarStyle=RC_USER_AVATAR_CYCLE;
    
    [RCIM sharedRCIM].globalMessageAvatarStyle=RC_USER_AVATAR_CYCLE;
    
//     [RCIM sharedRCIM].globalMessageAvatarStyle;
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    
    if (iPhone6Plus) {
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(56, 56);
    } else {
        NSLog(@"iPhone6 %d", iPhone6);
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    }
    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
  //  [RCIM sharedRCIM].enableMessageAttachUserInfo = false;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    
    
    
    
    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //登录
//    NSString *token =@"ilyiUfIm+lNntF5PemGkgja0hwwBjnSX8RnhaIN48kBgqoky7rdhgyVSKMVV1DMegjBMBJs4s9YMzy4FaYSThdseA1efPdGE";
//    
//    //[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
//    NSString *userId=@"yangqing";
//    //[DEFAULTS objectForKey:@"userId"];
//    NSString *userName =@"十一";
//    //[DEFAULTS objectForKey:@"userName"];
//    NSString *password = [DEFAULTS objectForKey:@"userPwd"];
//    NSString *userNickName =@"十一";
//    //[DEFAULTS objectForKey:@"userNickName"];
//    NSString *userPortraitUri =@"http://img4.duitang.com/uploads/item/201401/22/20140122112618_ZXznW.jpeg";
    //[DEFAULTS objectForKey:@"userPortraitUri"];
    
    
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]);
    
    [[RCIMClient sharedRCIMClient]connectWithToken:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"] success:^(NSString *userId) {
        NSLog(@"rc成功");
        
    } error:^(RCConnectErrorCode status) {
          NSLog(@"rc失败");
    } tokenIncorrect:^{
        
        [LoginDataService getNewSelfIMInfoblock:^(id respdic) {
            NSLog(@"%@",respdic);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[respdic objectForKey:@"im_id"] forKey:@"im-id"];
            [defaults setObject:[respdic objectForKey:@"im_reg_id"] forKey:@"im-token"];
            [defaults synchronize];
            [self login:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-id"] password:@"123456"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadindex" object:nil];
            
        }];

        //待处理
          NSLog(@"rc token错误");
        
    }];
//    if (token.length && userId.length && password.length && !debugMode) {
//        
//        
//        
//
//        
//        RCUserInfo *_currentUserInfo =
//        [[RCUserInfo alloc] initWithUserId:userId
//                                      name:userNickName
//                                  portrait:userPortraitUri];
//        
//        [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
//        [[RCIM sharedRCIM] connectWithToken:token
//                                    success:^(NSString *userId) {
//                                        
//                                        
////                                        NSInteger groupcount=(NSInteger)[[RCIMClient sharedRCIMClient]getTotalUnreadCount];
// //                             int groupmessagecount=[[RCIMClient sharedRCIMClient]getUnreadCount:ConversationType_GROUP targetId:nil];
////                                        //    int privatemessagecount=[[RCIMClient sharedRCIMClient]getUnreadCount:ConversationType_PRIVATE targetId:nil];
////                                        
////                                        NSLog(@"%zd",groupcount);
////                                        NSLog(@"%zd",groupcount);
//  
//      [[NSNotificationCenter defaultCenter]postNotificationName:@"havenewIMmsg" object:nil];
//                                        
//                                        
//                                        
//      [AFHttpTool loginWithEmail:userName password:password env:1 success:^(id response) {
//        if ([response[@"code"] intValue] == 200) {
//                [RCDHTTPTOOL getUserInfoByUserID:userId completion:^(RCUserInfo *user) {
//                
//                [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
//                
//              [RCDHTTPTOOL getUserInfoByUserID:userId completion:^(RCUserInfo* user) {
//                [[RCIM sharedRCIM]refreshUserInfoCache:user withUserId:userId];
//                [DEFAULTS setObject:user.portraitUri forKey:@"userPortraitUri"];
//                [DEFAULTS setObject:user.name forKey:@"userNickName"];
//                [DEFAULTS synchronize];
//                [RCIMClient sharedRCIMClient].currentUserInfo = user;
//              }];
//              
//
//        }];
//        //登陆demoserver成功之后才能调demo 的接口
//        [RCDDataSource syncGroups];
//        [RCDDataSource syncFriendList:^(NSMutableArray * result) {}];
//      }
//    }
//    failure:^(NSError *err){
//        
//    }];
//                                        //设置当前的用户信息
//                                        
//                                        //同步群组
//                                        //调用connectWithToken时数据库会同步打开，不用再等到block返回之后再访问数据库，因此不需要这里刷新
//                                        //这里仅保证之前已经成功登陆过，如果第一次登陆必须等block 返回之后才操作数据
//                                        //          dispatch_async(dispatch_get_main_queue(), ^{
//                                        //            UIStoryboard *storyboard =
//                                        //                [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                        //            UINavigationController *rootNavi = [storyboard
//                                        //                instantiateViewControllerWithIdentifier:@"rootNavi"];
//                                        //            self.window.rootViewController = rootNavi;
//                                        //          });
//    }error:^(RCConnectErrorCode status) {
//        
//        RCUserInfo *_currentUserInfo =[[RCUserInfo alloc] initWithUserId:userId name:userName portrait:nil];
//        [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
//        [RCDDataSource syncGroups];
//        NSLog(@"connect error %ld", (long)status);
//        dispatch_async(dispatch_get_main_queue(), ^{
//        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UINavigationController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"rootNavi"];
//                              //                self.window.rootViewController = rootNavi;
//            
//        });
//        
//    }tokenIncorrect:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//        RCDLoginViewController *loginVC =[[RCDLoginViewController alloc] init];
//            UINavigationController *_navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
//                                   //  self.window.rootViewController = _navi;
//                                     UIAlertView *alertView =
//                                     [[UIAlertView alloc] initWithTitle:nil
//                                                                message:@"Token已过期，请重新登录"
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil, nil];
//                                     ;
//                                     [alertView show];
//                                 });
//                             }];
//        
//    } else {
//        RCDLoginViewController *loginVC = [[RCDLoginViewController alloc] init];
//        // [loginVC defaultLogin];
//        // RCDLoginViewController* loginVC = [storyboard
//        // instantiateViewControllerWithIdentifier:@"loginVC"];
//        UINavigationController *_navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
//       // self.window.rootViewController = _navi;
//    }
    
    /**
     * 推送处理1
     */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    /**
     * 统计推送打开率1
     */
    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    /**
     * 获取融云推送服务扩展字段1
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromLaunchOptions:launchOptions];
    if (pushServiceData) {
        NSLog(@"该启动事件包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"%@", pushServiceData[key]);
        }
    } else {
        NSLog(@"该启动事件不包含来自融云的推送服务");
    }
    
    //统一导航条样式
    UIFont *font = [UIFont boldSystemFontOfSize:19.f];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName :[UIColor whiteColor]
                                     };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
  //  [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                        // forBarMetrics:UIBarMetricsDefault];
   // [[UIBarButtonItem appearance]setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
   //  backarowv.image=[UIImage imageNamed:@"back"];
    
   // [[UINavigationBar appearance] setTintColor:KOrangeColor];
//    [[UINavigationBar appearance]
//     setBarTintColor:[UIColor colorWithHexString:@"0195ff" alpha:1.0f]];
  //  [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navorangebgv"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:KOrangeColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  //  [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"back"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance]setBackIndicatorImage:[UIImage imageNamed:@"back2x"]];
//    [[UINavigationBar appearance]setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back2x"]];
    [UINavigationBar appearance].barStyle = UIStatusBarStyleDefault;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITextField appearance]setTintColor:KlightOrangeColor];
     [UITextField appearance].leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 40)];
     [UITextField appearance].leftViewMode = UITextFieldViewModeAlways;
    //[[UINavigationBar appearance]setTranslucent:NO];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    NSString *silence=KGetDefaultstr(@"silence");
    if (silence.length>0) {
        
        if ([KGetDefaultstr(@"silence")isEqualToString:@"yes"]) {
            [RCIM sharedRCIM].disableMessageAlertSound=YES;
            
        }else{
            [RCIM sharedRCIM].disableMessageAlertSound=NO;
            
            
        }
        

    }else{
        [RCIM sharedRCIM].disableMessageAlertSound=NO;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"no" forKey:@"silence"];
        [defaults synchronize];

   
    }
    
    
  
    
    //    NSArray *groups = [self getAllGroupInfo];
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:groups];
    //    NSArray *loadedContents = [NSKeyedUnarchiver
    //                               unarchiveObjectWithData:data];
    //    NSLog(@"loadedContents size is %d", loadedContents.count);
    
    testmodel=[[MsgModel alloc]init];
    testmodel.msgtype=@"NOTIF_TYPE_OFFLINE_ORDER_SUCCEED";
    testmodel.contentdic=[[NSMutableDictionary alloc]initWithDictionary:@{@"msg-body":@"hahahahaha"}];
    [self performSelector:@selector(sentmsg) withObject:nil afterDelay:10.0];
    
    return YES;
}

-(void)sentmsg{
//    [self.msgarr addObject:testmodel];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"havenewSystemMsg" object:testmodel];

}



//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}



- (void)login:(NSString *)userName password:(NSString *)password
{
    RCNetworkStatus stauts=[[RCIMClient sharedRCIMClient]getCurrentNetworkStatus];
    
    if (RC_NotReachable == stauts) {
        // _errorMsgLb.text=@"当前网络不可用，请检查！";
        return;
    } else {
        // _errorMsgLb.text=@"";
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey :@"UserCookies"];
    [self loginRongCloud:@"haha@chengyisheng.com" token:[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"] password:password];
    
}
- (void)loginRongCloud:(NSString *)userName token:(NSString *)token password:(NSString *)password
{
    token=[[NSUserDefaults standardUserDefaults]objectForKey:@"im-token"];
    NSLog(@"%@",token);
    //登陆融云服务器
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        
    } error:^(RCConnectErrorCode status) {
       
      
        
    } tokenIncorrect:^{
        NSLog(@"IncorrectToken");  
        
        
    }];
}


-(BOOL)onRCIMCustomLocalNotification:(RCMessage*)message withSenderName:(NSString *)senderName{
    return NO;
}

- (BOOL)onRCIMCustomAlertSound:(RCMessage *)message{
    return NO;
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
//    NSArray *myarr=[[RCDataBaseManager shareInstance] getAllUserInfo];
//    RCUserInfo *model=(RCUserInfo *)[myarr objectAtIndex:i];
//    i++;
//     NSLog(@"portraitUri %@",model.portraitUri);
    NSLog(@"%@",userId);
    
    [UserDataService getUserInfofortargetIdWithtargetId:userId block:^(id userinfomodel) {
        UserInfoModel *model=(UserInfoModel *)userinfomodel;
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = userId;
        user.name =model.username;
        user.portraitUri = model.pimgurl;
        
        NSLog(@"头像 ：%@",model.pimgurl);
        //  if (userId==model.userId) {
        return completion(user);

//        [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pimgurl]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
//        label.text=[NSString stringWithFormat:@"%@",model.username];
    }];
    
//    RCUserInfo *user = [[RCUserInfo alloc]init];
//    user.userId = userId;
//    user.name = @"东斌";
//    user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//    
//
//  //  if (userId==model.userId) {
//        return completion(user);
 //   }
  //  return completion(nil);
    
}
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    
//    NSArray *myarr= [RCDDataSource getAllGroupInfo:nil];
//    RCGroup *model=(RCGroup *)[myarr objectAtIndex:i];
//    i++;
//    NSLog(@"portraitUri %@",model.portraitUri);
    
    
    
    
    
    
    
    
    
    RCGroup *user = [[RCGroup alloc]init];
    //    if (model) {
    //        <#statements#>
    //    }
   // if ([model.groupId isEqualToString:groupId]) {
    
    
    NSLog(@"%@",user.groupId);
     NSLog(@"%@",groupId);
    
    
    
    
    [UserDataService getGroupInfofortargetIdWithGroupId:groupId block:^(id usermodel) {
        GroupInfoModel *uinfomodel=(GroupInfoModel *)usermodel;
        NSLog(@"%@",uinfomodel.groupinfodic);
         NSLog(@"%@",uinfomodel.groupinfodic);
        
        user.groupId = groupId;
        user.groupName = [NSString stringWithFormat:@"%@团队",[[uinfomodel.groupinfodic objectForKey:@"team"] objectForKey:@"name"]];
        user.portraitUri = [[uinfomodel.groupinfodic objectForKey:@"owner"] objectForKey:@"icon_url"];

          return completion(user);
        
    }];

//    if ( [groupId isEqualToString:@"123456"]) {
//    
//    }else  if ( [groupId isEqualToString:@"123457"]) {
//        user.groupId = @"123457";
//        user.groupName = @"2个神奇的群";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123458"]) {
//        user.groupId = @"123458";
//        user.groupName = @"3个神奇的群";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123461"]) {
//        user.groupId = @"123461";
//        user.groupName = @"神奇的群1";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123462"]) {
//        user.groupId = @"123462";
//        user.groupName = @"神奇的群2";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else  if ( [groupId isEqualToString:@"123463"]) {
//        user.groupId = @"123463";
//        user.groupName = @"神奇的群3";
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }else {
//       // user.groupId = @"123456";
//        user.groupName = @"神奇群【广州中心医院心内科胡大一】";
//       // NSString *contentStr = @"简介：hello world";
//      //  NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//        //设置：在0-3个单位长度内的内容显示成红色
//        //[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//        //label.attributedText = str;
//       // user.groupName=str;
//        user.portraitUri = @"http://img.taopic.com/uploads/allimg/140119/234926-14011ZU35340.jpg";
//        
//    }
//    
    
    
  
//     }
//  return completion(nil);
    
}
- (void)getUserInfoWithUserId:(NSString *)userId
                      inGroup:(NSString *)groupId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    RCUserInfo *user = [[RCUserInfo alloc]init];
    user.userId = userId;
    user.name = @"东斌";
    user.portraitUri = @"http://img.taopic.com/uploads/allimg/130724/240450-130H422422687.jpg";
    
    
    //  if (userId==model.userId) {
    return completion(user);

    
}
/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}


/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    
    NSString *token1 = [NSString stringWithFormat:@"%@", deviceToken];
    //////NSLog(@"My token is:%@", token);
    
    
    NSString *subtokenstr= [token1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *subtokenstr1=[subtokenstr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSString *tokenstr=[subtokenstr1 stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tokenstr forKey:@"pushtoken"];
    // [defaults setObject:@"YES" forKey:@"isneedpush"];
    
    [defaults synchronize];

    
    
    
    [APPRegDataService regToken:tokenstr block:^(id resultdic) {
        //
        //
                    NSLog(@"tokenstr: %@",tokenstr);
    }];
    
    
    
    
    
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
//        for (id key in [pushServiceData allKeys]) {
//            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
//        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
    
    if ([userInfo objectForKey:@"aps"]!=nil) {
        NSDictionary *dic=[userInfo objectForKey:@"aps"];
        NSLog(@"%@",userInfo);
        MsgModel *msgmodel=[[MsgModel alloc]init];
        
//        msgmodel.msgtype=[dic objectForKey:@"msg-type"];
//        
//        msgmodel.msgtype=[userInfo objectForKey:@"aps"];
        
       
        msgmodel.msgtype=[dic objectForKey:@"msg_type"];
        msgmodel.contentdic=[[NSMutableDictionary alloc]initWithDictionary:@{@"msg-body":[[dic objectForKey:@"msg_content"] objectForKey:@"msg-body"]}];
        
        [self loadMsgWithtype:msgmodel];
    }
  
    
    
    
    
    
    
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计推送打开率3
     */
    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
    
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_APPSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    application.applicationIconBadgeNumber = unreadMsgCount;
  //  [[RCIM sharedRCIM]disconnect];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state;
    // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the
    // application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}

- (void)redirectNSlogToDocumentFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMddHHmmss"];
    NSString *formattedDate = [dateformatter stringFromDate:currentDate];
    
    NSString *fileName = [NSString stringWithFormat:@"rc%@.log", formattedDate];
    NSString *logFilePath =
    [documentDirectory stringByAppendingPathComponent:fileName];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stderr);
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

- (void)application:(UIApplication *)application
handleWatchKitExtensionRequest:(NSDictionary *)userInfo
              reply:(void (^)(NSDictionary *))reply {
//    RCWKRequestHandler *handler =
//    [[RCWKRequestHandler alloc] initHelperWithUserInfo:userInfo
//                                              provider:self
//                                                 reply:reply];
//    if (![handler handleWatchKitRequest]) {
//        // can not handled!
//        // app should handle it here
//        NSLog(@"not handled the request: %@", userInfo);
//    }
}
#pragma mark - RCWKAppInfoProvider
- (NSString *)getAppName {
    return @"橙医生";
}

- (NSString *)getAppGroups {
    return @"group.com.RCloud.UIComponent.WKShare";
}

- (NSArray *)getAllUserInfo {
    return [RCDDataSource getAllUserInfo:^ {
      //  [[RCWKNotifier sharedWKNotifier] notifyWatchKitUserInfoChanged];
    }];
}
- (NSArray *)getAllGroupInfo {
    return [RCDDataSource getAllGroupInfo:^{
       // [[RCWKNotifier sharedWKNotifier] notifyWatchKitGroupChanged];
    }];
}
- (NSArray *)getAllFriends {
    return [RCDDataSource getAllFriends:^ {
       // [[RCWKNotifier sharedWKNotifier] notifyWatchKitFriendChanged];
    }];
}
- (void)openParentApp {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"rongcloud://connect"]];
}
- (BOOL)getNewMessageNotificationSound {
    return ![RCIM sharedRCIM].disableMessageAlertSound;
}
- (void)setNewMessageNotificationSound:(BOOL)on {
    [RCIM sharedRCIM].disableMessageAlertSound = !on;
}
- (void)logout {
    [DEFAULTS removeObjectForKey:@"userName"];
    [DEFAULTS removeObjectForKey:@"userPwd"];
    [DEFAULTS removeObjectForKey:@"userToken"];
    [DEFAULTS removeObjectForKey:@"userCookie"];
    if (self.window.rootViewController != nil) {
        UIStoryboard *storyboard =
        [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RCDLoginViewController *loginVC =
        [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        UINavigationController *navi =
        [[UINavigationController alloc] initWithRootViewController:loginVC];
     //   self.window.rootViewController = navi;
    }
    [[RCIMClient sharedRCIMClient] disconnect:NO];
}
- (BOOL)getLoginStatus {
    NSString *token = [DEFAULTS stringForKey:@"userToken"];
    if (token.length) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - RCIMConnectionStatusDelegate

/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"relogin" object:nil];
//        [[PublicTools shareInstance]setmyPview:[UIApplication sharedApplication].keyWindow];
//        [[PublicTools shareInstance]creareNotificationUIView:@"请重新登录"];

        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        RCDLoginViewController *loginVC = [[RCDLoginViewController alloc] init];
        // [loginVC defaultLogin];
        // RCDLoginViewController* loginVC = [storyboard
        // instantiateViewControllerWithIdentifier:@"loginVC"];
       // UINavigationController *_navi =
        //[[UINavigationController alloc] initWithRootViewController:loginVC];
   //     self.window.rootViewController = _navi;
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RCDLoginViewController *loginVC =
            [[RCDLoginViewController alloc] init];
           // UINavigationController *_navi = [[UINavigationController alloc]
            //                                 initWithRootViewController:loginVC];
  //          self.window.rootViewController = _navi;
//            UIAlertView *alertView =
//            [[UIAlertView alloc] initWithTitle:nil
//                                       message:@"Token已过期，请重新登录"
//                                      delegate:nil
//                             cancelButtonTitle:@"确定"
//                             otherButtonTitles:nil, nil];
//            [alertView show];
        });
    }
}

-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    if ([message.content isMemberOfClass:[RCInformationNotificationMessage class]]) {
        RCInformationNotificationMessage *msg=(RCInformationNotificationMessage *)message.content;
        //NSString *str = [NSString stringWithFormat:@"%@",msg.message];
        if ([msg.message rangeOfString:@"你已添加了"].location!=NSNotFound) {
            [RCDDataSource syncFriendList:^(NSMutableArray *friends) {
            }];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:RCKitDispatchMessageNotification
     object:nil];
}

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //||[TencentOAuth HandleOpenURL:url]||[QQApiInterface handleOpenURL:url delegate:self]
    return [WXApi handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
//    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
//    if ([url.host isEqualToString:@"safepay"]) {
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
//                                                  standbyCallback:^(NSDictionary *resultDic) {
//                                                      //////NSLog(@"result = %@",resultDic);
//                                                  }]; }
//    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
//        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //////NSLog(@"result = %@",resultDic);
//        }];
//    }
//    //||[TencentOAuth HandleOpenURL:url]||[QQApiInterface handleOpenURL:url delegate:self];
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }

    
    
    return result;
}
#pragma mark - private
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        //NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        if (resp.errCode==0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:@"分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        //SendAuthResp *temp = (SendAuthResp*)resp;
        //[HUD dismissAfterDelay:10.0];
        
        //        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        //        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        
        //        NSMutableDictionary *reqdic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:uid,@"username",@"12345",@"password",nil];
        //   NSString *urlstring=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxe9c0dbdde9756cec&secret=f65e197b2009dd50943984201de6e7fe&code=%@&grant_type=authorization_code",temp.code];
        //
        //        [PublicTools requestWithASIURL:urlstring parmas:nil httpMethod:@"GET" ismultiObj:NO completeBlock:^(id mydata) {
        //            //   //////NSLog(@"%@",mydata);
        //            // [HUD dismiss];
        //
        //
        //            if (mydata!=nil) {
        //
        //                // //////NSLog(@"%@",mydata);
        //                NSMutableDictionary *userinfodic=(NSMutableDictionary *)mydata;
        //                NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        //
        //                [ud setObject:[userinfodic objectForKey:@"access_token"] forKey:@"token"];
        //                [ud setObject:[userinfodic objectForKey:@"openid"] forKey:@"uid"];
        //
        //                [ud synchronize];
        //
        //
        //                NSString *urlstring=[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",[userinfodic objectForKey:@"access_token"],[userinfodic objectForKey:@"openid"]];
        //
        //                [PublicTools requestWithASIURL:urlstring parmas:nil httpMethod:@"GET" ismultiObj:NO completeBlock:^(id mydata) {
        //                    //   //////NSLog(@"%@",mydata);
        //
        //                    if (mydata!=nil) {
        //                        //  [HUD dismiss];
        //
        //                        // //////NSLog(@"%@",mydata);
        //                        NSMutableDictionary *userinfodic=(NSMutableDictionary *)mydata;
        //                        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        //
        //                        [ud setObject:[userinfodic objectForKey:@"city"] forKey:@"city"];
        //                        [ud setObject:@"hello" forKey:@"newid"];
        //                        [ud setObject:[userinfodic objectForKey:@"nickname"] forKey:@"mynickname"];
        //                        [ud setObject:[userinfodic objectForKey:@"headimgurl"] forKey:@"mythum"];
        //                        [ud setObject:@"微信已登录" forKey:@"logintype"];
        //                        [ud setObject:[[userinfodic objectForKey:@"sex"]stringValue] forKey:@"sex"];
        //
        //                        [ud synchronize];
        //
        //                        [[NSNotificationCenter defaultCenter]postNotificationName:@"weixinlogin" object:HUD];
        //                    }
        //
        //
        //                }];
        //
        //                //            self.datarr=[mydata objectForKey:@"data"];
        //                //            [self.collectionView reloadData];
        //            }
        //
        //
        //            // 结束刷新
        //        }];
        
        
        
        
        
        //        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        //        NSString *token=[userinfodic objectForKey:@"token"];
        //        [ud setObject:token forKey:@"token"];
        //        [ud setObject:[[userinfodic objectForKey:@"data"] objectForKey:@"id"] forKey:@"uid"];
        //        [ud setObject:[[userinfodic objectForKey:@"data"] objectForKey:@"username"] forKey:@"username"];
        //        [ud setObject:[[userinfodic objectForKey:@"data"] objectForKey:@"nickname"] forKey:@"nickname"];
        //        [ud setObject:[[userinfodic objectForKey:@"data"] objectForKey:@"thum"] forKey:@"thum"];
        //        [ud synchronize];
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        
    }
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle=[[NSString alloc]init];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                
                strMsg = @"支付结果：成功！";
                //////NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"payresult" object:[NSString stringWithFormat:@"yes,%d",resp.errCode]];
                break;
                
            default:
                
                
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                //////NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"payresult" object:[NSString stringWithFormat:@"no,%d",resp.errCode]];
                
                break;
        }
    }
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}


#pragma msgActions


-(void)loadmsg{
    [NotificationService getAllUnreadMessagesCountblock:^(id respdic) {
        NSDictionary *dic=(NSDictionary *)respdic;
        if (![[[dic objectForKey:@"count"] stringValue] isEqualToString:@"0"]) {
             mainv.msgcount=@"12";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"haveSystemMsg" object:nil];
        }
       
    }];
    
}



-(void)loadMsgWithtype:(MsgModel *)msgmodel{
    
   // MsgModel *model=[[MsgModel alloc]init];
    [self.msgarr addObject:msgmodel];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"havenewSystemMsg" object:msgmodel];
    
}

@end
