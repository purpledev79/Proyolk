//
//  FriendProfile.h
//  Proyolk
//
//  Created by PURPLE on 5/24/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "UITextView+Placeholder.h"
#import "UIImageView+WebCache.h"
@interface FriendProfile : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent>

@property(nonatomic,strong) NSArray *ProfileAr;
@property(nonatomic,strong) NSString *scrollCtSt;
@property(nonatomic,strong) NSString *isCallBack;
@property(nonatomic,strong) NSArray *countryAr;
@property(nonatomic,retain)NSString *isFrndtab,*frnduid;
-(void) showEmployment:(NSArray *) employmntAr;
-(void)showProfileDetail:(UIView *)imgvw;
-(void)addProfileimage:(NSArray*)ProfileAr;
-(void)educationDetail;
@end
