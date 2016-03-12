//
//  CallingViewController.m
//  CYS
//
//  Created by 谢阳晴 on 16/1/11.
//  Copyright © 2016年 谢阳晴. All rights reserved.
//

#import "CallingViewController.h"

#import "CircleProgressView.h"
#import "Session.h"

@interface CallingViewController ()
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) Session *session;

@end

@implementation CallingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"电话咨询";
    self.view.backgroundColor=KBackgroundColor;
    
    _circleProgressView=[[CircleProgressView alloc]initWithFrame:CGRectMake(60, 110, ScreenWidth-120, ScreenWidth-120)];
    self.circleProgressView.status = @"";
    self.circleProgressView.tintColor = [UIColor orangeColor];
    self.circleProgressView.elapsedTime = self.session.progressTime;
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(60, 8, ScreenWidth-120, 30);
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=KBlackColor;
    
    CGPoint cpoint=_circleProgressView.center;
    label.center=CGPointMake(cpoint.x, cpoint.y-30);
    label.font=[UIFont systemFontOfSize:16.0];
    label.backgroundColor=[UIColor clearColor];
    label.text=@"asdhaushsfh";
    [self.view addSubview:label];

    [self.view addSubview:_circleProgressView];
    
    _actionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _actionButton.tag=1002;
    _actionButton.frame=CGRectMake(15, ScreenHeight-80, ScreenWidth-30, 60);
    _actionButton.layer.masksToBounds = YES;
    _actionButton.layer.cornerRadius = 5.0;
    _actionButton.layer.borderWidth = 1.0;
    _actionButton.layer.borderColor = [KlightOrangeColor CGColor];
    [_actionButton setTitle:@"拨打电话" forState:UIControlStateNormal];
     [_actionButton setTitle:@"挂电话" forState:UIControlStateSelected];
    [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _actionButton.titleLabel.font=[UIFont systemFontOfSize:22.0];
    _actionButton.backgroundColor=KlightOrangeColor;
    [_actionButton addTarget:self action:@selector(callaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_actionButton];

    
    
    self.session = [[Session alloc] init];
    self.session.state = kSessionStateStop;
    
    self.circleProgressView.status = @"";
    self.circleProgressView.timeLimit = 60*8;
    self.circleProgressView.elapsedTime = 0;
    
    [self.actionButton setTintColor:[UIColor whiteColor]];
    
    [self startTimer];
    
    
    
    UIImageView *imagev;
    //=[[UIImageView alloc]init];
    
    
    imagev =[[UIImageView alloc]initWithFrame:CGRectMake(30, ScreenHeight-80-150, 60, 60)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    imagev.clipsToBounds=YES;
    
    imagev.layer.masksToBounds=YES;
    imagev.layer.cornerRadius =30.0;
    
    imagev.layer.borderWidth=1.0;
    imagev.layer.borderColor = KlightOrangeColor.CGColor;
    imagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [imagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [self.view addSubview:imagev];
    
    
    UIImageView *patientimagev;
    //=[[UIImageView alloc]init];
    
    
    patientimagev =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-90, ScreenHeight-80-150, 60, 60)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    patientimagev.clipsToBounds=YES;
    
    patientimagev.layer.masksToBounds=YES;
    patientimagev.layer.cornerRadius =30.0;
    patientimagev.layer.borderWidth=1.0;
    patientimagev.layer.borderColor = KlightOrangeColor.CGColor;
    patientimagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [patientimagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [self.view addSubview:patientimagev];

    
    
    
    UIView *connectlinev=[[UIView alloc]initWithFrame:CGRectMake(90, ScreenHeight-80-150+30, ScreenWidth-90-90, 1)];
    
    connectlinev.backgroundColor=KlightOrangeColor;
    
    [self.view addSubview:connectlinev];
    
    UIImageView *connectimagev;
    //=[[UIImageView alloc]init];
    
    
    connectimagev =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-90, ScreenHeight-80-150, 60, 60)];
    //   imagev.frame=CGRectMake(10, 8, 44, 44);
    
    
    
    
    connectimagev.clipsToBounds=YES;
    
    connectimagev.layer.masksToBounds=YES;
    connectimagev.layer.cornerRadius =30.0;
    connectimagev.layer.borderWidth=1.0;
    connectimagev.layer.borderColor = KlightOrangeColor.CGColor;
    connectimagev.layer.rasterizationScale = [UIScreen mainScreen].scale;
    connectimagev.center=connectlinev.center;
    // imagev.image=[UIImage imageNamed:@"KAKA"];
    //  NSLog(@"%@",[NSString stringWithFormat:@"%@",[datadic objectForKey:@"icon"]]);
    [connectimagev sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@""]] placeholderImage:[UIImage imageNamed:kPlaceholderimage]];
    [self.view addSubview:connectimagev];
    
    
    
    
    
    
}

-(void)callaction{
    _actionButton.selected=!_actionButton.selected;
    [self actionButtonClick];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
}
#pragma mark - Timer

- (void)startTimer {
    if ((!self.timer) || (![self.timer isValid])) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.00
                                                      target:self
                                                    selector:@selector(poolTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)poolTimer
{
    if ((self.session) && (self.session.state == kSessionStateStart))
    {
        self.circleProgressView.elapsedTime = 60*8-self.session.progressTime;
    }
}


#pragma mark - User Interaction

- (void)actionButtonClick{
    
    if (self.session.state == kSessionStateStop) {
        
        self.session.startDate = [NSDate date];
        self.session.finishDate = nil;
        self.session.state = kSessionStateStart;
        
        UIColor *tintColor =[UIColor orangeColor];
        self.circleProgressView.status = @"";
        self.circleProgressView.tintColor = tintColor;
        self.circleProgressView.elapsedTime = 0;
        
//        [self.actionButton setTitle:@"" forState:UIControlStateNormal];
//        [self.actionButton setTintColor:tintColor];
    }
    else {
        self.session.finishDate = [NSDate date];
        self.session.state = kSessionStateStop;
        
        self.circleProgressView.status = @"";
        self.circleProgressView.tintColor = [UIColor orangeColor];
        self.circleProgressView.elapsedTime = self.session.progressTime;
        
//        [self.actionButton setTitle:@"" forState:UIControlStateNormal];
//        [self.actionButton setTintColor:[UIColor whiteColor]];
    }
}




@end
