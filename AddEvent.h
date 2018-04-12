//
//  AddEvent.h
//  Proyolk
//
//  Created by Padam on 11/18/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>
#import "SavePrefrences.h"
#import "SelectCountry.h"
#import "AppDelegate.h"
#import "AllValidationsViewController.h"
#define UIViewParentController(__view) ({ \
UIResponder *__responder = __view; \
while ([__responder isKindOfClass:[UIView class]]) \
__responder = [__responder nextResponder]; \
(UIViewController *)__responder; \
})

@protocol AddEventDelegate <NSObject>

-(void) didPressSelectCountry:(id)obj;
-(void) didPressSelectState:(id)obj;
-(void) didPressSelectCity:(id)obj;
@end

@interface AddEvent : UIView<UITextFieldDelegate>{
    UIView *headercalendar,*prMainView,*datePickerView;
    UIDatePicker *datepicker;
    int iscallback;
    CGFloat cellheight;
    UITextField    *search_lbl;
    UIView *viewfortable;
    UILabel *NameLabel1;
    NSMutableArray *shareAr,*inviteAr,*netAr;
    UITableView *networktable,*sharedtable;
    int isdate;
    AllValidationsViewController *av;
     NSString * isCallBack;
    NSMutableArray *countryAr,*stateAr,*cityAr;
    NSString * stid ,*cid,*cal_id,*czsid,*cztid,*czid;
    
    int selectedColor;
    NSString* tillDateValue;
    NSString* numOfDaysRepeat;
    NSString* calendarId;
}

@property(nonatomic, strong) NSString* eventType;
@property(nonatomic, strong) NSArray* myCalendars;

@property(nonatomic,strong) NSMutableArray *arrData;
@property(nonatomic,assign)id<AddEventDelegate> delegationListener;
@property (weak, nonatomic) IBOutlet UITextField *txtTItle;
@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UITextField *txtStartTime;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtEndTIme;
- (IBAction)btnLocationAction:(id)sender;
- (IBAction)btnisVideoCall:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;

@property (weak, nonatomic) IBOutlet UIButton *btnisVideo;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForLocation;

@property (weak, nonatomic) IBOutlet UITextField *txtField;

- (IBAction)btnColourChangeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPublic;
@property (weak, nonatomic) IBOutlet UIButton *btnFriend;
- (IBAction)btnVisibilityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivate;
@property (weak, nonatomic) IBOutlet UIButton *btnOnce;

@property (weak, nonatomic) IBOutlet UIButton *btnDaily;
@property (weak, nonatomic) IBOutlet UIButton *btnWeekly;
@property (weak, nonatomic) IBOutlet UIButton *btnMOnthly;
@property (weak, nonatomic) IBOutlet UIButton *btnWeekdays;
@property (weak, nonatomic) IBOutlet UIButton *btnYearly;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightScrollVContstant;
- (IBAction)btnRepeatAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtInterval;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnSMS;
@property (weak, nonatomic) IBOutlet UIButton *btnPopUP;
@property (weak, nonatomic) IBOutlet UIButton *btnNetwork;
@property (weak, nonatomic) IBOutlet UITextView *txtEventDesc;

- (IBAction)btnNotificationAction:(id)sender;
- (IBAction)btnInviteAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCabinet;
- (IBAction)btnAttachFileAction:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *weeklyView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *weekdaysBtns;
- (IBAction)weekDaySelection:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *eventRepeatTimeView;
@property (strong, nonatomic) IBOutlet UITextField *repeatTillDateTF;
@property (strong, nonatomic) IBOutlet UITextField *repeatForDays;
- (IBAction)weekDaySelectionDone:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *calendarSelectTF;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *eventColours;















@end
