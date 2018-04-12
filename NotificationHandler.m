

#import "NotificationHandler.h"
#import "SavePrefrences.h"
#import "openChat.h"
#import "ManageArray.h"
#import <AVFoundation/AVFoundation.h>
#import "LeftRightDrawer.h"
#import "AppDelegate.h"
#import "IncomingCallAlert.h"
#import "ChatStorageEngine.h"

@implementation NotificationHandler
{
    
    ManageArray *mang;
    
    
}
-(void)isTyping:(NSArray*)Notidic
{
    
  if([[SavePrefrences sharedInstance].chatWindowAr count]>=1)
    {
        NSMutableArray * d=[SavePrefrences sharedInstance].chatWindowAr;
        openChat * de=[d objectAtIndex:0];
        [de isTyping:Notidic];
    }
    
}


- (void)initiateVideoCall:(NSString*)userId{
    NSDictionary* contact = [self contactFromId:userId];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([contact[@"isonline"] intValue]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:@"strTag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        appDelegate.videoController = [mainStoryboard instantiateViewControllerWithIdentifier:@"VideoChatController"];
        appDelegate.videoController.outgoingCall = [NSString stringWithFormat:@"%@", userId];
        [appDelegate.navigationController setViewControllers:@[appDelegate.videoController] animated:NO];
    }else{
        NSString* message = [NSString stringWithFormat:@"%@ %@ is not online, please try later.", contact[@"fname"], contact[@"lname"]];
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Proyolk"  message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [appDelegate.navigationController dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [appDelegate.navigationController presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (void)gotoVideoScreen:(NSString*)userId confArr:(NSArray*)confArr isAccepted:(BOOL)isAccepted{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (isAccepted) {
        [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:@"strTag"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        appDelegate.videoController = [mainStoryboard instantiateViewControllerWithIdentifier:@"VideoChatController"];
        if(isAccepted) appDelegate.videoController.acceptedCall = [NSString stringWithFormat:@"%@", userId];
        else appDelegate.videoController.incomingCall = [NSString stringWithFormat:@"%@", userId];
        [appDelegate.navigationController setViewControllers:@[appDelegate.videoController] animated:NO];
    }else{
        appDelegate.incoming.userId = userId;
        appDelegate.incoming.isShowing = YES;
        appDelegate.incoming.contact = [self contactFromId:userId];
        appDelegate.incoming.confArr = confArr;
        [appDelegate.incoming.view setFrame:[[UIScreen mainScreen] bounds]];
        appDelegate.incoming.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [[UIApplication sharedApplication].keyWindow addSubview:appDelegate.incoming.view];
        UIViewController* top = [[appDelegate.navigationController viewControllers] lastObject];
        [top presentViewController:appDelegate.incoming animated:NO completion:nil];
    }
}

- (NSDictionary*)contactFromId:(NSString*)userId{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (NSDictionary* dict in appDelegate.allFriends) {
        if ([[NSString stringWithFormat:@"%@", dict[@"u_id"]] isEqualToString:userId]) {
            return dict;
        }
    }
    return nil;
}

- (void)showCallNotificationBackground:(NSString*)userId{
    UIMutableUserNotificationAction *notificationAction1 = [[UIMutableUserNotificationAction alloc] init];
    notificationAction1.identifier = @"Accept";
    notificationAction1.title = @"Accept";
    notificationAction1.activationMode = UIUserNotificationActivationModeForeground;
    notificationAction1.destructive = NO;
    notificationAction1.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *notificationAction2 = [[UIMutableUserNotificationAction alloc] init];
    notificationAction2.identifier = @"Reject";
    notificationAction2.title = @"Reject";
    notificationAction2.activationMode = UIUserNotificationActivationModeBackground;
    notificationAction2.destructive = YES;
    notificationAction2.authenticationRequired = YES;
    
    UIMutableUserNotificationCategory *notificationCategory = [[UIMutableUserNotificationCategory alloc] init];
    notificationCategory.identifier = @"Incoming Call";
    [notificationCategory setActions:@[notificationAction1,notificationAction2] forContext:UIUserNotificationActionContextDefault];
    [notificationCategory setActions:@[notificationAction1,notificationAction2] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:notificationCategory, nil];
    
    UIUserNotificationType notificationType = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:notificationType categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
    NSDictionary* contact = [self contactFromId:userId];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    localNotification.alertBody = [NSString stringWithFormat:@"Incoming call from %@ %@", contact[@"fname"], contact[@"lname"]];
    localNotification.category = @"Incoming Call"; //  Same as category identifier
    localNotification.userInfo = @{@"uid":userId};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)handleVideoCallWithMeta:(NSDictionary*)meta data:(NSDictionary*)data{
    NSLog(@"**** NOTIFICATION **** CALLBACK **** NTC => %@", data[@"ntc"]);
    
    int code = [[NSNumber numberWithLong:[data[@"ntc"] longValue]] intValue];
    switch (code) {
            
        // INSTANT MESSAGING
            
        case 3:{ // INCOMING MESSAGE
            NSLog(@"**** NOTIFICATION **** CALLBACK **** 3 => %@", data);
            NSMutableDictionary* chData = data.mutableCopy;
            if ([data[@"message"] isKindOfClass:[NSString class]]) {
                NSDictionary *msgObject = [NSJSONSerialization JSONObjectWithData:[data[@"message"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
                [chData setValue:msgObject forKey:@"message"];
            }
            if (chData[@"message"][@"mT"]) {
                if ([chData[@"message"][@"mT"] isEqualToString:@"group"]) {
                    [[ChatStorageEngine sharedManager] saveGroupMessage:chData isIncoming:YES];
                }
            }else [[ChatStorageEngine sharedManager] saveMessage:chData isIncoming:YES];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if (![appDelegate.currentChatUser isEqualToString:[NSString stringWithFormat:@"%@", chData[@"uid"]]]){
                NSDictionary* msgDict = @{
                                          @"message":chData[@"message"],
                                          @"notiIds":chData[@"noti_id"],
                                          @"uid" : [SavePrefrences sharedInstance].uid,
                                          @"fruid":chData[@"uid"]
                                          };
                [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"md" :@"" :@"d" :msgDict :self];
            }
            
            break;
        }
        case 4:{ // MESSAGE DELIVERED
            NSLog(@"**** NOTIFICATION **** CALLBACK **** 4 => %@", data);
            NSMutableDictionary* chData = data.mutableCopy;
            if ([data[@"message"] isKindOfClass:[NSString class]]) {
                NSDictionary *msgObject = [NSJSONSerialization JSONObjectWithData:[data[@"message"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
                [chData setValue:msgObject forKey:@"message"];
            }
            
            if (!chData[@"message"][@"mT"]) {
                [[ChatStorageEngine sharedManager] saveMessageStatus:chData[@"message"][@"messId"] isSeen:NO isIncoming:YES];
            }
            break;
        }
        case 5:{ // MESSAGE SEEN
            NSLog(@"**** NOTIFICATION **** CALLBACK **** 5 => %@", data);
            NSMutableDictionary* chData = data.mutableCopy;
            if ([data[@"message"] isKindOfClass:[NSString class]]) {
                NSDictionary *msgObject = [NSJSONSerialization JSONObjectWithData:[data[@"message"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
                [chData setValue:msgObject forKey:@"message"];
            }

            if (!chData[@"message"][@"mT"]) {
                [[ChatStorageEngine sharedManager] saveMessageStatus:chData[@"message"][@"messId"] isSeen:YES isIncoming:YES];
            }
            break;
        }
        case 6:{ // TYPING STATUS
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHAT_TYPING_STATUS" object:nil userInfo:data];
            NSLog(@"**** NOTIFICATION **** CALLBACK **** 6 => %@", data);
            break;
        }
            
        // BOARD
            
        case 9:{ // BOARD REQUEST
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BOARD_REQUEST" object:nil userInfo:data];
            break;
        }
            
        // YOLKING
            
        case 25:{
            NSString* notiCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"YOLKING_COUNT"];
            int unreadMsg = notiCount.intValue;
            unreadMsg = unreadMsg+1;
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", unreadMsg] forKey:@"YOLKING_COUNT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        }
            
        // VIDEO CALL NOTIFICATIONS
            
        case 50:{
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"strTag"] isEqualToString:@"4"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CALL_INCOMING" object:nil userInfo:data];
            }else{
                //            LeftRightDrawer* drawer = [[LeftRightDrawer alloc]init];
                if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
                    [self gotoVideoScreen:[NSString stringWithFormat:@"%@", data[@"uid"]] confArr:nil isAccepted:NO];
                }else if([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground){
                    NSLog(@"I AM IN BACKGROUND **** INCOMING **** CALL **** FROM ** %@", data[@"uid"]);
                    [self showCallNotificationBackground:[NSString stringWithFormat:@"%@", data[@"uid"]]];
                }else if([[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive){
                    NSLog(@"I AM INACTIVE **** INCOMING **** CALL **** FROM ** %@", data[@"uid"]);
                }
            }
            break;
        }
        case 51:{
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if (appDelegate.incoming.isShowing) {
                [appDelegate.incoming dismissViewControllerAnimated:NO completion:^{
                    appDelegate.incoming.isShowing = NO;
                }];
            }else
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CALL_REJECTED" object:nil userInfo:data];
            break;
        }
        case 52:{
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if (appDelegate.incoming.isShowing) {
                [appDelegate.incoming dismissViewControllerAnimated:NO completion:^{
                    appDelegate.incoming.isShowing = NO;
                }];
            }else
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CALL_REJECTED" object:nil userInfo:data];
            break;
        }
        case 53:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CALL_ACCEPTED" object:nil userInfo:data];
            break;
        }
        case 54:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ACCEPT_CANDIDATE" object:nil userInfo:data];
            break;
        }
        case 55:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"INITIAL_OFFER" object:nil userInfo:data];
            break;
        }
        case 56:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ACCEPT_ANSWER" object:nil userInfo:data];
            break;
        }
        case 57:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CALL_DISCONNECTED" object:nil userInfo:data];
            break;
        }
        case 58:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ACCEPT_OFFER" object:nil userInfo:data];
            break;
        }
        
        // SCREEN SHARING NOTIFICATIONS
            
        case 161:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_CALL_INCOMING" object:nil userInfo:data];
            break;
        }
        case 162:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_CALL_ACCEPTED" object:nil userInfo:data];
            break;
        }
        case 163:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_CALL_REJECTED" object:nil userInfo:data];
            break;
        }
        case 164:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_ICE_CANDIDATE_INCOMING" object:nil userInfo:data];
            break;
        }
        case 165:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_OFFER_RECEIVED" object:nil userInfo:data];
            break;
        }
        case 166:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_SDP_RECEIVED" object:nil userInfo:data];
            break;
        }
        case 169:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_ANSWER_RECEIVED" object:nil userInfo:data];
            break;
        }
        case 170:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SS_CALL_END" object:nil userInfo:data];
            break;
        }
            
        // CONFERENCE CALL NOTIFICATION
            
        case 201:{
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"strTag"] isEqualToString:@"4"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CC_CALL_INCOMING" object:nil userInfo:data];
            }else{
                //            LeftRightDrawer* drawer = [[LeftRightDrawer alloc]init];
                if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
                    [self gotoVideoScreen:[NSString stringWithFormat:@"%@", data[@"uid"]] confArr:data[@"fruids"] isAccepted:NO];
                }else if([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground){
                    NSLog(@"I AM IN BACKGROUND **** INCOMING **** CALL **** FROM ** %@", data[@"uid"]);
                    [self showCallNotificationBackground:[NSString stringWithFormat:@"%@", data[@"uid"]]];
                }else if([[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive){
                    NSLog(@"I AM INACTIVE **** INCOMING **** CALL **** FROM ** %@", data[@"uid"]);
                }
            }
            break;
        }
        case 202:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CC_CALL_REMOTE_RESPONSE" object:nil userInfo:data];
            break;
        }
        case 203:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CC_CALL_ADD_CONN" object:nil userInfo:data];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)handleChatMessage:(NSArray*)message{
