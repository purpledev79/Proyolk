//
//  CommonProfile.h
//  Proyolk
//
//  Created by Purple Intellect on 07/06/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "JobListVIewController.h"
#import <AVKit/AVKit.h>
#import "AppDelegate.h"
#import "ProfileView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
@interface CommonProfile : UIViewController<UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent,UITextViewDelegate>
{
    UIView *webviewView,*videomainview;
    NSMutableArray *arrJobs;
       AVPlayer *player;
    NSString *videoResume;
}
@property(nonatomic)int flag;
@property(nonatomic,strong) UITableView *jobtableView,*boardtableView,*podcasttableView;
-(void )addProfileimage:(NSArray *) profileAr:(int)frnid:(UIViewController *)vc;
@end
