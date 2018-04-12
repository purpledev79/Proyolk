#import "SavePrefrences.h"

@implementation SavePrefrences

static SavePrefrences *_instance;

@synthesize sid, at,rl,uid,fn,un,token,lname,fname,skthand,roleid,chatId,font,pro_image;
@synthesize cartAr,devicetimezone;
@synthesize indAr,colorDictionry,notificationDic,allNotifictionDic,chatWindowAr,allFrndChatKey;
float  screenWidth,screenHeight,naviWidth,naviHght,stbarHght,textsize;
@synthesize ntc1,ntc2,ntc3,ntc4,ntc5,ntc6,ntc7,ntc8,ntc9,ntc10,ntc11,ntc12,ntc13,ntc14,ntc15,ntc16,ntc17,ntc18,ntc19,ntc20,ntc21,ntc22,ntc23,ntc24,ntc25,ntc26,ntc27,ntc28,ntc29,ntc30,ntc33,ntc34,ntc35,ntc36,ntc37,ntc38,ntc32,isavilNet,ntc1001;
@synthesize ischkykng,ischkprofile,ischkchat,ischkcal,ischkvideo,ischkstor,ischkboard,ischkpodcast,ischkjob,notiWithoutADR,yokingcount;

+(SavePrefrences *)sharedInstance
{
    @synchronized(self)
    {
        if (_instance == nil)
        {
            _instance = [[super allocWithZone:NULL] init];
            _instance.cartAr = [[NSMutableArray alloc] initWithCapacity:200];
            _instance.indAr=[[NSArray alloc]init];
            _instance.colorDictionry=[[NSMutableDictionary alloc]init];
            _instance.frndAr=[[NSArray alloc]init];
            _instance.notificationDic=[[NSMutableDictionary alloc]init];
            _instance.allNotifictionDic=[[NSMutableDictionary alloc]init];
            _instance.chatWindowAr= [[NSMutableArray alloc] initWithCapacity:2];
            _instance.isAlViedDic=[[NSMutableDictionary alloc]init];
            _instance.notiYolkingAr=[[NSMutableArray alloc] initWithCapacity:2000];
            _instance.notiWithoutADR=[[NSMutableDictionary alloc]init];
            _instance.allFrndChatKey=[[NSMutableDictionary alloc]init];
            _instance.chatRemovekey=[[NSMutableArray alloc] initWithCapacity:2000];
            _instance.messageremovekey=[[NSMutableArray alloc] initWithCapacity:2000];
            
        }
    }
    return _instance;
}

-(void) savepref:(NSMutableArray *)data
{
    
}
-(NSMutableArray *) getpref
{
    return nil;
}
@end
