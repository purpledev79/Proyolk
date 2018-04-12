#import "SocketHandler.h"
#import "SavePrefrences.h"
#import "myprojectNew-Swift.h"
#import "PjsCallBack.h"
#import "AlertView.h"
#import "NotificationHandler.h"

@implementation SocketHandler
{
    NotificationHandler *nobj;
    NSTimer *_timer;
    int tcounter;
    AlertView *av;
}

@synthesize resp,socket,isconnected,btkurl;

int isConnect=0;

-(int)initconn :(NSString*)host: (NSMutableDictionary *) chnl{
    av=[[AlertView alloc]init];
    @try
    {
        btkurl= @"https://Proyolk.com/";
        //btkurl= @"http://10.0.0.51/";
        
        NSURL* url = [[NSURL alloc] initWithString:host];
        socket = [[SocketIOClient alloc] initWithSocketURL:url options:chnl];
        
        [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack)
         {
             NSLog(@"socket Connected in socket handler");
             isConnect=0;
             NSMutableDictionary *meta =[[NSMutableDictionary alloc]init];
             NSMutableDictionary *datae =[[NSMutableDictionary alloc]init];
             
             NSLog(@"save pref value===%@",[SavePrefrences sharedInstance].un);
             NSArray *ar;
             if([SavePrefrences sharedInstance].un.length>0)
             {
                 [meta setValue:[SavePrefrences sharedInstance].sid forKey:@"sid"];
                 [meta setValue:[SavePrefrences sharedInstance].at  forKey:@"at"];
                 [meta setValue:@"" forKey:@"rl"];
                 [meta setValue:[SavePrefrences sharedInstance].uid  forKey:@"uid"];
                 [meta setValue:@"Android" forKey:@"device"];
                 [meta setValue:@"proyolk.com" forKey:@"domain"];
                 NSLog(@"inside iff connected    %@",meta);
                 
             }
             else
             {
                 [meta setValue:@"" forKey:@"sid"];
                 [meta setValue:@"" forKey:@"at"];
                 [meta setValue:@"" forKey:@"rl"];
                 [meta setValue:@"" forKey:@"uid"];
                 ///[meta setValue:@"initCon" forKey:@"device"];
                 [meta setValue:@"Android" forKey:@"device"];
                 [meta setValue:@"proyolk.com" forKey:@"domain"];
                 
             }
             ar = [[NSArray alloc]initWithObjects:meta,datae,nil];
             NSLog(@"before to connect");
             [socket emit:@"initCon" withItems:ar];
             NSLog(@"After to connect");
             [SavePrefrences sharedInstance].isavilNet=@"yes";
             
         }];
        
        [socket on:@"init" callback:^(NSArray* data, SocketAckEmitter* ack)
         {
             NSLog(@"socket connected=========");
             [SavePrefrences sharedInstance].isavilNet=@"yes";
             [self dissmiss1];
             isconnected=@"OK";
             isConnect=1;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"SOCKET_CONNECTED" object:nil];
         }];
        
        [socket on:@"r" callback:^(NSArray* data, SocketAckEmitter* ack)
         {
             
             NSArray * META=[data objectAtIndex:0];
             NSArray * DATA=[data objectAtIndex:1];
             NSString * respkey =[META valueForKey:@"pjsresp"];
             id<PjsCallBack>  cb= [resp valueForKey:respkey];
             
//             NSLog(@"callback meta object %@",META );
//             NSLog(@"call back data object %@",DATA);
             
             if ([DATA isKindOfClass:[NSDictionary class]]) {
                 nobj=[[NotificationHandler alloc]init];
                 [nobj handleVideoCallWithMeta:[data objectAtIndex:0] data:[data objectAtIndex:1]];
             }
             
             if([[DATA valueForKey:@"e"] isKindOfClass:[NSString class]])
             {
                 NSString * d=[DATA valueForKey:@"e"];
                 [self dissmiss1];
                 [av showAlertView1:d];
                 // [self dissmiss1];
             }
             else  if([[DATA valueForKey:@"s"] isKindOfClass:[NSString class]])
             {
                 [self dissmiss1];
                 [cb callBack:META :DATA];
                 return;
             }
             else
             {
                 if([META valueForKey:@"pjsresp"])
                 {
                     if([[META valueForKey:@"module"] isEqual:@"Chat"])                     {
                         NSMutableArray * ar=[[NSMutableArray alloc]init];
                         [ar addObject:DATA];
                         nobj=[[NotificationHandler alloc]init];
//                         [nobj handleChatMessage:ar];
                         NSLog(@"inside chat");
                     }
                     else
                     {
                         
                         if([META containsObject:@"frreqResp1"])
                         {
                             NSLog(@"indsie frrettt");
                             nobj=[[NotificationHandler alloc]init];
                             NSMutableArray *ar=[[NSMutableArray alloc]init];
                             [ar addObject:[data objectAtIndex:1]];
                             
                             NSLog(@"value of arrr====%@",ar);
                             
                             [nobj ManageNotification:ar];
                             
                             
                             
                         }
                         else
                         {
                             NSLog(@"indsie else frrettt");
                             [self dissmiss1];
                             [cb callBack:META :DATA];
                         }
                     }
                 }
                 else
                 {
                     // NSLog(@"Meta push noti %@",META);
                     // NSLog(@"data push noti %@",DATA);
                     NSLog(@"inside pushnotification");
                     
                     NSString * message= [DATA valueForKey:@"message"];
                     
                     // NSLog(@"meaagefeee====%@",message);
                     
                     if(message==nil||message==NULL||[message isEqual:[NSNull null]]||[message isEqual:@""]||message == (id)[NSNull null])
                     {
                     }
                     else
                     {
                         NSMutableArray * ar=[[NSMutableArray alloc]init];
                         [ar addObject:DATA];
                         nobj=[[NotificationHandler alloc]init];
                         [nobj ManageNotification:ar];
                     }
                 }
                 
                 if([META containsObject:@"fn"] && [[META valueForKey:@"fn"] isEqual:@"noti"])
                 {
                     NSMutableArray * ar=[[NSMutableArray alloc]init];
                     [ar addObject:DATA];
                     nobj=[[NotificationHandler alloc]init];
                     [nobj ManageNotification:ar];
                     NSLog(@"inside Noti");
                 }
                 
             }
         }];
        
        [socket on:@"disconnect" callback:^(NSArray* data, SocketAckEmitter* ack)
         {
             // NSLog(@"socket disconnected");
             [SavePrefrences sharedInstance].isavilNet=@"no";
             isConnect=0;
             [self dissmiss1];
         }];
        
        [socket on:@"error" callback:^(NSArray* data, SocketAckEmitter* ack)
         {
             NSLog(@"socket Error %@",data);
             [SavePrefrences sharedInstance].isavilNet=@"no";
             isConnect=0;
             [self dissmiss1];
         }];
        
        [socket on:@"reconnect"  callback:^(NSArray* data, SocketAckEmitter* ack)
         {
             
             NSLog(@"socket reconnected");
             [self dissmiss1];
             
         }];
        [socket connect];
        return isConnect;
        
    }
    @catch (NSException *exception)
    {
        [SavePrefrences sharedInstance].isavilNet=@"no";
        [self dissmiss1];
    }
    
    
}

