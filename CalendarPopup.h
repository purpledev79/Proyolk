//
//  CalendarPopup.h
//  Proyolk
//
//  Created by PURPLE on 3/2/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "MyLabel.h"
#import "AddEvent.h"
#import "AddTicket.h"
#import "AppDelegate.h"
#import "AddCalend.h"
@interface CalendarPopup : UIViewController<PjsCallBack,CallTo_Parent>{
    AddEvent *event;
    AddCalend *addCalend;
}

-(void) addCalendar:(UIViewController *) Vc;
-(void) addEvent:(UIViewController *) Vc;
-(void) ViewEventList:(UIViewController *)Vc:(NSArray *) eventAr;
-(void)addAndDelete:(UIViewController *)Vc: (int) eventId:(NSArray *)eventAr;
-(void) ViewweekEventList:(UIViewController *)Vc:(NSArray *)dataAr;
-(void)privatefrndAr:(NSMutableArray *)frAr;
@end
