//
//  Jobpopup.h
//  Proyolk
//
//  Created by Purple Intellect on 25/03/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "PjsCallBack.h"
#import "BSKeyboardControls.h"

@interface Jobpopup : UIViewController<CallTo_Parent,PjsCallBack, BSKeyboardControlsDelegate, UITextFieldDelegate, UITextViewDelegate>

{
    UILabel *jdesc;
    BSKeyboardControls *_keyboardControls;
}
-(void)searchAdvance:(UIViewController*)Vc:(int)whichto;
-(void)sortby:(UIViewController*)Vc:(int)sortID;
-(void)OpenJobDetails:(UIViewController*)Vc:(int)whichjob:(NSString*)uid:(int)checktab;
-(void)ChangeStatus:(UIViewController*)Vc:(int)JobId:(NSString *)cstatus;
-(void)editJobdeatils:(UIViewController*)Vc:(int)jId;
-(void)AddnewProject:(UIViewController*)Vc;

@property(nonatomic,strong)IBOutlet UITableView *tableViewPoPosted;
@end
