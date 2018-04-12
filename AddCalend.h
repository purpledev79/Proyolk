//
//  AddCalender.h
//  Proyolk
//
//  Created by Padam on 11/19/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavePrefrences.h"
#import "UIImageView+WebCache.h"
@protocol AddCalendDelegate <NSObject>
-(void) didPressSelectTimezone:(id)obj;
-(void) didPressSelectCountrie:(id)obj;
@end


@interface AddCalend : UIView{
    int iscallback;
    CGFloat cellheight;
    UITextField    *search_lbl;
    UIView *prMainView,*viewfortable;
    UILabel *NameLabel1;
    NSMutableArray *shareAr,*inviteAr,*netAr;
    UITableView *networktable,*sharedtable;
    UIButton *selectAll;
}
@property(nonatomic,strong) NSString *strCountryId,*strCountryWebCode, *strTimeZoneId;
@property(nonatomic,assign)id<AddCalendDelegate> delegationListener;
@property (weak, nonatomic) IBOutlet UITextField *txtCalenderName;
@property (weak, nonatomic) IBOutlet UITextField *txtLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtTimeZone;
@property (weak, nonatomic) IBOutlet UIButton *btnNetwork;
- (IBAction)btnSharedAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCabinet;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivate;
- (IBAction)btnVisibilityAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPublic;
@property (weak, nonatomic) IBOutlet UIButton *btnFrined;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;

@end
