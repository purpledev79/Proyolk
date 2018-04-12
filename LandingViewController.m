//
//  LandingViewController.m
//  Proyolk
//
//  Created by Shiv ram on 03/04/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "LandingViewController.h"
#import "AppDelegate.h"

@interface LandingViewController ()

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    [[_loginBtn layer] setBorderColor:[UIColor colorWithRed:0.95 green:0.79 blue:0.00 alpha:1.0].CGColor];
    [[_signUpBtn layer] setBorderColor:[UIColor colorWithRed:0.95 green:0.79 blue:0.00 alpha:1.0].CGColor];
    
    [_loginBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.95 green:0.79 blue:0.00 alpha:1.0]] forState:UIControlStateHighlighted];
    [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_signUpBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.95 green:0.79 blue:0.00 alpha:1.0]] forState:UIControlStateHighlighted];
    [_signUpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
}

-(void)viewWillAppear:(BOOL)animated{
}

-(void)viewDidAppear:(BOOL)animated{
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"introVideo" withExtension:@"mp4"];
    AKVideoImageView *videoBG = [[AKVideoImageView alloc] initWithFrame:_videoBGView.bounds
                                                               videoURL:videoURL];
    [_videoBGView addSubview:videoBG];
    [_videoBGView sendSubviewToBack:videoBG];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playTutorials:(id)sender {
    
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    MainController *vc=[[MainController alloc]init];
    vc.isTutorial = YES;
    [appDel.navigationController setViewControllers:@[vc] animated:NO];
}


- (IBAction)signUpAction:(id)sender {
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    MainController *vc=[[MainController alloc]init];
    vc.isRegister = YES;
    vc.isNavigatedFromLanding = YES;
    [appDel.navigationController setViewControllers:@[vc] animated:NO];
}

- (IBAction)loginAction:(id)sender {
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    MainController *vc=[[MainController alloc]init];
    [appDel.navigationController setViewControllers:@[vc] animated:NO];
}
@end
