

#import "SelectCountry.h"
#import "SavePrefrences.h"

@interface SelectCountry ()

@end

@implementation SelectCountry

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) getCountryList:(UIViewController *) vc
{
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
   [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getAllCountIND" :@"":@"":dic1 :vc];
}

-(void) getState:(UIViewController*)cc:(NSString*)cid
{
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:cid forKey:@"conId"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getState" :@"":@"":dic1 :cc];
}


-(void) getCity:(UIViewController*)cc:(NSString*)sid;
{
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:sid forKey:@"conId"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Mobile" :@"getCity" :@"":@"":dic1 :cc];
}


@end
