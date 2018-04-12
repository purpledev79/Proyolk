//
//  StoragePopUp.h
//  Proyolk
//
//  Created by Purple Intellect on 08/04/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "AlertView.h"
#import "MBProgressHUD.h"
@interface StoragePopUp : UIViewController<CallTo_Parent>
{
    UIButton *proyolkBtn1;
    UIButton *proyolkBtn2;
    UIButton *proyolkBtn3;
    UIScrollView *scrollbar1;
    MBProgressHUD *HUD;
    NSMutableArray *arrData;
    
}

-(void) showMyfileView:(UIViewController *)vc:(NSArray *)data;
-(void)filterpopup:(UIViewController *)vc dictFilter:(NSMutableDictionary *)dictFil;
-(void)sortedfilter:(UIViewController *)vc dictFilter:(NSMutableDictionary *)dictFil;
-(void)moveto:(UIViewController*)Vc;
@property (nonatomic,strong)NSString *fileid,*filename,*uid_from;
-(void)downloadImg:(NSString *)path1 user:(NSString *)strId;


@property(nonatomic,strong)IBOutlet UITableView *Filetable,*communitytable,*sharedtable,*networktable;
@end
