//
//  BoardPopUp.h
//  Proyolk
//
//  Created by Purple Intellect on 21/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "PjsCallBack.h"
#import "UIImageView+WebCache.h"
@interface BoardPopUp : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent>
{
    UILabel *cmnt;
    UIButton *proyolkBtn1;
    UIButton *proyolkBtn2;
    UIButton *proyolkBtn3;
    
    UIView *mainView1;
    
    UITableView* shareUsersTable;
    UITableView* pendingUsersTable;
    NSArray* sharedUsers;
    NSArray* pendingUsers;
}
@property(nonatomic,strong)IBOutlet UITableView *commentTableView,*inviteTableView,*ProyolkTableView,*networkTableview,*ProyolkFrndTableView;
-(void)advanceSearch:(UIViewController *)Vc:(int)advnceID;
-(void)addnewBoard:(UIViewController *)Vc;
-(void)sortby:(UIViewController*)Vc:(int)sortID;
-(void)IndustrySearch:(UIViewController*)Vc;
-(void)showcommentView:(UIViewController*)Vc:(int)b_id1:(int)whichBoard:(int)kid;
-(void)IndustrySearch:(UIViewController*)Vc:(int)indusId:(int)limit;
-(void)privateView:(UIViewController*)Vc;
-(void)calMem:(UIViewController*)Vc:(NSArray*)calAr;
-(void)shareit:(UIViewController*)Vc:(int)ModId;
-(void) reterivefrndforcal:(UIViewController *)vc:(int) ischeck ;
@end
