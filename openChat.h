//
//  openChat.h
//  Proyolk
//
//  Created by PURPLE on 4/27/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "UIImageView+WebCache.h"
@interface openChat : UIViewController<PjsCallBack,CallTo_Parent,UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableDictionary *dictionaryByDate;
}
-(void)openchat:(UIViewController*)Vc withImage:(UIImage *)image;
-(void)isTyping:(NSArray *)data;
@property(nonatomic,strong) NSString *strTicketId,*strUserid;
@property(nonatomic) int flag;
@property(nonatomic,strong) UITableView *chatTableView;

@end
