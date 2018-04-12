//
//  ViewController.h
//  pro22
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 iFlame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAScrollSegmentControl.h"
#import <AVFoundation/AVFoundation.h>
@interface TutorialViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *arrData;
    UIView *videomainview;
    AVPlayer *player;
}
@property(nonatomic,strong) IBOutlet YAScrollSegmentControl *segmentControl;
@property(nonatomic,strong) IBOutlet UIButton *btn1,*btn2,*btn3,*btn4;
@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet UITableView *tview;
-(IBAction)btnselectTab:(id)sender;
@end

