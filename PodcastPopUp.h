//
//  PodcastPopUp.h
//  Proyolk
//
//  Created by Purple Intellect on 22/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "PjsCallBack.h"

@interface PodcastPopUp : UIViewController<CallTo_Parent,PjsCallBack>
{
    UIButton *proyolkBtn1;
    UIButton *proyolkBtn2;
    UIButton *proyolkBtn3;

}
-(void) setTabBar:(UIViewController*)Vc;
-(void)AddnewPodcast:(UIViewController*)Vc;
-(void)readMore:(UIViewController*)Vc:(NSArray *) data;
-(void)PodcastAdvance:(UIViewController*)Vc:(int)advnceID;
-(void)openUprcntEvent:(UIViewController*)Vc:(NSString*)podid:(NSString*)u_id:(int)chkevent;
@property(nonatomic,strong)IBOutlet UITableView *PodcastTableView,*sharedPodTable,*libTableView,*ProyolkFrndTableView,*ProyolkTableView,*networkTableview;

@end
