//
//  MainBord.h
//  Proyolk
//
//  Created by Purple Intellect on 18/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "PjsCallBack.h"
#import "CallTo Parent.h"

@interface MainBord : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent,UIScrollViewDelegate>{
    NSDictionary* advSearchParams;
}

@property(nonatomic,strong)IBOutlet UITableView *myBoardtablevw,*sharedboardTableVw,*commTableView,*mynotification;
-(void) AddAdvanceSearch:(UIViewController*)Vc;
-(void)customizeActionBar:(UIViewController*)Vc;
@end
