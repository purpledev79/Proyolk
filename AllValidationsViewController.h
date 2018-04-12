

#import <UIKit/UIKit.h>

@interface AllValidationsViewController : UIViewController


-(BOOL) checkNull:(UITextField *)txt;
-(BOOL) checkCombo:(UILabel *)txt1;
-(BOOL) NSStringIsValidEmail:(NSString*) emailString;
-(BOOL) validateStringContainsNumbersOnly:(NSString*)strng;
-(BOOL) checkNulltextview:(UITextView *)txt;
- (BOOL)validateAlphabetsonly:(NSString *)string;
-(BOOL)checkColorSelection:(int)col;
-(BOOL) checkNullStr:(NSString *)txt;
-(BOOL) checkCombo1:(UITextField *)txt1;
-(BOOL)checkDate:(NSString*)strtdate:(NSString*)Enddate;
-(BOOL)ValidateContactNumber:(NSString*)str:(int)length;
-(BOOL)EventDateCompare:(NSString *)start:(NSString*)End;
@end
