

#import "AppDelegate.h"
#import "SavePrefrences.h"
//#import "ViewController.h"
#import "MainController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <linkedin-sdk/LISDK.h>
#import "Support.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <Google/SignIn.h>
#import "NotificationHandler.h"
#import "IncomingCallAlert.h"
#import "ChatStorageEngine.h"
#import "LandingViewController.h"
//#import "YOSSocial.h"
//#import "YahooSession.h"

#define IS_OS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.11)

@import UserNotifications;


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
//
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.11) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
        [center requestAuthorizationWithOptions:options
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!granted) {
                                      NSLog(@"Something went wrong");
                                  }
                              }];
    }else{
        NSLog(@"UINotifications for pre iOS 10");
    }
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self startNotification];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"/proyolk.com" forKey:@"nsp"];
    //NSString * url=@"http://10.0.0.51";
    NSString * url=@"https://Proyolk.com";
    [SavePrefrences sharedInstance].skthand=[[SocketHandler alloc] init ];
    [[SavePrefrences sharedInstance].skthand initconn:url :dic];
    
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject);
    
//NSString *str=@"string is`k;sa";
//    
//    str = [str stringByReplacingOccurrencesOfString:@ "`" withString: @"-"];
//    
    //    NSLog(@"str is====%@",str);
    
    
    //    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    //
    //    NSLog(@"time zone is====%@",destinationTimeZone);
    //    float timeZoneOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]] / 60;;
    //    NSLog(@"%f mins",timeZoneOffset/60);
    //    float gmt= timeZoneOffset/60;
    //
    //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss a";
    //        NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+5:30"];
    //        [dateFormatter setTimeZone:timeZone];
    //        NSString *strTime = [dateFormatter stringFromDate:date];
    //        NSLog(@"strTime :%@",strTime);
    //
    
    //2016-05-10 06:57:49 AM neyork
    //2016-05-10 04:27:49 PM
    
    
    //NSDate *tr = [NSDate dateWithTimeIntervalSince1970:1379598284];
    //NSDate *tr = [NSDate dateWithTimeIntervalSinceNow:1462877869597];
    //NSDate *date = [NSDate dateWithTimeIntervalSince1970:(1462877869597 / 1000.0)];
    
    
    
   
    
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    NSUInteger location = [[NSString stringWithFormat:@"%@",destinationTimeZone] rangeOfString:@"("].location;
    NSUInteger location2 = [[NSString stringWithFormat:@"%@",destinationTimeZone] rangeOfString:@")"].location;
    
    
    
     [SavePrefrences sharedInstance].devicetimezone =[[NSString stringWithFormat:@"%@",destinationTimeZone] substringWithRange:NSMakeRange(location+1, location2-(location+1))];
     NSLog(@"end shortString=======%@",[SavePrefrences sharedInstance].devicetimezone);
    
    
    NSDateFormatter *localTimeZoneFormatter = [NSDateFormatter new];
    localTimeZoneFormatter.timeZone = [NSTimeZone localTimeZone];
    localTimeZoneFormatter.dateFormat = @"Z";
    NSString *localTimeZoneOffset = [localTimeZoneFormatter stringFromDate:[NSDate date]];
    NSLog(@"time zone offset===%@",localTimeZoneOffset);
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"strTag"];

    
    [SavePrefrences sharedInstance].font=@"HelveticaNeue";
    
    
    NSMutableDictionary * colordic=[[NSMutableDictionary alloc]init];
    
    [colordic setValue: [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forKey:@"bodycolor"];//[UIColor colorWithRed:49.0f/255.0f green:60.0f/255.0f blue:74.0f/255.0f alpha:1.0f] forKey:@"bodycolor"];
    [colordic setObject:[UIColor colorWithRed:240.0f/255 green:199.0f/255 blue:3.0f/255 alpha:1.0] forKey:@"titleColor"];
    [colordic setObject:[UIColor colorWithRed:52.0f/255 green:127.0f/255 blue:103.0f/255 alpha:1.0f] forKey:@"Profcolor"];
    [colordic setObject:[UIColor colorWithRed:108.0f/255 green:114.0f/255 blue:41.0f/255 alpha:1.0f] forKey:@"Educolor"];
    [colordic setObject:[UIColor colorWithRed:94.0f/255 green:88.0f/255 blue:132.0f/255 alpha:1.0f] forKey:@"Emplcolor"];
    [colordic setObject:[UIColor colorWithRed:56.0f/255 green:106.0f/255 blue:145.0f/255 alpha:1.0f] forKey:@"Certcolor"];
    [colordic setObject:[ UIColor colorWithRed:143.0f/255 green:89.0f/255 blue:82.0f/255 alpha:1.0f] forKey:@"Awardscolor"];
    [colordic setObject:[UIColor colorWithRed:182/255.0f green:182/255.0f blue:182/255.0f alpha:1.0f] forKey:@"popupcolor"];
  
  //  [colordic setObject:[UIColor clearColor] forKey:@"popupcolor"];
    [colordic setObject:[UIColor clearColor] forKey:@"clearColor"];
    [colordic setObject:[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forKey:@"backcolor"];

    
    [colordic setObject:[UIColor colorWithRed:175.0f/255 green:175.0f/255 blue:175.0f/255 alpha:1.0f] forKey:@"Tabstextcolor"];
    [colordic setObject:[UIColor colorWithRed:54.0f/255 green:57.0f/255 blue:71.0f/255 alpha:1.0f] forKey:@"Headcolor"];
    [colordic setObject:[UIColor colorWithRed:132.0f/255.0f green:132.0f/255.0f blue:132.0f/255.0f alpha:.5f] forKey:@"Popupbackcolor"];
    [colordic setObject:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f] forKey:@"Scrollcolor"];
   
    [colordic setObject:[UIColor clearColor] forKey:@"Yellowbtncolor"];
  //  [colordic setObject:[UIColor colorWithRed:217.0f/255.0f green:179.0f/255.0f blue:27.0f/255.0f alpha:1.0f] forKey:@"Yellowbtncolor"];
    //[colordic setObject:[UIColor colorWithRed:121.0f/255.0f green:182.0f/255.0f blue:226.0f/255.0f alpha:1.0f] forKey:@"Videocolor"];
    [colordic setObject:[UIColor clearColor] forKey:@"Videocolor"];

    [colordic setObject:[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forKey:@"actionBar"];
   //[colordic setObject:[UIColor colorWithRed:49.0f/255.0f green:101.0f/255.0f blue:156.0f/255.0f alpha:1.0f] forKey:@"actionBar"];

    [colordic setObject:[UIColor colorWithRed:52.0f/255.0f green:127.0f/255.0f blue:103.0f/255.0f alpha:1.0f] forKey:@"Boardcolor"];
    [colordic setObject:[UIColor colorWithRed:196.0f/255.0f green:48.0f/255.0f blue:53.0f/255.0f alpha:1.0f] forKey:@"Declinecolor"];
    
    [colordic setObject:[UIColor colorWithRed:49.0f/255.0f green:60.0f/255.0f blue:74.0f/255.0f alpha:1.0f] forKey:@"leftdrawer"];
    [colordic setObject:[UIColor colorWithRed:121.0f/255.0f green:182.0f/255.0f blue:226.0f/255.0f alpha:1.0f] forKey:@"buttoncolor"];
      [colordic setObject:[UIColor colorWithRed:50.0f/255.0f green:98.0f/255.0f blue:133.0f/255.0f alpha:1.0f] forKey:@"rightDrawer"];
    
    [SavePrefrences sharedInstance].colorDictionry=colordic;
    
    [SavePrefrences sharedInstance].ntc1=@"";
    [SavePrefrences sharedInstance].ntc2=@"";
    [SavePrefrences sharedInstance].ntc3=@"";
    [SavePrefrences sharedInstance].ntc4=@"";
    [SavePrefrences sharedInstance].ntc5=@"";
    [SavePrefrences sharedInstance].ntc6=@"";
    [SavePrefrences sharedInstance].ntc7=@"";
    [SavePrefrences sharedInstance].ntc8=@"";
    [SavePrefrences sharedInstance].ntc8=@"";
    [SavePrefrences sharedInstance].ntc9=@" invited you to comment on his Board ";
    [SavePrefrences sharedInstance].ntc10=@" posted a new comment on your board ";
    [SavePrefrences sharedInstance].ntc11=@" accepted your Board Invitation ";
    [SavePrefrences sharedInstance].ntc12=@" denied your board invitation board ";
    [SavePrefrences sharedInstance].ntc13=@"  accepted your board joining request ";
    [SavePrefrences sharedInstance].ntc14=@" accepted your board joining request ";
    [SavePrefrences sharedInstance].ntc15=@" posted a new comment on your board ";
    [SavePrefrences sharedInstance].ntc16=@" sent a invitation to join the podcast ";
    [SavePrefrences sharedInstance].ntc17=@" request to join your podcast ";
    [SavePrefrences sharedInstance].ntc18=@" accepted your podcast ";
    [SavePrefrences sharedInstance].ntc19=@" denied your podcast ";
    [SavePrefrences sharedInstance].ntc20=@" accepted podcast application ";
    [SavePrefrences sharedInstance].ntc21=@" rejected podcast application ";
    [SavePrefrences sharedInstance].ntc22=@" postpone the podcast ";
    [SavePrefrences sharedInstance].ntc23=@"";
    [SavePrefrences sharedInstance].ntc24=@" shared his file ";
    [SavePrefrences sharedInstance].ntc25=@" sent you friend request";
    [SavePrefrences sharedInstance].ntc26=@" accepted friend request ";
    [SavePrefrences sharedInstance].ntc27=@" rejected friend request ";
    [SavePrefrences sharedInstance].ntc28=@"";
    [SavePrefrences sharedInstance].ntc29=@" applied for a  ";
    [SavePrefrences sharedInstance].ntc30=@" accepted a project ";
    [SavePrefrences sharedInstance].ntc31=@" updated profile picture ";
    [SavePrefrences sharedInstance].ntc32=@" updated profile picture ";
    [SavePrefrences sharedInstance].ntc33=@" shared calender with you. ";
    [SavePrefrences sharedInstance].ntc34=@" shared calender event with you..";
    [SavePrefrences sharedInstance].ntc35=@" accepted your calender invitation ";
    [SavePrefrences sharedInstance].ntc36=@" denied your calender invitation. ";
    [SavePrefrences sharedInstance].ntc37=@" accepted your calender event invitation ";
    [SavePrefrences sharedInstance].ntc38=@" denied your calender event invitation. ";
    [SavePrefrences sharedInstance].ntc1001=@" has sent you a message on your ticket. ";
    
    
    
    
    [SavePrefrences sharedInstance].isavilNet=@"no";
    [SavePrefrences sharedInstance].ischkykng=@"0";
    [SavePrefrences sharedInstance].ischkprofile=@"0";
    [SavePrefrences sharedInstance].ischkchat=@"0";
    [SavePrefrences sharedInstance].ischkcal=@"0";
    [SavePrefrences sharedInstance].ischkvideo=@"0";
    [SavePrefrences sharedInstance].ischkstor=@"0";
    [SavePrefrences sharedInstance].ischkboard=@"0";
    [SavePrefrences sharedInstance].ischkpodcast=@"0";
    [SavePrefrences sharedInstance].ischkjob=@"0";
    
    
    
    //    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    //    NSString *tzName = [timeZone name];
    
    //    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    //    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    //
    
    //NSLog(@"time zone====%@",utcTimeZone);
    //    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //
    //        NSLog(@"Reachability changed: %@", AFStringFromNetworkReachabilityStatus(status));
    //
    //
    //        switch (status) {
    //            case AFNetworkReachabilityStatusReachableViaWWAN:
    //            case AFNetworkReachabilityStatusReachableViaWiFi:
    //                // -- Reachable -- //
    //                NSLog(@"Reachable");
    //                break;
    //            case AFNetworkReachabilityStatusNotReachable:
    //            default:
    //                // -- Not reachable -- //
    //                NSLog(@"Not Reachable");
    //                break;
    //        }
    //
    //    }];
    UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _navigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"BASE_CONTAINER"];
    LandingViewController* landing = [mainStoryboard instantiateViewControllerWithIdentifier:@"LANDING_VIEW"];
    [_navigationController setViewControllers:@[landing] animated:NO];
    _incoming = [[IncomingCallAlert alloc] initWithNibName:@"IncomingCallAlert" bundle:nil];
    self.window.rootViewController = _navigationController;
    
//    Support *vc2 = [[Support alloc] initWithNibName:@"Support" bundle:nil];
//    navController.viewControllers = @[vc2];
  
    
    //    [self showNotification];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES]; // PREVENT DEVICE LOCK
    
    self.allFriends = [[NSArray alloc] init];
    self.conferenceMembers = [[NSMutableArray alloc] init];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
        if ([LISDKCallbackHandler
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        shouldHandleUrl:url])
        {
            return [LISDKCallbackHandler application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
        }
    else if ([[url absoluteString]containsString:@"799567353048"])
    {
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
    else{
      
        
     return [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }

}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication  annotation:(id)annotation
//{
////    return [[GIDSignIn sharedInstance] handleURL:url
////                               sourceApplication:sourceApplication
////                                      annotation:annotation];
//
//    
//    
//
////    if ([[url absoluteString] rangeOfString:@"799567353048-uais2r6cipfmfkt5dleaf7ggguevibtu"].location ==            NSNotFound)
////    {
////        return [[GIDSignIn sharedInstance] handleURL:url
////                                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
////                                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
////    }
////    
////    else if ([GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation]) {
////        return YES;
////    }
////    else if([FBAppCall handleOpenURL:url sourceApplication:sourceApplication]){
////        return YES;
////    }
////    
////    
////    else
////    {
////        return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
////    }
//    return YES;
//}
- (void)applicationWillResignActive:(UIApplication *)application{
    NSLog(@"Application REceive applicationWillResignActive");
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"Application REceive didReceiveLocalNotification");
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(nonnull UILocalNotification *)notification completionHandler:(nonnull void (^)())completionHandler{
    NSLog(@"Application REceive didReceiveLocalNotification %@", identifier);
    NSString *userId = notification.userInfo[@"uid"];
    if ([identifier isEqualToString:@"Accept"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"Application REceive didReceiveLocalNotification **** %@", identifier);
            NotificationHandler *notifh = [[NotificationHandler alloc] init];
            [notifh gotoVideoScreen:userId confArr:nil isAccepted:YES];
        });
    }else if ([identifier isEqualToString:@"Reject"]) {
        NSLog(@"Application REceive didReceiveLocalNotification **** %@", identifier);
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:userId forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"cc" :@"" :@"" :params :self ];
    }
    if (completionHandler) {
        completionHandler();
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    long unreadMsg = [[ChatStorageEngine sharedManager] getUnreadMessageCount:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber = unreadMsg;
    NSLog(@"inside applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    NSLog(@"Application in applicationWillEnterForeground");
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"/proyolk.com" forKey:@"nsp"];
    NSString * url=@"https://Proyolk.com";
    [[SavePrefrences sharedInstance].skthand initconn:url :dic];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
        NSLog(@"inside applicationDidBecomeActive");
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


-(void)startNotification
 {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        for (int i = 0; i< 100; i++) {
            [NSThread sleepForTimeInterval:5];
        }
    });
 }

//// Yahoo Integration Implmentations
//YOSSession *session = [YOSSession sessionWithConsumerKey:@"dj0yJmk9VFFJV0lNQVFabGJXJmQ9WVdrOWNUSlJaVVI2TjJVbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD01OQ--"
//    andConsumerSecret:@"992d4fa08598e980c3c5b412867f6a770393c4c6"
//    andApplicationId:@"com.pi.Proyolk"];
//
//
//// try to resume a user session if one exists
//BOOL hasSession = [session resumeSession];
//
//if(hasSession == FALSE) {
//    [session sendUserToAuthorizationWithCallback:nil];
//}else{
//    [self sendRequests];
//}
@end



