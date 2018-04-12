
#import <UIKit/UIKit.h>
 #import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "UITextView+Placeholder.h"
#import "UIImageView+WebCache.h"
#define SAFESTRING(str) ISVALIDSTRING(str) ? str : @""
#define ISVALIDSTRING(str) (str != nil && [str isKindOfClass:[NSNull class]] == NO)
#define VALIDSTRING_PREDICATE [NSPredicate predicateWithBlock:^(id evaluatedObject, NSDictionary *bindings){return (BOOL)ISVALIDSTRING(evaluatedObject);}]
@interface AllPopUp : UIViewController<PjsCallBack,CallTo_Parent,UITextFieldDelegate,UITextViewDelegate>
{
    UILabel *AddressLabel;
    UILabel *descriptionLabel;
    UITextField *sworking,*eWorking;
}

-(UIView *) editProfile:(UIViewController *)Vc:(NSArray *) employementAr:(int) selId;
-(UIView *) addProfile:(UIViewController *)Vc;
-(void) AddCertificateDetails:(UIViewController *)Vc;
-(void) EditCertificateDetails:(UIViewController *)Vc:(int) cidw:(NSArray *) certAr;
-(void) EditAward:(UIViewController *)Vc:(NSArray *) awdar:(int) idd;
-(void) AddAward:(UIViewController *)Vc;
-(void)editMainProfile:(UIViewController *)Uv:(NSArray *) profAr:(NSArray *)indus;
@property(nonatomic,strong) UILabel *country,*sate,*year,*city;
@property(nonatomic,strong) UIView  *prMainView,*datePickerView ;
@property(nonatomic,strong) UITextView *add,*desc;
@property(nonatomic,strong) NSArray *countryAr;
@property(nonatomic,strong) UITextField *eworking,*sworking;
-(void)showFullDetail:(NSString *)title1:(NSString *)add:(NSString *)award_desc:(NSString *)award_when:(NSString *)name_of_comp:(NSString *)presented_by:(NSString *)Img:(UIViewController * )vc;

@end
