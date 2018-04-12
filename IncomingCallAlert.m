//
//  IncomingCallAlert.m
//  Proyolk
//
//  Created by Shiv ram on 06/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "IncomingCallAlert.h"
#import "ManageArray.h"
#import "UIImageView+WebCache.h"
#import "SavePrefrences.h"
#import "VideoChatController.h"
#import "AppDelegate.h"

@interface IncomingCallAlert (){
    AVAudioPlayer *ringtonePlayer;
}

@end

@implementation IncomingCallAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(_confArr){
        [_callerNameLbl setText:[NSString stringWithFormat:@"%@ %@ has initiated a conference call.", _contact[@"fname"], _contact[@"lname"]]];
    }else
        [_callerNameLbl setText:[NSString stringWithFormat:@"%@ %@", _contact[@"fname"], _contact[@"lname"]]];
    NSString *img = _contact[@"img"];
     ManageArray *mang = [[ManageArray alloc] init];
    NSString * url=[mang concatUrl:img];
    [_callerImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/callertone.mp3",[[NSBundle mainBundle] resourcePath]];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    ringtonePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    ringtonePlayer.numberOfLoops = -1; //Infinite
    [ringtonePlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [ringtonePlayer stop];
}

- (IBAction)acceptCallAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:@"strTag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        appDelegate.videoController = [mainStoryboard instantiateViewControllerWithIdentifier:@"VideoChatController"];
        appDelegate.videoController.acceptedCall = [NSString stringWithFormat:@"%@", _userId];
        appDelegate.videoController.confUsers = _confArr;
        [appDelegate.navigationController setViewControllers:@[appDelegate.videoController] animated:NO];
        
        self.isShowing = NO;
        [ringtonePlayer stop];
    }];
}

- (IBAction)rejectCallAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:_userId forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"cc" :@"" :@"" :params :self ];
        self.isShowing = NO;
        [ringtonePlayer stop];
    }];
}
@end
