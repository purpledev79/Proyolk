
#import "ManageArray.h"
#import "SavePrefrences.h"

@interface ManageArray ()

@end

@implementation ManageArray

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)concatUrl :(NSString *)newurl
{
    
    if(newurl==nil||newurl==NULL||[newurl isEqual:[NSNull null]]||[newurl isEqual:@""]||newurl == (id)[NSNull null])
    {
        return @"noimg.png";
    }
    else
    {
        NSString * url = [SavePrefrences sharedInstance].skthand.btkurl;
        return [url stringByAppendingString:newurl];
    }
    
    return @"noimg.png";
}


-(BOOL) checkStringNull:(NSString *) str
{
    NSLog(@"value %@",str);
    if(str==nil||str==NULL||[str isEqual:[NSNull null]]||str == (id)[NSNull null])
     {
        return false;
     }
    return true;
    
    
}

-(NSArray *)sortDateAr:(NSArray *) dataAr:(UIViewController *)vc
{
    
    NSMutableArray * sortar=[[NSMutableArray alloc]init];
    
    NSArray * reData=[[NSArray alloc]init];
    
    for(int x=0;x<[dataAr count];x++)
    {
        NSString * timelog= [[dataAr objectAtIndex:x] valueForKey:@"timelog"];
        [sortar addObject:timelog];
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [sortar sortedArrayUsingDescriptors:descriptors];
    
    
    
    
    //
    //    for(int x=0;x<[reverseOrder count];x++)
    //    {
    //
    //        NSString * key=[reverseOrder objectAtIndex:x];
    //        for(int x1=0;x1<[dataAr count];x1++)
    //        {
    //
    //            [dataA]
    //
    //        }
    
    
    
    //        NSLog(@"key is=====%@",key);
    //  }
    
    
    NSLog(@"ret ar=====%@",reverseOrder);
    
    
    return reData;
    
}





-(NSArray *) convertojson:(NSObject *)data
{
    
    
   // NSLog(@"data=======%@",data);
    
    
    NSArray *jsonObject;
    
    if([[data valueForKey:@"message"] isKindOfClass:[NSString class]])
    {
        jsonObject = [NSJSONSerialization JSONObjectWithData:[[data valueForKey:@"message"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    }
    else
    {
        jsonObject=[data valueForKey:@"message"];
       
    }
    
    
   // NSLog(@"json object isss=======%@",jsonObject);
    
    
    return  jsonObject;
}


-(NSString *) timeConverter:(NSString *)ServerTime
{
 
  
    
    long time=[ServerTime longLongValue];
    //NSLog(@"Time In Millisecondes:==============%lu",time);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(time / 1000.0)];
    //NSLog(@"Time In Date:==============%@",date);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:[SavePrefrences sharedInstance].devicetimezone];
    [dateFormatter setTimeZone:timeZone];
    NSString *strTime = [dateFormatter stringFromDate:date];
  
    
    return strTime;
}

//-(long long)getConvertedTimemili
//{
//    
//    long long servermili=  [[SavePrefrences sharedInstance].serverTimeRece longLongValue];
//    
//    long long systemmili = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
//    
//    
//    //NSLog(@"Time In Millisecondeswww:==============%llu",servermili);
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(servermili / 1000.0)];
//    // NSLog(@"Time In Datew:==============%@",date);
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss a";
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:[SavePrefrences sharedInstance].devicetimezone];
//    [dateFormatter setTimeZone:timeZone];
//    NSString *strTime = [dateFormatter stringFromDate:date];
//  //  NSLog(@"strTimewwwww :%@",strTime);
//    
//    
//    
//    
//    NSDate *outerdate = [dateFormatter dateFromString:strTime];
//    
//    NSTimeInterval outermilisecounds = [outerdate timeIntervalSince1970];
//    
//    long long millidiff=systemmili-outermilisecounds;
//    
//    millidiff=servermili-millidiff;
//    //NSLog(@"final milisecouds====%lld",millidiff);
//    
//    
//    
//    
//    //2016-06-17 10:34:21 AM
//    
//    //    float hour=millidiff/1000*60*60*60;
//    //
//    //    NSLog(@"hours diff====%f",hour)
//    
//    
//    return millidiff;
//}



-(BOOL) checkContaine:(NSArray *)msg
{
    if([msg valueForKey:@"title"])
        //if([msg containsObject:@"title"])
    {
        return true;
    }
    else
    {
        return false;
    }
    
}


-(void) showMessageToUser
{
    
   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Proyolk" message:@"This feature Will be resolve in Next Update" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    UIImageView *imgMultiples1 =[[UIImageView
                                  alloc]initWithFrame:CGRectMake(0,0, alert.frame.size.width,
                                                                 alert.frame.size.height)]; imgMultiples1.image = [UIImage imageNamed:@"noimg.png"];
    [alert addSubview:imgMultiples1];
    [alert show];
    
    
    
}







@end
