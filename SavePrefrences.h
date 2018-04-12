#import <Foundation/Foundation.h>

#import "SocketHandler.h"

@interface SavePrefrences : NSObject

-(void) savepref:(NSMutableArray *)data;

@property(nonatomic,strong) NSString *sid,*devicetimezone,*serverTimeRece,
*at,*rl,*uid,*fn,*un,*token,*lname,*fname,*roleid,*chatId,*font, *pro_image;
@property(nonatomic,strong) SocketHandler *skthand;
@property(nonatomic)float
screenWidth,screenHeight,naviWidth,naviHght,stbarHght,textsize;
@property(nonatomic,strong) NSMutableArray *cartAr,*chatWindowAr,*notiYolkingAr,*chatRemovekey,*messageremovekey;
@property(nonatomic,strong) NSArray *indAr,*frndAr;
@property(nonatomic,strong) NSMutableDictionary *colorDictionry,*notificationDic,*allNotifictionDic,*isAlViedDic ,*notiWithoutAD,*notiWithoutADR,*allFrndChatKey;
@property(nonatomic,strong) NSString *ntc1,*ntc2,*ntc3,*ntc4,*ntc5,*ntc6,*ntc7,*ntc8,*ntc9,*ntc10,*ntc11,*ntc12,*ntc13,*ntc14,*ntc15,*ntc16,*ntc17,*ntc18,*ntc19,*ntc20,*ntc21,*ntc22,*ntc23,*ntc24,*ntc25,*ntc26,*ntc27,*ntc28,*ntc29,*ntc30,*ntc31,*ntc33,*ntc34,*ntc35,*ntc36,*ntc37,*ntc38,*ntc32,*ntc1001;
@property(nonatomic,strong) NSString *ischkykng,*ischkprofile,*ischkchat,*ischkcal,*ischkvideo,*ischkstor,*ischkboard,*ischkpodcast,*ischkjob;
-(NSMutableArray *) getpref;
@property(nonatomic ,strong) NSString * isavilNet,*yokingcount;



+(SavePrefrences *)sharedInstance;

@end
