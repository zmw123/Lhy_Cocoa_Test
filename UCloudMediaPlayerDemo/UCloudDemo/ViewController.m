//
//  ViewController.m
//  UCloudPlayerDemo
//
//  Created by yisanmao on 15/8/19.
//  Copyright (c) 2015年 yisanmao. All rights reserved.
//

#import "ViewController.h"
#import "UCloudMediaPlayer.h"
#import "UCloudMediaPlayback.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) UCloudMediaPlayer *mediaPlayer;
@property (strong, nonatomic) UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic) BOOL barHidden;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:UCloudMoviePlayerClickBack object:nil];
    
    self.textField.text = @"http://mediademo.ufile.ucloud.com.cn/ucloud_promo_140s.mp4";
    //@"http://mediademo.ufile.ucloud.com.cn/ucloud_promo_140s.mp4";未加密
    //@"http://guitazhangxxx.ufile.ucloud.com.cn/qianhai.flv"加密
    //@"rtmp://vlive2.rtmp.cdn.ucloud.com.cn/ucloud/123"推流
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.mediaPlayer)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        [[self navigationController] setNavigationBarHidden:YES];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return self.barHidden;
}

- (IBAction)play:(id)sender
{
//    隐藏导航栏
    self.barHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    
    NSString *str = self.textField.text;
    
    if (str.length == 0)
    {
        out:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"URL不可用" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            [self.textField becomeFirstResponder];
            return;
        }
    }
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *theMovieURL =[NSURL URLWithString:str];

    if (theMovieURL == nil)
    {
        goto out;
    }
    
    self.btn = sender;
    self.btn.hidden = YES;
    self.textField.hidden = YES;
    
    if ([theMovieURL isFileURL])
    {
        NSLog(@"is file url");
    }
    
    if ([theMovieURL checkResourceIsReachableAndReturnError:nil])
    {
        NSLog(@"error");
    }
    
//    theMovieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mtv" ofType:@"h264"]];
    
    self.mediaPlayer = [[UCloudMediaPlayer alloc] initWithUrl:theMovieURL showInViewController:self name:@"Test" decodeMthod:DecodeMthodSoft];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.player = self.mediaPlayer;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.textField isFirstResponder])
    {
        [self.textField resignFirstResponder];
    }
}

- (void)noti:(NSNotification *)noti
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if ([noti.name isEqualToString:UCloudMoviePlayerClickBack])
    {
        self.btn.hidden = NO;
        self.textField.hidden = NO;
        
        /**
         *  一定要置空
         */
        self.mediaPlayer = nil;
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        delegate.player = nil;
        
        self.barHidden = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  以下方法必须实现
 */
-(NSUInteger)supportedInterfaceOrientations
{
    if (self.mediaPlayer)
    {
        return self.mediaPlayer.supportInterOrtation;
    }
    else
    {
        /**
         *  这个在播放之外的程序支持的设备方向
         */
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UCloudViewControllerDidRotate object:nil];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UCloudViewControllerWillRotate object:@(toInterfaceOrientation)];
}

/*ios8之后 - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration 被弃用(但是还会调用)，可以使用下面的代理
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    UIInterfaceOrientation or = UIInterfaceOrientationUnknown;
    if (size.width > size.height)
    {
        or = UIInterfaceOrientationLandscapeLeft;
    }
    else
    {
        or = UIInterfaceOrientationPortrait;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:UCloudViewControllerWillRotate object:@(or)];
   
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UCloudViewControllerDidRotate object:nil];
    }];
}
*/
@end
