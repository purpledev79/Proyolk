//
//  Podcast.h
//  Proyolk
//
//  Created by Purple Intellect on 22/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "PjsCallBack.h"


@interface Podcast : UIViewController<CallTo_Parent>
@property(nonatomic,strong)IBOutlet UITableView *upcomingtableView,*recentTableView,*mynotification;
-(void)advanceSearch:(UIViewController *)Vc;
-(void)addnewBoard:(UIViewController *)Vc;
-(void)sortby:(UIViewController*)Vc;
@end
