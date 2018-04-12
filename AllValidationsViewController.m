

#import "AllValidationsViewController.h"


@interface AllValidationsViewController ()
{

}
@end

@implementation AllValidationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL) checkNullStr:(NSString *)txt
{
    NSLog(@"text is-----%@",txt);
    
    if(txt==nil||txt==NULL||[txt isEqual:[NSNull null]]||txt == (id)[NSNull null])
    {
  
        return false;
    }
    return true;
}



-(BOOL) checkNull:(UITextField *)txt
{
    if(txt.text.length<=0)
    {
        NSLog(@"inside");
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:txt.placeholder delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        
        
        return false;
    }
    return true;
}

-(BOOL) checkNulltextview:(UITextView *)txt
{
    if(txt.text.length<=0)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"All Fields Required" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        
        
        return false;
    }
    return true;
}

-(BOOL) checkCombo1:(UITextField *)txt1
{
    
    if(txt1.text.length<=0)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:txt1.text delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return false;
    }
    
    return true;
}


-(BOOL) checkCombo:(UILabel *)txt1
{
    if([txt1.text hasPrefix:@"Select"])
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:txt1.text delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return false;
    }
   
    return true;
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
   
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    stricterFilter= [emailTest evaluateWithObject:checkString];
    if(!stricterFilter)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Enter Valid Email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
    }
    
    
    return stricterFilter;
    
    
}

-(BOOL) NSStringIsValidfbEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    stricterFilter= [emailTest evaluateWithObject:checkString];
    if(!stricterFilter)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"PROYOLK" message:@"Enter Valid Facebook Email" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
    }
    
    
    return stricterFilter;
    
    
}

  
        
 
-(BOOL) validateStringContainsNumbersOnly:(NSString*)string
{
    
    NSString *validnumbers=@"0123456789.";
    
    NSCharacterSet * ValidDigits = [NSCharacterSet characterSetWithCharactersInString:validnumbers];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:string];
    
    BOOL stringIsValid = [ValidDigits isSupersetOfSet:characterSetFromTextField];
    if(!stringIsValid)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter only numbers" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return NO;//not correct return 0
    }
//    if([string intValue]<=0  || [string intValue]>=100)
//    {
//        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Percantage" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alrt show];
//        return NO;
//    }
        return  stringIsValid;
  
}




- (BOOL)validateAlphabetsonly:(NSString *)string
{
  
    NSString *validnumbers=@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz";
    
    NSCharacterSet * notDigits = [NSCharacterSet characterSetWithCharactersInString:validnumbers];
    if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Alphabets" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return NO;//not correct return 0
        
    }
    
    if([string length]>40)
    {
        
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter characters less than 40" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return NO;//not correct return 0
    }
        return  YES;
    

}
-(BOOL)checkDate:(NSString*)strtdate:(NSString*)Enddate
{
   
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy "];
    NSDate *sdate = [dateFormatter dateFromString:strtdate];
    NSDate *edate=[dateFormatter dateFromString:Enddate];
    NSString *cudate=[dateFormatter stringFromDate:date];
    long stms=[sdate timeIntervalSince1970]*1000;
    long edms=[edate timeIntervalSince1970]*1000;
    long crms=[date timeIntervalSince1970]*1000;
    NSLog(@"aj ki tareek %lu",crms);
  

    
    if(![Enddate isEqual:@"Present"])
    {
        NSLog(@"start date is %lu",stms);
        NSLog(@"End date is %lu",edms);
        
     if(stms>=edms || stms>=crms || edms>=crms)
    {

        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Date" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return nil;
        
        }
    }
    return YES;
    
}
-(BOOL)EventDateCompare:(NSString *)start:(NSString*)End
{
    if([start compare:End]!=NSOrderedAscending)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter Valid Start date to End date" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return nil;
    }
    
    return YES;
}
-(BOOL)checkColorSelection:(int)selectcol
{
    if(selectcol== 0)
    {
        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Select Color" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
        return NO;
    }else{
    return YES;
}
}

-(BOOL)ValidateContactNumber:(NSString*)str:(int)length
{
  
//    NSString *validnumbers=@"0123456789+";
//    
//    NSCharacterSet *valid=[NSCharacterSet characterSetWithCharactersInString:validnumbers];
//    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:str];
//    
//   BOOL stringIsValid = [valid isSupersetOfSet:characterSetFromTextField];
//    if(!stringIsValid)
//    {
//        UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Enter only number" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alrt show];
//        return NO;
//
//    }
    if([str length]>length)
   {
       
       UIAlertView * alrt=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"Incorrect Contact Number " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
       [alrt show];
       return NO;
   }
    

    
       return YES;
}





@end

