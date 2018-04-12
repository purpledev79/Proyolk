

#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "StoragePopUp.h"

@interface CreateNewFolderpop : UIViewController<CallTo_Parent>
-(void) createNewFolder:(UIViewController *)vc:(StoragePopUp *)stpop;
@end