-(NSString *)emitData :(NSString*)module :(NSString*)Func :(NSString *)Page:(NSString*)StringElement :(NSDictionary *)Data :(NSObject *)CallBack
{
    NSLog(@"inside emit data====%@",[SavePrefrences sharedInstance].isavilNet);
    NSLog(@"data ======%@",Data);
    
    
    if([[SavePrefrences sharedInstance].isavilNet isEqual:@"yes"])
    {
    if(isConnect==1)
    {
        [self dissmiss1];
        if(StringElement.length<1)
        {
            [self showLoader];
        }
        
        resp = [[NSMutableDictionary alloc]init];
          @try
            {
            if([isconnected isEqual:@"OK"])
            {
                NSLog(@"module ====%@",module);
                if (module.length>0 && Func.length>0)
                {
                    NSMutableDictionary *meta =[[NSMutableDictionary alloc]init];
                    [meta setValue:module forKey:@"m"];
                    [meta setValue:Func forKey:@"fn"];
                    
                    int randomNumber = 0 + rand() % (10000-0);
                     NSString *rans= [NSString stringWithFormat:@"%d",randomNumber];
                    [meta setValue:rans forKey:@"pjsresp"];
                    
                    NSString * sid= [SavePrefrences sharedInstance].sid;
                    NSString * at=  [SavePrefrences sharedInstance].at;
                    NSString * uid= [SavePrefrences sharedInstance].uid;
                    NSString * rl= [SavePrefrences sharedInstance].rl;
                    
                    if(sid.length<=0 && at.length<=0)
                    {
                        [meta setValue:@"" forKey:@"sid"];
                        [meta setValue:@"" forKey:@"at"];
                        [meta setValue:@"" forKey:@"rl"];
                        [meta setValue:@"" forKey:@"uid"];
                    }
                    else
                    {
                        [meta setValue:sid forKey:@"sid"];
                        [meta setValue:at forKey:@"at"];
                        [meta setValue:rl forKey:@"rl"];
                        [meta setValue:uid forKey:@"uid"];
                    }
                    [meta setValue:@"true" forKey:@"rm"];
                    if(![Page isEqualToString:@""])
                      {
                        if ([StringElement isEqualToString:@""])
                        {
                            return @"Please Mention Element name";
                        }
                        else
                        {
                            [meta setValue:Page forKey:@"Page"];
                            [meta setValue:StringElement forKey:@"element"];
                        }
                      }
                    
                    [resp setObject:CallBack forKey:rans];
                    
                    
//                    NSLog(@"request===meta===%@",meta);
//                    NSLog(@"request====data==%@",Data);
                    
                    NSArray *ar = [[NSArray alloc]initWithObjects:meta,Data,nil];
                    [socket emit:@"s" withItems:ar];
                }
            }
            else
            {
                [self dissmiss1];
            }
            
        }
        @catch (NSException *exception)
        {
            [self dissmiss1];
        }
        
        return  @"";
    }
    else
    {
        [self dissmiss1];
    }
    }
}

-(void) showLoader
 {
   // [av showAlertView:@"Please Wait....."];
    //[self startTimer];
    
 }

-(void) dissmiss1
 {
     
    [self StpTimer];
    [av DissmissAlertView];
 }
-(void) dissmiss2
{
    
   // [self StpTimer];
    [av DissmissAlertView2];
}

-(void)startTimer
 {
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(_timerFired:) userInfo:nil repeats:YES];
    }
 }

-(void)StpTimer
 {
    if ([_timer isValid])
    {
        [_timer invalidate];
    }
    tcounter=0;
    _timer = nil;
 }

-(void)_timerFired:(NSTimer *)timer
{
    tcounter++;
    NSLog(@"ping %d",tcounter);
    if(tcounter==20)
    {
        [self dissmiss1];
        [self StpTimer];
    }
}











@end
