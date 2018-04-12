#import <Foundation/Foundation.h>
#import "Pjscallback.h"
#import "myprojectNew-Swift.h"
#import "PjsCallBack.h"


@interface SocketHandler :NSObject<PjsCallBack>

@property (nonatomic,strong) NSMutableDictionary *resp;
@property(nonatomic,strong) NSString *isconnected;
@property(nonatomic,strong)NSString *btkurl;

-(void) showLoader;
-(void) dissmiss1;



-(NSString *)emitData :(NSString*)module :(NSString*)Func :(NSString *)Page :(NSString*)StringElement :(NSDictionary *)Data :(NSObject *)CallBack;

-(int )initconn :(NSString*)host :(NSMutableDictionary *) chnl;
@property (nonatomic,strong) SocketIOClient* socket;


+(SocketHandler *)sharedInstance;


@end
