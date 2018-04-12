//
//  DeleteFolderPop.h
//  Proyolk
//
//  Created by Purple Intellect on 22/04/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "StoragePopUp.h"

@interface DeleteFolderPop : UIViewController<CallTo_Parent>
-(void) reterivefolderhierchy:(UIViewController *)vc:(StoragePopUp *) stpop;
@end
