
#import "PjsCallBack.h"
#import <UIKit/UIKit.h>
#import "CallTo Parent.h"
#import "VideoChatController.h"
#import "UIImageView+WebCache.h"
@interface LeftRightDrawer : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,PjsCallBack,CallTo_Parent,UIScrollViewDelegate>
{
    NSMutableDictionary *dictStatus;
    NSString *strTag;
    NSUserDefaults *userDefaults;
    UIImagePickerController *imagePicker;
    int flagSearch;
}
@property(nonatomic, strong) UIView* mainView;
@property(nonatomic,strong) NSMutableArray *popArr;
@property(nonatomic,strong)IBOutlet UIImageView *leftdrawr;
@property(nonatomic) int flag;
@property(nonatomic,strong)IBOutlet UITableView *lefttableView,*righttableView,*cabinetTableview,*commTableView,*cbntTableView,*netTableView;
@property(nonatomic,strong) NSArray *profilear1;
-(void) initArs :(UIViewController *)Vc;
-(void) showRightDrawer;
-(void)openfriendprofile:(NSString *)strFriendID;
-(void )addProfileimage:(NSArray *) profileAr;
@end