//    NSLog(@"INSTANT MESSENGER ****** %@", message);
}

-(void)ManageNotification:(NSArray *)Notidic
   {
    for(int x=0;x<[Notidic count];x++)
    {
        int notifrm=[[[Notidic valueForKey:@"ntc"]objectAtIndex:x] intValue];
        NSString *uid=[[Notidic objectAtIndex: x] valueForKey:@"uid"];
        
        
        
        
        
        if(notifrm==1)
        {
            // user online
      //      NSLog(@"User online");
            if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"1"])
            {
                NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                [myBoardAr addObject:[Notidic objectAtIndex:x]];
                [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"1"];
            }
            else
            {
               // NSLog(@"here value is === %@",[Notidic objectAtIndex:x]);
                [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"1"]] addObject:[Notidic objectAtIndex:x]] ;
            }
        }
        
        else if(notifrm==2)
        {
            // user offline
            NSLog(@"User offline");
            if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"2"])
            {
                NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                [myBoardAr addObject:[Notidic objectAtIndex:x]];
                //NSLog(@"ntc 9======== %@",myBoardAr);
                [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"2"];
            }
            else
            {
                //NSLog(@"here value is === %@",[Notidic objectAtIndex:x]);
                [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"2"]] addObject:[Notidic objectAtIndex:x]] ;
            }
        }
        
        else if(notifrm==3)
        {
            return;
            //[self showLocalNotification];
            //online handling
            NSString *userid=[[Notidic objectAtIndex:x]valueForKey:@"uid"];
            NSString *fruid=[[Notidic objectAtIndex:x]valueForKey:@"fruid"];
            
//            [[SavePrefrences sharedInstance].allFrndChatKey setValue:fruid forKey:fruid];
//            [[SavePrefrences sharedInstance].allFrndChatKey setValue:@"hhh" forKey:userid];
            
            if(![[[SavePrefrences sharedInstance].notificationDic allKeys] containsObject:[NSString stringWithFormat:@"%@",userid]])
               {
                 NSMutableArray * mymsgAr=[[NSMutableArray alloc]init];
                [mymsgAr addObject:[Notidic objectAtIndex:x]];
                 NSLog(@"valueee======== %@",mymsgAr);
                [[SavePrefrences sharedInstance].notificationDic setValue:mymsgAr forKey:[NSString stringWithFormat:@"%@",userid]];
               }
            else
               {
                NSLog(@"here value is === %@",[Notidic objectAtIndex:x]);
                [(NSMutableArray *) [[SavePrefrences sharedInstance].notificationDic valueForKey:[NSString stringWithFormat:@"%@",userid]] addObject:[Notidic objectAtIndex:x]] ;
               }
            if([[SavePrefrences sharedInstance].chatWindowAr count]>=1)
             {
                NSMutableArray * d=[SavePrefrences sharedInstance].chatWindowAr;
                openChat * de=[d objectAtIndex:0];
                [de openchat:nil withImage:nil];
             }
            
            //NSLog(@"dictionary is ========%@",[SavePrefrences sharedInstance].notificationDic);
            
            
        }
        
        else if(notifrm==4)
        {
            // Message delivered
            NSLog(@"Message delievered");
        }
        else if(notifrm==5)
        {
            NSLog(@"Message seen");
        }
        else if(notifrm==6)
        {
            NSLog(@"Message typing");
            if([[SavePrefrences sharedInstance].chatWindowAr count]>=1)
            {
                NSMutableArray * d=[SavePrefrences sharedInstance].chatWindowAr;
                openChat * de=[d objectAtIndex:0];
                [de openchat:nil withImage:nil];
                
            }
            
        }
        
        
        if([[SavePrefrences sharedInstance].uid intValue] !=[uid intValue])
        {
            [[SavePrefrences sharedInstance].notiYolkingAr addObject:[Notidic objectAtIndex:x]];
            
          //  NSLog(@"notifrom=== %@",[Notidic objectAtIndex:x]);
           // NSLog(@"userid=== %@",uid);
            switch (notifrm)
            {
                    
                    //board statrt=================
                case 9:
                {
                    if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"9"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"9"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"9"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:9];
                    
                }
                    break;
                    
                case 10:
                {
                    // Board Application
                    if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"9"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"9"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"9"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification:[Notidic objectAtIndex:x]:10];
                    
                    break;
                }
                    
                case 11:
                    // Board Invitation accepted
                {
                    if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"9"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"9"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"9"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:11];
                }
                    break;
                    
                    
                case 12:
                    // Board Invitation rejected
                {
                    if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"9"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"9"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"9"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification:[Notidic objectAtIndex:x]:12];
                }
                    break;
                    
                case 13:
                    NSLog(@"Board Application accepted");
                    if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"9"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"9"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"9"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification:[Notidic objectAtIndex:x]:13];
                    
                    break;
                    
                case 14:
                    NSLog(@"Board Application Rejected");
                    if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"9"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"9"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"9"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification:[Notidic objectAtIndex:x]:14];
                    break;
                    
                case 15:
                    // New Comment Posted
                    if(![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"9"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"9"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"9"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification:[Notidic objectAtIndex:x]:15];
                    break;
                    
                    
                    
                    //===================================board end==========
                    
                    
                    
                    
                case 16:
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"16"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"16"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"16"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                }
                    [self showNotification :[Notidic objectAtIndex:x]:16];
                    break;
                    // offline pod notification
                    
                    
                case 17:
                    //Podcast Application
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"16"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"16"];
                        
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"16"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                }
                    [self showNotification :[Notidic objectAtIndex:x]:17];
                    break;
                    
                    
                case 18:
                    //Podcast Invitation accepted
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"16"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"16"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"16"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification :[Notidic objectAtIndex:x]:18];
                }
                    break;
                    
                case 19:
                {
                    //Podcast Invitation Rejected
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"16"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"16"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"16"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification :[Notidic objectAtIndex:x]:19];
                }
                    break;
                    
                case 20:
                    //Podcast Application accepted
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"16"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"16"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"16"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification :[Notidic objectAtIndex:x]:20];
                }
                    break;
                    
                case 21:
                {
                    //Podcast Application rejected
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"16"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"16"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"16"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification :[Notidic objectAtIndex:x]:21];
                }
                    break;
                    
                case 22:
                    //Podcast Postponed
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"16"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"16"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"16"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification :[Notidic objectAtIndex:x]:22];
                }
                    break;
                    
                    
                    
                    //podcast end==============================================================
                    
                case 24:
                    // offlineStoreageNoti(i, arNotis);
                    // refreshStorage(notiType);
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"24"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"24"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"24"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification :[Notidic objectAtIndex:x]:24];
                    
                }
                    
                    break;
                    
                case 25:
                    // offlineFriendRequest(i, arNotis);
                    // refreshYolking(notiType);
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"25"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"25"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"25"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification:[Notidic objectAtIndex:x]:25];
                    
                    
                    
                    break;
                case 26:
                    //Friend Request Accepted
                    
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"26"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"26"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"26"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:26];
                    break;
                    
                case 27:
                    //Friend Request Rejected
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"27"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"27"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"27"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:27];
                    
                    
                    break;
                    
                case 28:
                    //Jobs
                    break;
                    
                case 29:
                    //Applied For Job
                {
                    NSLog(@"inside 29==");
                    
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"29"])
                    {
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"29"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"29"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification :[Notidic objectAtIndex:x]:29];
                    
                }
                    
                    break;
                    
                case 30:
                    // jobs invitation accepted
                    {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"29"])
                      {
                        NSLog(@"inside 30   %@",[SavePrefrences sharedInstance].allNotifictionDic);
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"29"];
                        
                         NSLog(@"inside 31 afe   %@",[SavePrefrences sharedInstance].allNotifictionDic);
                        
                      }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"29"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    [self showNotification:[Notidic objectAtIndex:x]:30];
                    
                }
                    break;
                    
                case 31:
                    //profile pic updated
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"31"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"31"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"31"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:31];
                    
                    break;
                    
                case 33:
                    //Calender Invitaion
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"33"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"33"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"33"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:33];
                    
                    break;
                    
                    
                case 34:  //Calender Event Invitaion
                {
                    
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"33"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"33"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"33"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:34];
                    
                    
                    break;
                }
                case 35: // CalenderInvitation accepted
                {
                    
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"33"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"33"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"33"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:35];
                    
                    
                    break;
                }
                case 36:// calender Invitation Rejected
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"33"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"33"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"33"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:36];
                    
                    break;
                }
                case 37: // Calender EventInvitation accepted
                {
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"33"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"33"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"33"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:37];
                    
                    
                    break;
                }
                case 38: // Calender Event Invitation Rejected
                {
                    
                    if (![[[SavePrefrences sharedInstance].allNotifictionDic allKeys] containsObject:@"33"])
                    {
                        
                        NSMutableArray * myBoardAr=[[NSMutableArray alloc]init];
                        [myBoardAr addObject:[Notidic objectAtIndex:x]];
                        [[SavePrefrences sharedInstance].allNotifictionDic setValue:myBoardAr forKey:@"33"];
                    }
                    else
                    {
                        [(NSMutableArray *) [[SavePrefrences sharedInstance].allNotifictionDic valueForKey:[NSString stringWithFormat:@"%@",@"33"]] addObject:[Notidic objectAtIndex:x]] ;
                    }
                    
                    [self showNotification:[Notidic objectAtIndex:x]:38];
                    
                    
                    break;
                }
                    
                    
                default:
                    break;
            }
         }
      }
    NSLog(@"all frnd key===%@",[SavePrefrences sharedInstance].allFrndChatKey);
    NSLog(@"all frnd keyvalu===%@",[[SavePrefrences sharedInstance].allFrndChatKey valueForKey:@"404"]);
}


