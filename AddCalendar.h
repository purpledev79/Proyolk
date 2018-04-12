//
//  AddCalendar.h
//  Proyolk
//
//  Created by PURPLE on 3/1/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "LeftRightDrawer.h"
#import "AddCalendar.h"
#import "AddCalend.h"



@interface AddCalendar : UIViewController<UITextFieldDelegate,UITextViewDelegate ,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent>
{
    NSString *strCalenderName;
    NSMutableArray *arrCalender;
    UIView *headercalendar1;
    LeftRightDrawer *drawer;
    UITableView *tblCalenderView;
    
    NSString* currentCalViewType;
    NSDictionary* currentCalendar;
    
}
@property(nonatomic,strong)IBOutlet UITableView *mynotification;


@end
