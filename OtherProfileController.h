//
//  OtherProfileController.h
//  Proyolk
//
//  Created by Shiv ram on 07/03/17.
//  Copyright © 2017 PURPLE. All rights reserved.
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

@interface OtherProfileController : UIViewController<UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent,UITextViewDelegate>{
    UIView *webviewView,*videomainview;
    NSMutableArray *arrJobs;
    AVPlayer *player;
    NSString *videoResume;
}
@property NSString *friendId;
@property NSArray* profileAr;
@end
