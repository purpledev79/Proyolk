//
//  Job.h
//  Proyolk
//
//  Created by Purple Intellect on 23/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "Interview.h"
#import "CallTo Parent.h"
#import "UITextView+Placeholder.h"
@interface Job : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent>
@property(nonatomic,strong) UIView *containerView;

@property(nonatomic,strong)IBOutlet UITableView *mynotification,*jobAppliedTableview,*jobAwaredjobtableview,*poprojectTableView,*allPoTableView,*applicantTableView;
@end