-(void)showNotification:(NSMutableDictionary *)NotiAr:(int)case1
{
    
    NSLog(@"inside notification ");
    
    if(mang==nil)
        mang=[[ManageArray alloc]init];
    
    
    
    if([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
    NSDate *alarmtime=[[NSDate date] dateByAddingTimeInterval:5.0];
    UIApplication *app=[UIApplication sharedApplication];
    UILocalNotification *notfyalarm=[[UILocalNotification alloc]init];
    NSString *tit;
    
    
    //board Start==========================>
    NSString *uname=[NotiAr valueForKey:@"uname"];
    NSString *fruid=[NotiAr valueForKey:@"fruid"];
    NSString *img=[NotiAr valueForKey:@"img"];
    NSString *uid=[NotiAr valueForKey:@"uid"];
    
    if(case1==9||case1==10||case1==11||case1==12||case1==13||case1==14)
    {
        if(case1==9)
        {
            NSArray * jsonObject=[mang convertojson:NotiAr];
            if([mang checkContaine:jsonObject])
            {
                NSString *brdID=[jsonObject valueForKey:@"brdID"];
                NSString  *title1=[jsonObject valueForKey:@"title"];
                tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc9] stringByAppendingString:title1];
            }
            else
            {
                NSString *brdID=[jsonObject valueForKey:@"brdID"];
                tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc9];
            }
        }
        else if(case1==10)
        {
            tit= [uname stringByAppendingString:[SavePrefrences sharedInstance].ntc10 ];
        }
        else if(case1==11)
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc11 ];
        }
        else if(case1==12)
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc12 ];
        }
        else if(case1==13)
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc13];
            
        }
        else if(case1==14)
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc14];
        }
        else if(case1==15)
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc15];
        }
    }
    
    //board End==================================>
    
    else if(case1==16||case1==17||case1==18||case1==19||case1==20||case1==21||case1==22)//podcast
    {
        if(case1==16)//podcast  invite
        {
            
            NSArray * jsonObject=[mang convertojson:NotiAr];
            
            if([mang checkContaine:jsonObject])
            {
                NSString *brdID=[jsonObject valueForKey:@"podId"];
                NSString  *title1=[jsonObject valueForKey:@"title"];
                tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc16] stringByAppendingString:title1];
            }
            else{
                NSString *brdID=[jsonObject valueForKey:@"podId"];
                tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc16];
            }
            
            
        }
        if(case1==17)//podcastrquest to join
        {
            
            NSLog(@"inside    17");
            NSArray * jsonObject=[mang convertojson:NotiAr];
            
            if([mang checkContaine:jsonObject])
            {
                NSString *brdID=[jsonObject valueForKey:@"podId"];
                NSString*title1=[jsonObject valueForKey:@"title"];
                tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc17] stringByAppendingString:title1];
            }
            else
            {
                NSString *brdID=[jsonObject valueForKey:@"podId"];
                tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc17];
            }
        }
        else if(case1==18)//podcast denied
        {
            NSString *message=[NotiAr  valueForKey:@"message"];
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc18];
        }
        
        else if(case1==19)//podcast denied
        {
            NSArray * jsonObject=[mang convertojson:NotiAr];
            NSString  *title1=[jsonObject valueForKey:@"title"];
            tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc19] stringByAppendingString:title1];
        }
    }
    
    else if(case1==24)//file Sharing
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc24];
    }
    else if(case1==25)//frndreq
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc25];
    }
    else if(case1==26)//accept
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc26];
    }
    else if(case1==27)//reject
    {
        
    }
    else if(case1==28)//accepted friend request
    {
        
    }
    else if(case1==29)//reject job
    {
        
        NSArray * jsonObject=[mang convertojson:NotiAr];
        NSString  *title1=[jsonObject valueForKey:@"title"];
        if([mang checkContaine:jsonObject])
        {
            tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc29] stringByAppendingString:title1];
        }
        else
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc29];
        }
    }
    else if(case1==30)//accept job
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc30];
    }
    
    else if(case1==31)//profile pic update
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc31];
    }
    
    else if(case1==33)//calendar share
    {
        NSArray * jsonObject=[mang convertojson:NotiAr];
        
        if([mang checkContaine:jsonObject])
        {
            NSString  *title1=[jsonObject valueForKey:@"title"];
            tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc33] stringByAppendingString:title1];
        }
        else
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc33];
        }
    }
    else if(case1==34)//calendar event share
    {
        NSArray * jsonObject=[mang convertojson:NotiAr];
        
        if([mang checkContaine:jsonObject])
        {
            NSString  *title1=[jsonObject valueForKey:@"title"];
            tit=[[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc34] stringByAppendingString:title1];
        }
        else
        {
            tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc34];
            
        }
    }
    else if(case1==35)  // CalenderInvitation accepted
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc35];
    }
    else if(case1==36)// calender Invitation Rejected
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc36];
    }
    else if(case1==37) // Calender EventInvitation accepted
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc37];
    }
    else if(case1==38)  // Calender Event Invitation Rejected
    {
        tit=[uname stringByAppendingString:[SavePrefrences sharedInstance].ntc38];
    }
    
    if(notfyalarm)
     {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        NSString *soundFilePath = [NSString stringWithFormat:@"%@/test.mp4",[[NSBundle mainBundle] resourcePath]];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                       error:nil];
        player.numberOfLoops = -1; //Infinite
        
        [player play];
        
        notfyalarm.fireDate=alarmtime;
        notfyalarm.timeZone=[NSTimeZone defaultTimeZone];
        notfyalarm.repeatInterval=0;
        notfyalarm.soundName=@"notitune.mp3";
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        NSString * notimsg=tit;
        notfyalarm.alertBody=notimsg;
        [app scheduleLocalNotification:notfyalarm];
        
    }
}

@end
