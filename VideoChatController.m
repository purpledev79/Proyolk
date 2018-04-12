//
//  VideoChatController.m
//  Proyolk
//
//  Created by iFlame on 09/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "VideoChatController.h"
#import "LeftRightDrawer.h"
#import "SavePrefrences.h"
#import "openChat.h"
#import "AppDelegate.h"
#import "ManageArray.h"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"
#import "ChatStorageEngine.h"

#define STUN_SERVER_1 @"stun:proyolk.com:3479"
#define STUN_SERVER_2 @"stun:butikka.com:3479"
#define TURN_SERVER_1 @"turn:butikka.com:3478"
#define TURN_SERVER_2 @"turn:proyolk.com:3478"
#define ICE_SERVER_USERNAME @"test"
#define ICE_SERVER_PASSWORD @"1234"

static CGFloat const kLocalViewPadding = 5;

@interface VideoChatController (){
    openChat *oppChat;
    LeftRightDrawer *drawer;
    ManageArray *mang;
    AVAudioPlayer *ringtonePlayer;
}
@end

@implementation VideoChatController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.videoView setHidden:false];
    [self.Conference setHidden:true];
    
    opop=[[openChat alloc]init];
    allValidVC=[[AllValidationsViewController alloc]init];
    drawer=[[LeftRightDrawer alloc]init];
    mngAr=[[ManageArray alloc]init];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self customizeActionBar];
    [self cameraSelectionAlert];
    // SEGMENT CONTROL
    
    _segmentControl.selectionIndicatorColor = [UIColor colorWithRed:0.05 green:0.87 blue:0.78 alpha:1.0];
    _segmentControl.selectionIndicatorHeight = 3.0f;
    _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _segmentControl.sectionTitles = @[@"Videos", @"Conference"];
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.verticalDividerEnabled = NO;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    [_segmentControl setSelectedTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.05 green:0.87 blue:0.78 alpha:1.0], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:16.0f]}];
    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.44 green:0.58 blue:0.06 alpha:1.0], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:16.0f]}];
    [_segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view updateConstraintsIfNeeded];
    screenShareContainer = [[UIView alloc] init];
    
    self.localVideoView =
    [[RTCEAGLVideoView alloc] initWithFrame:self.blackView.bounds];
    self.localVideoView.delegate = self;
    [self.blackView addSubview:self.localVideoView];
    
    [_fullscreenView setHidden:YES];
    
    callsOnline = [[NSMutableDictionary alloc] init];
    multCallDict = [[NSMutableDictionary alloc] init];
    mang=[[ManageArray alloc]init];
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/callertone.mp3",[[NSBundle mainBundle] resourcePath]];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    ringtonePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    ringtonePlayer.numberOfLoops = -1; //Infinite
    
    [_controlsContainer setHidden:YES];
    
    [[ChatStorageEngine sharedManager] removeGroupChat];
}

- (void)viewDidAppear:(BOOL)animated{
    [drawer.mainView removeFromSuperview];
    if (!alreadyLoaded) {
        [_blackView setHidden:YES];
        //    [_controlsContainer setHidden:YES];
        [self callViewMinimal];
        
        // VIDEO CALL NOTIFICATIONS
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleIncomingCall:) name:@"CALL_INCOMING" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outgoingCallRejected:) name:@"CALL_REJECTED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outgoingCallAccepted:) name:@"CALL_ACCEPTED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performCreateAnswer:) name:@"CREATE_ANSWER" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performInitialOfferAccept:) name:@"INITIAL_OFFER" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performAcceptOffer:) name:@"ACCEPT_OFFER" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performAcceptAnswer:) name:@"ACCEPT_ANSWER" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performDisconnection:) name:@"CALL_DISCONNECTED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performAcceptCandidate:) name:@"ACCEPT_CANDIDATE" object:nil];
        
        // SCREEN SHARING NOTIFICATIONS
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareIncomingRequest:) name:@"SS_CALL_INCOMING" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareRemoteAccepted:) name:@"SS_CALL_ACCEPTED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareRemoteRejected:) name:@"SS_CALL_REJECTED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareIncomingICECandidate:) name:@"SS_ICE_CANDIDATE_INCOMING" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareOfferReceived:) name:@"SS_OFFER_RECEIVED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareSDPReceived:) name:@"SS_SDP_RECEIVED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareAnswerReceived:) name:@"SS_ANSWER_RECEIVED" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShareCallEnd:) name:@"SS_CALL_END" object:nil];
        
        // CONFERENCE CALL NOTIFICATIONS
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conferenceIncomingRequest:) name:@"CC_CALL_INCOMING" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conferenceAddConnection:) name:@"CC_CALL_ADD_CONN" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conferenceRemoteResponse:) name:@"CC_CALL_REMOTE_RESPONSE" object:nil];
        
        if(_incomingCall.length) [self showIncomingCall:_incomingCall];
        if(_outgoingCall.length) [self callMethod:_outgoingCall];
        if(_acceptedCall.length) {
            tempUserId = _acceptedCall;
            [self acceptIncomingCall:nil];}
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {}];
        
        alreadyLoaded = YES;
    
        [_groupChatBtn setHidden:YES];
    }
    isShowingChat = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [ringtonePlayer stop];
    if (isShowingChat || alreadyLoaded) return;
    NSArray* notifs = @[@"CALL_INCOMING", @"CALL_REJECTED", @"CALL_ACCEPTED", @"CREATE_ANSWER", @"ANSWER_CREATED", @"INITIAL_OFFER", @"ACCEPT_OFFER", @"ACCEPT_ANSWER", @"ACCEPT_CANDIDATE", @"CALL_DISCONNECTED", @"SS_CALL_INCOMING", @"SS_CALL_ACCEPTED", @"SS_CALL_REJECTED", @"SS_ICE_CANDIDATE_INCOMING", @"SS_OFFER_RECEIVED", @"SS_SDP_RECEIVED", @"SS_ANSWER_RECEIVED", @"SS_CALL_END", @"CC_CALL_INCOMING", @"CC_CALL_REMOTE_RESPONSE"];
    for (NSString* notiName in notifs) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notiName object:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)customizeActionBar
{
    [drawer initArs:self];
    NSMutableDictionary *brd=[SavePrefrences sharedInstance].colorDictionry;
    self.view.backgroundColor=[brd valueForKey:@"backcolor"];
    //[self.view addSubview:main];
    //[self reteriveFriends];
    //[self ChatList];
}

#pragma mark - HMSegmentedControlDelegate Protocol Methods

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    // update the view for the corresponding index
    
}

- (IBAction)btnClickAction:(id)sender {
    UIButton *btn = (UIButton *)sender;

    if (btn.tag == 101) {
        [self.videoView setHidden:false];
        [self.Conference setHidden:true];
    }
    else{
        [self.videoView setHidden:true];
        [self.Conference setHidden:false];
    }

}

- (IBAction)disconnectButton:(id)sender {
    [ringtonePlayer stop];
    if (!_connectCallView.isHidden) {
        [_connectCallView setHidden:YES];
        for (NSString* user in callsOnline.allKeys) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
            [params setObject:user forKey:@"fruid"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"cc" :@"" :@"" :params :self ];
        }
    }else{
        for (NSString* user in callsOnline.allKeys) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
            [params setObject:user forKey:@"fruid"];
            [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"ce" :@"" :@"" :params :self ];
            [self disconnect:user];
        }
    }
}

-(IBAction)btnChatAction:(id)sender{
    oppChat = [[openChat alloc]init];
    [[SavePrefrences sharedInstance].chatWindowAr addObject:oppChat];
    [SavePrefrences sharedInstance].chatId=[NSString stringWithFormat:@"%d",101];
    [oppChat openchat:self withImage:nil];
}

#pragma mark VIDEO CALLING

- (NSDictionary*)contactFromId:(NSString*)userId{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    for (NSDictionary* dict in appDelegate.allFriends) {
        if ([[NSString stringWithFormat:@"%@", dict[@"u_id"]] isEqualToString:userId]) {
            return dict;
        }
    }
    return nil;
}

- (void)callMethod:(id)meta{
    if (meta) {
        NSString* userId = [NSString stringWithFormat:@"%@", meta];
        NSDictionary* contact = [self contactFromId:userId];
        if (![contact[@"isonline"] intValue]) {
            NSString* message = [NSString stringWithFormat:@"%@ %@ is not online, please try later.", contact[@"fname"], contact[@"lname"]];
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Proyolk"  message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            tempUserId = userId;
            if (callsOnline.allKeys.count) {
                isIncoming = NO;
                [self initiateCall:tempUserId];
            }else{
                [_contactNameLbl setText:[NSString stringWithFormat:@"Calling %@ %@ ...", contact[@"fname"], contact[@"lname"]]];
                [_connectCallView setHidden:NO];
                NSString *img = contact[@"img"];
                NSString * url=[mang concatUrl:img];
                [_contactImageView sd_setImageWithURL:[NSURL URLWithString:url]];
                [self initiateCall:tempUserId];
                isIncoming = NO;
                [ringtonePlayer play];
            }
        }
    }
}

- (void)initiateCall:(NSString*)otherUserId{
    if (callsOnline.allKeys.count) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:tempUserId forKey:@"fruid"];
        NSMutableArray* fruids = callsOnline.allKeys.mutableCopy;
        [fruids removeObject:[SavePrefrences sharedInstance].uid];
        [params setObject:fruids forKey:@"fruids"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"callCon" :@"" :@"" :params :self ];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:[NSNumber numberWithInteger:[otherUserId integerValue]] forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"call" :@"" :@"" :params :self ];
    }
}

- (void)outgoingCallRejected:(NSNotification *)notification{
    [ringtonePlayer stop];
    if (isIncoming) {
        if (![_incomingCallView isHidden]) {
            [_incomingCallView setHidden:YES];
        }
        [self disconnect:notification.userInfo[@"uid"]];
    }else{
        if (![_connectCallView isHidden]) {
            [_connectCallView setHidden:YES];
        }else{
            [self disconnect:notification.userInfo[@"uid"]];
        }
    }
}

- (void)performDisconnection:(NSNotification *)notification{
    [ringtonePlayer stop];
    [self disconnect:notification.userInfo[@"uid"]];
}

- (void)outgoingCallAccepted:(NSNotification *)notification{
    [ringtonePlayer stop];
    [_connectCallView setHidden:YES];
//    [self cameraSelectionAlert];
    NSDictionary* userInfo = notification.userInfo;
    [self startCaptureSession:NO userId:userInfo[@"uid"]];
}

- (void)handleIncomingCall:(NSNotification *)notification{
    [self showIncomingCall:[NSString stringWithFormat:@"%@", notification.userInfo[@"uid"]]];
}

- (void)showIncomingCall:(NSString*)userId{
    [ringtonePlayer play];
    isIncoming = YES;
    tempUserId = userId;
    [_videoView bringSubviewToFront:_incomingCallView];
    [_incomingCallView setHidden:NO];
    NSDictionary* contact = [self contactFromId:tempUserId];
    [_ic_contactNameLbl setText:[NSString stringWithFormat:@"%@ %@ is Calling", contact[@"fname"], contact[@"lname"]]];
    NSString *img = contact[@"img"];
    NSString * url=[mang concatUrl:img];
    [_ic_contactImageView sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (void)performCreateOffer:(PYARDAppClient*)client{
    RTCSessionDescription *sdp = client.peerConnection.localDescription;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:client.clientId forKey:@"fruid"];
    
    NSMutableDictionary* off = [NSMutableDictionary dictionary];
    [off setObject:@"offer" forKey:@"type"];
    [off setObject:sdp.description forKey:@"sdp"];
    
    [params setObject:off forKey:@"off"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"of" :@"" :@"" :params :self ];
    NSLog(@"CREATED AND SENT **** OFFER ****");
}

- (void)performInitialOfferAccept:(NSNotification *)notification{
    NSLog(@"INITIAL OFFER RECEIVED **** %@ ****", notification.userInfo[@"uid"]);
    [self startCaptureSession:YES userId:notification.userInfo[@"uid"]];
}
    
- (void)performAcceptOffer:(NSNotification *)notification{
    NSString* userId = notification.userInfo[@"uid"];
    PYARDAppClient* client = callsOnline[userId];
    if (client.state != 3) {
        [client acceptIncomingOffer:notification.userInfo[@"csdp"][@"sdp"]];
    }
}

- (void)performAcceptAnswer:(NSNotification *)notification{
    NSString* userId = notification.userInfo[@"uid"];
    PYARDAppClient* client = callsOnline[userId];
    [client acceptIncomingAnswer:notification.userInfo[@"ans"][@"sdp"]];
}


- (void)performAcceptCandidate:(NSNotification *)notification{
    NSDictionary* candidate = notification.userInfo[@"cand"];
    NSString* userId = notification.userInfo[@"uid"];
    PYARDAppClient* client = callsOnline[userId];
    [client acceptIncomingCandidate:candidate];
}

- (void)performIceCall:(PYARDAppClient*)client{
    NSLog(@"**** PERFORM **** ICE **** CALL");
    RTCPeerConnection* peerConnection = client.peerConnection;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:client.clientId forKey:@"fruid"];
    
    NSMutableDictionary *csdp = [NSMutableDictionary dictionary];
    [csdp setObject:@"offer" forKey:@"type"];
    [csdp setObject:peerConnection.localDescription.description forKey:@"sdp"];
    
    [params setObject:csdp forKey:@"csdp"];
    
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"cs" :@"" :@"" :params :self ];
}

- (void)performCreateAnswer:(NSNotification *)notification{
    NSString* userId = notification.userInfo[@"uid"];
    PYARDAppClient* client = callsOnline[userId];
    [client acceptIncomingOffer:notification.userInfo[@"csdp"][@"sdp"]];
}

- (void)performAnswerCreated:(PYARDAppClient*)client{
    NSString* sdpDesc = client.peerConnection.localDescription.description;
    NSDictionary* sdp = @{
                          @"type" : @"answer",
                          @"sdp" : sdpDesc
                          };
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:client.clientId forKey:@"fruid"];
    [params setObject:sdp forKey:@"ans"];
    if (scrSharOngoing) {
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"assn" :@"" :@"" :params :self ];
    }else [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"an" :@"" :@"" :params :self ];
}

- (void)addToMultipleCall:(NSString*)userId{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:userId forKey:@"fruid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"ca" :@"" :@"" :params :self ];
    [self startCaptureSession:YES userId:userId];
}

- (IBAction)acceptIncomingCall:(id)sender {
    [ringtonePlayer stop];
    [_incomingCallView setHidden:YES];
    isIncoming = YES;
    if (_confUsers.count) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:tempUserId forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"caCon" :@"" :@"" :params :self ];
        
        if (_confUsers.count) {
            for (NSString* user in _confUsers) {
                NSMutableDictionary* params = [NSMutableDictionary dictionary];
                [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
                [params setObject:user forKey:@"fruid"];
                [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"stCon" :@"" :@"" :params :self ];
                NSLog(@"ADDING PARTICIPANT TO CALL *** %@ ***", user);
            }
        }
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:tempUserId forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"ca" :@"" :@"" :params :self ];
    }
//    [self cameraSelectionAlert];
}

- (IBAction)rejectIncomingCall:(id)sender {
    [ringtonePlayer stop];
    [_incomingCallView setHidden:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:tempUserId forKey:@"fruid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"cc" :@"" :@"" :params :self ];
}

- (void)cameraSelectionAlert{
    NSString* alertTitle = @"Select Camera";
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:alertTitle  message:@"Select the camera for video call."  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Front" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        AVCaptureDevice *device;
        for (AVCaptureDevice *captureDevice in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] ) {
            if (captureDevice.position == AVCaptureDevicePositionFront) {
                device = captureDevice;
                break;
            }
        }
        [self cameraSelected:device];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        AVCaptureDevice *device;
        for (AVCaptureDevice *captureDevice in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] ) {
            if (captureDevice.position == AVCaptureDevicePositionBack) {
                device = captureDevice;
                break;
            }
        }
        [self cameraSelected:device];
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    // Find the device that is the front facing camera
    
}

- (void)cameraSelected:(AVCaptureDevice*)device{
//    [self startCaptureSession:NO];
    
}

- (void)startCaptureSession:(BOOL)incoming userId:(NSString*)userId{
    NSLog(@"REQUEST TO ADDING TO CONFERENCE **** %@", userId);
     if(callsOnline[userId])return;
    
    // TODO(tkchin): support reusing the same client object.
    BOOL isCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    __block BOOL isAudio = NO;
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    if(permissionStatus == AVAudioSessionRecordPermissionGranted) isAudio = YES;
    
    if(!isCamera)NSLog(@"NO CAMERA AVAILABLE");
    if(!isAudio)NSLog(@"NO AUDIO DEVICE AVAILABLE");
    
    if (!isCamera && !isAudio) {
        [self disconnectButton:nil];
        return;
    }
    
    
    PYARDAppClient *client = [[PYARDAppClient alloc] initWithDelegate:self];
    client.clientId = [NSString stringWithFormat:@"%@", userId];
    client.hasAudio = isAudio;
    client.hasCamera = isCamera;
    if (callsOnline.allValues.count) {
        PYARDAppClient* firstClient = callsOnline.allValues[0];
        if (firstClient.localClientStream) {
            client.localClientStream = firstClient.localClientStream;
        }
    }else{
        [self speakerControlAction:nil];
    }
    if (scrSharOngoing) {
        client.forSharing = YES;
        scrShareClient = @{userId:client};
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.callOngoing = YES;
    [callsOnline setObject:client forKey:userId];
    [client connectWithPeer:incoming];
    [self setupCaptureSession];
    
    if (![appDelegate.conferenceMembers containsObject:userId]) {
        [appDelegate.conferenceMembers addObject:userId];
    }
}


#pragma mark CONFERENCE CALLS

- (void)conferenceIncomingRequest:(NSNotification*)notification{
    [ringtonePlayer play];
    isIncoming = YES;
    tempUserId = notification.userInfo[@"uid"];
    [_videoView bringSubviewToFront:_incomingCallView];
    [_incomingCallView setHidden:NO];
    NSDictionary* contact = [self contactFromId:tempUserId];
    [_ic_contactNameLbl setText:[NSString stringWithFormat:@"%@ %@ has initiated a conference call", contact[@"fname"], contact[@"lname"]]];
    NSString *img = contact[@"img"];
    NSString * url=[mang concatUrl:img];
    [_ic_contactImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    _confUsers = notification.userInfo[@"fruids"];
    
    
}

- (void)conferenceAddConnection:(NSNotification*)notification{
    NSString* userId = [NSString stringWithFormat:@"%@", notification.userInfo[@"uid"]];
    NSLog(@"INCOMING CONFERENCE ADD CONNECTION ****** %@", userId);
    if ([_confUsers containsObject:userId] || [userId isEqualToString:[SavePrefrences sharedInstance].uid]) {
        return;
    }
    if (_confUsers.count) {
        NSMutableArray* users = [[NSMutableArray alloc] initWithArray:_confUsers];
        [users addObject:userId];
        _confUsers = users.copy;
    }
    if (callsOnline[userId]) {
        return;
    }
    NSLog(@"INCOMING CONFERENCE ACCEPT CONNECTION ****** %@", userId);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:userId forKey:@"fruid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"stCon" :@"" :@"" :params :self ];
}

- (void)conferenceRemoteResponse:(NSNotification*)notification{
    [self startCaptureSession:NO userId:notification.userInfo[@"uid"]];
}


- (void)addUsersToConference{
    for (NSString* user in _confUsers) {
        [self startCaptureSession:NO userId:user];
    }
}

- (IBAction)groupChatAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.callOngoing){
        isShowingChat = YES;
        UIStoryboard *mainStoryboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ChatViewController *vc2=[mainStoryboard instantiateViewControllerWithIdentifier:@"CHAT_SCREEN"];
        if (callsOnline.allKeys.count==1) {
            vc2.userId = callsOnline.allKeys[0];
        }else vc2.participants = callsOnline.allKeys;
        [self showViewController:vc2 sender:nil];
    }
}

#pragma mark --

#pragma mark SCREEN SHARING

- (void)screenShareIncomingRequest:(NSNotification*)notification{
    NSString* userId = [NSString stringWithFormat:@"%@", notification.userInfo[@"uid"]];
    NSDictionary* contact = [self contactFromId:userId];
    NSString* message = [NSString stringWithFormat:@"%@ %@ wants to share screen with you", contact[@"fname"], contact[@"lname"]];
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Proyolk"  message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:userId forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"conf_ss" :@"" :@"" :params :self ];
        scrSharOngoing = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:userId forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"rej_ss" :@"" :@"" :params :self ];
        scrSharOngoing = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)screenShareRemoteAccepted:(NSNotification*)notification{
    NSLog(@"*** SCREEN SHARING *** screenShareRemoteAccepted");
}

- (void)screenShareRemoteRejected:(NSNotification*)notification{
    NSLog(@"*** SCREEN SHARING *** screenShareRemoteRejected");
}

- (void)screenShareIncomingICECandidate:(NSNotification*)notification{
    NSLog(@"*** SCREEN SHARING *** screenShareIncomingICECandidate");
}

- (void)screenShareOfferReceived:(NSNotification*)notification{
    NSLog(@"*** SCREEN SHARING *** screenShareOfferReceived");
    [self startCaptureSession:YES userId:notification.userInfo[@"uid"]];
//    NSString* userId = notification.userInfo[@"uid"];
//    PYARDAppClient* client = scrShareClient[userId];
//    [client acceptIncomingOffer:notification.userInfo[@"off"][@"sdp"]];
}

- (void)screenShareSDPReceived:(NSNotification*)notification{
    NSLog(@"*** SCREEN SHARING *** screenShareSDPReceived");
    NSString* userId = notification.userInfo[@"uid"];
    PYARDAppClient* client = scrShareClient[userId];
    [client acceptIncomingOffer:notification.userInfo[@"csdp"][@"sdp"]];
}

- (void)screenShareAnswerReceived:(NSNotification*)notification{
    NSLog(@"*** SCREEN SHARING *** screenShareAnswerReceived");
}

- (void)screenShareCallEnd:(NSNotification*)notification{
    if(!cleanedUp) [self cleanUpScreenShare];
}

- (void)cleanUpScreenShare{
    NSLog(@"CLEANING UP NOW");
    if (scrShareVideoView.videoTrack) {
        [scrShareVideoView.videoTrack removeRenderer:scrShareVideoView];
        [scrShareVideoView renderFrame:nil];
        scrShareVideoView.videoTrack = nil;
    }
    [scrShareVideoView removeFromSuperview];
    scrShareVideoView = nil;
    scrSharOngoing = NO;
    [screenShareContainer removeFromSuperview];
    PYARDAppClient* client = scrShareClient.allValues[0];
    [client disconnect];
//    scrShareClient = [[NSDictionary alloc] init];
    [self updateVideoViewLayout];
    [_screenShareControl setSelected:NO];
}

#pragma mark --

#pragma mark CALL CONTROLS
- (IBAction)muteControlAction:(id)sender {
    if (_muteControl.isSelected) {
        [_muteControl setSelected:NO];
        [[AVAudioSession sharedInstance]setMode:AVAudioSessionModeVoiceChat error:nil];
        [[AVAudioSession sharedInstance]setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    }else{
        [_muteControl setSelected:YES];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];//or AVAudioSessionCategoryPlayback
    }
}

- (IBAction)speakerControlAction:(id)sender {
    if (_speakerControl.selected) {
        [_speakerControl setSelected:NO];
        [self setAudioOutputSpeaker:NO];
    }else{
        [_speakerControl setSelected:YES];
        [self setAudioOutputSpeaker:YES];
    }
}

- (IBAction)fullscreenControlAction:(id)sender {
    if (_fullscreenControl.isSelected) {
        [self callViewMinimal];
    }else{
        [_fullscreenControl setSelected:YES];
        [_blackView removeFromSuperview];
        [_blackView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:_blackView];
    }
}

- (void)callViewMinimal{
    [_fullscreenControl setSelected:NO];
    [_blackView removeFromSuperview];
    [_blackView setFrame:CGRectMake(0, 0, _videoView.frame.size.width, _videoView.frame.size.height)];
    [_videoView addSubview:_blackView];
}

- (IBAction)screenSharing:(id)sender {
    if ([_screenShareControl isSelected]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
        [params setObject:scrShareClient.allKeys[0] forKey:@"fruid"];
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"ss_end" :@"" :@"" :params :self ];
        [self screenShareCallEnd:nil];
    }
}

- (IBAction)endCallControlAction:(id)sender {
    [self disconnectButton:nil];
    [ringtonePlayer stop];
}

- (void)setAudioOutputSpeaker:(BOOL)enabled{
    AVAudioSession *session =   [AVAudioSession sharedInstance];
    NSError *error;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [session setMode:AVAudioSessionModeVoiceChat error:&error];
    if (enabled){ // Enable speaker
        [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    }
    else{ // Disable speaker
        [session overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:&error];
    }
    [session setActive:YES error:&error];
}

- (IBAction)ogMuteBtnAction:(id)sender {
    if ([_muteBtnLabel.text isEqualToString:@"Mute"]) {
        [_muteBtnLabel setText:@"Unmute"];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    }else{
        [_muteBtnLabel setText:@"Mute"];
        [[AVAudioSession sharedInstance]setMode:AVAudioSessionModeVoiceChat error:nil];
        [[AVAudioSession sharedInstance]setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    }
}

- (IBAction)ogSpeakerBtnAction:(id)sender {
    if ([_speakerBtnLbl.text isEqualToString:@"Speaker"]) {
        [_speakerBtnLbl setText:@"Speaker-off"];
        [self setAudioOutputSpeaker:YES];
    }else{
        [_speakerBtnLbl setText:@"Speaker"];
        [self setAudioOutputSpeaker:NO];
    }
}

#pragma mark MISC

- (void)resetUI:(NSString*)userId{
    if (multCallArr.count) {
        for (PYRTCEAGLVideoView* __strong view in multCallArr.copy) {
            if ([view.clientId isEqualToString:[NSString stringWithFormat:@"%@", userId]]) {
                if (view.videoTrack) {
                    [view renderFrame:nil];
                    [view.videoTrack removeRenderer:view];
                    view.videoTrack = nil;
                }
                [view removeFromSuperview];
                [multCallArr removeObject:view];
                [self updateVideoViewLayout];
                __strong PYARDAppClient* client = callsOnline[userId];
                if (!disconnectedClients) {
                    disconnectedClients = [NSMutableArray arrayWithCapacity:0];
                }
                [disconnectedClients addObject:client];
                @try {
                    [callsOnline removeObjectForKey:userId];
                } @catch (NSException *exception) {
                    NSLog(@"RTC CLIENT GETTING EXCEPTION CAUGHT");
                }
                break;
            }
        }
    }
    if (!callsOnline.allValues.count) {
        if (_localVideoTrack) {
            [_localVideoTrack removeRenderer:self.localVideoView];
            _localVideoTrack = nil;
            [self.localVideoView renderFrame:nil];
        }
        [self muteControlAction:nil];
        [self speakerControlAction:nil];
        self.blackView.hidden = YES;
        tempUserId = @"";
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.callOngoing = NO;
    }
}

- (void)disconnect:(NSString*)userId{
    if (callsOnline[userId]) {
        PYARDAppClient* client = callsOnline[userId];
        [client disconnect];
        [self resetUI:userId];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if ([appDelegate.conferenceMembers containsObject:userId]) {
            [appDelegate.conferenceMembers removeObject:userId];
        }
    }
}

- (void)setupCaptureSession {
    self.blackView.hidden = NO;
    [self updateVideoViewLayout];
}

- (void)updateVideoViewLayout {
    // TODO(tkchin): handle rotation.
    CGSize defaultAspectRatio = CGSizeMake(4, 3);
    CGSize localAspectRatio = CGSizeEqualToSize(_localVideoSize, CGSizeZero) ?
    defaultAspectRatio : _localVideoSize;
    
    
    // LOCAL VIDEO FRAME SIZE SETTINGS
    CGRect localVideoFrame =
    AVMakeRectWithAspectRatioInsideRect(localAspectRatio,
                                        self.blackView.bounds);
    localVideoFrame.size.width = localVideoFrame.size.width / 4;
    localVideoFrame.size.height = localVideoFrame.size.height / 4;
    localVideoFrame.origin.x = CGRectGetMaxX(self.blackView.bounds)
    - localVideoFrame.size.width - kLocalViewPadding;
    localVideoFrame.origin.y = CGRectGetMaxY(self.blackView.bounds)
    - localVideoFrame.size.height - kLocalViewPadding;
    self.localVideoView.frame = localVideoFrame;
    
    // REMOTE VIDEO FRAME SIZE SETTINGS
    switch (multCallArr.count) {
        case 1:{
            if (scrShareVideoView) {
                CGRect remoteVideoFrame1 = CGRectMake(0, 0, _blackView.frame.size.width, _blackView.frame.size.height-60);
                scrShareVideoView.frame = remoteVideoFrame1;
                [scrShareVideoView resetConstraints];
                
                PYRTCEAGLVideoView* remoteView = multCallArr[0];
                remoteView.frame = CGRectMake(self.localVideoView.frame.origin.x-self.localVideoView.frame.size.width, self.localVideoView.frame.origin.y, self.localVideoView.frame.size.width, self.localVideoView.frame.size.height);
                [remoteView resetConstraints];
                [_blackView bringSubviewToFront:remoteView];
            }else{
                PYRTCEAGLVideoView* remoteView = multCallArr[0];
                CGSize remoteAspectRatio = CGSizeEqualToSize(_remoteVideoSize, CGSizeZero) ? defaultAspectRatio : _remoteVideoSize;
                CGRect remoteVideoFrame = AVMakeRectWithAspectRatioInsideRect(remoteAspectRatio, self.blackView.bounds);
                remoteView.frame = remoteVideoFrame;
                [remoteView resetConstraints];
            }
            break;
        }
        case 2:{
            PYRTCEAGLVideoView* remoteView1 = multCallArr[0];
            PYRTCEAGLVideoView* remoteView2 = multCallArr[1];
            CGSize remoteAspectRatio = CGSizeEqualToSize(CGSizeMake(self.blackView.frame.size.width, self.blackView.frame.size.height/2), CGSizeZero) ? defaultAspectRatio : CGSizeMake(self.blackView.frame.size.width, self.blackView.frame.size.height/2);
            CGRect remoteVideoFrame1 = AVMakeRectWithAspectRatioInsideRect(remoteAspectRatio, CGRectMake(0, 0, self.blackView.frame.size.width, self.blackView.frame.size.height/2));
            remoteView1.frame = remoteVideoFrame1;
            [remoteView1 resetConstraints];
            
            CGRect remoteVideoFrame2 = AVMakeRectWithAspectRatioInsideRect(remoteAspectRatio, CGRectMake(0, (self.blackView.frame.size.height/2), self.blackView.frame.size.width, self.blackView.frame.size.height/2));
            remoteView2.frame = remoteVideoFrame2;
            [remoteView2 resetConstraints];
            break;
        }
        case 3:{
            PYRTCEAGLVideoView* remoteView1 = multCallArr[0];
            PYRTCEAGLVideoView* remoteView2 = multCallArr[1];
            PYRTCEAGLVideoView* remoteView3 = multCallArr[2];
//            CGSize remoteAspectRatio = CGSizeEqualToSize(_remoteVideoSize, CGSizeZero) ? defaultAspectRatio : _remoteVideoSize;
            CGRect remoteVideoFrame1 = CGRectMake(0, 0, self.blackView.frame.size.width/2, self.blackView.frame.size.height/2);
            remoteView1.frame = remoteVideoFrame1;
            [remoteView1 resetConstraints];
            
            CGRect remoteVideoFrame2 = CGRectMake(self.blackView.frame.size.width/2, 0, self.blackView.frame.size.width/2, self.blackView.frame.size.height/2);
            remoteView2.frame = remoteVideoFrame2;
            [remoteView2 resetConstraints];
            
            CGRect remoteVideoFrame3 = CGRectMake(0, self.blackView.frame.size.height/2, self.blackView.frame.size.width, self.blackView.frame.size.height/2);
            remoteView3.frame = remoteVideoFrame3;
            [remoteView3 resetConstraints];
            break;
        }
        case 4:{
            PYRTCEAGLVideoView* remoteView1 = multCallArr[0];
            PYRTCEAGLVideoView* remoteView2 = multCallArr[1];
            PYRTCEAGLVideoView* remoteView3 = multCallArr[2];
            PYRTCEAGLVideoView* remoteView4 = multCallArr[3];
//            CGSize remoteAspectRatio = CGSizeEqualToSize(CGSizeMake(self.blackView.frame.size.width/2, self.blackView.frame.size.height/2), CGSizeZero) ? defaultAspectRatio : _remoteVideoSize;
            CGRect remoteVideoFrame1 = CGRectMake(0, 0, self.blackView.frame.size.width/2, self.blackView.frame.size.height/2);
            remoteView1.frame = remoteVideoFrame1;
            [remoteView1 resetConstraints];
            
            CGRect remoteVideoFrame2 = CGRectMake(self.blackView.frame.size.width/2, 0, self.blackView.frame.size.width/2, self.blackView.frame.size.height/2);
            remoteView2.frame = remoteVideoFrame2;
            [remoteView2 resetConstraints];
            
            CGRect remoteVideoFrame3 = CGRectMake(0, self.blackView.frame.size.height/2, self.blackView.frame.size.width/2, self.blackView.frame.size.height/2);
            remoteView3.frame = remoteVideoFrame3;
            [remoteView3 resetConstraints];
            
            CGRect remoteVideoFrame4 = CGRectMake(self.blackView.frame.size.width/2, self.blackView.frame.size.height/2, self.blackView.frame.size.width/2, self.blackView.frame.size.height/2);
            remoteView4.frame = remoteVideoFrame4;
            [remoteView4 resetConstraints];

            break;
        }
            
        default:
            break;
    }
    
    [_blackView bringSubviewToFront:_localVideoView];
//    [_blackView bringSubviewToFront:_controlsContainer];
    
    if (multCallArr.count == 1) {
        for (PYRTCEAGLVideoView* view in multCallArr) {
            [view hideControls:YES];
        }
        [_controlsContainer setHidden:NO];
        [_blackView bringSubviewToFront:_controlsContainer];
    }else{
        for (PYRTCEAGLVideoView* view in multCallArr) {
            [view hideControls:NO];
        }
        [_controlsContainer setHidden:YES];
        if (scrShareVideoView) {
            screenShareContainer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [screenShareContainer setBackgroundColor:[UIColor blackColor]];
            [screenShareContainer setAlpha:1.0];
            CGRect remoteVideoFrame1 = CGRectMake(0, 65, screenShareContainer.frame.size.width, screenShareContainer.frame.size.height-65);
            scrShareVideoView.frame = remoteVideoFrame1;
            UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [backBtn setBackgroundImage:[UIImage imageNamed:@"backArrow"] forState: UIControlStateNormal];
            [backBtn addTarget:self action:@selector(screenSharing:) forControlEvents:UIControlEventTouchUpInside];
            [backBtn setTitle:@"" forState:UIControlStateNormal];
            backBtn.frame = CGRectMake(10.0, 15.0, 35.0, 35.0);
            
            [scrShareVideoView removeFromSuperview];
            [screenShareContainer addSubview:backBtn];
            [screenShareContainer addSubview:scrShareVideoView];
            [scrShareVideoView resetConstraints];
            [self.view addSubview:screenShareContainer];
        }
    }
    
    for (PYRTCEAGLVideoView* remoteView in multCallArr) {
        NSLog(@"THIS IS THE LAYOUT ***** %@", remoteView.clientId);
    }
    
    if(!_groupChatBtn.isHidden){
        [_blackView bringSubviewToFront:_groupChatBtn];
    }
}

- (void)showAlertWithMessage:(NSString*)message {
    NSString* alertTitle = @"Proyolk";
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:alertTitle  message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark SOCKET HANDLERS

-(void) callBack:(NSArray *)meta data:(NSArray *)data{
//    NSLog(@"GOT CALLBACK IN VIDEO SCREEN **** %@ \n %@", meta, data);
}

#pragma mark - ARDAppClientDelegate

- (void)appClient:(PYARDAppClient *)client didReceiveCandidate:(RTCICECandidate *)candidate{
    NSString* clientId = [NSString stringWithFormat:@"%@", client.clientId];
    if(!clientId.length)return;
    NSDictionary* cand = @{
                          @"candidate" : candidate.sdp,
                          @"sdpMLineIndex" : [NSString stringWithFormat:@"%ld", (long)candidate.sdpMLineIndex],
                          @"sdpMid": candidate.sdpMid
                          };
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:clientId forKey:@"fruid"];
    [params setObject:cand forKey:@"cand"];
    if (scrSharOngoing) {
        [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"issc" :@"" :@"" :params :self ];
    }else if(!client.isInitiator) [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"ic" :@"" :@"" :params :self ];
}

- (void)appClient:(PYARDAppClient *)client didCompleteICEGathering:(RTCSessionDescription *)description{
    if (client.isInitiator && !scrSharOngoing) {
        [self performIceCall:client];
    }
}

- (void)appClient:(PYARDAppClient *)client didSetLocalDesc:(RTCSessionDescription *)description{
    if (scrSharOngoing) {
        [self performAnswerCreated:client];
    }else if (!client.isInitiator && !scrSharOngoing){
        [self performAnswerCreated:client];
    }else if(client.isInitiator && !scrSharOngoing){
        [self performCreateOffer:client];
    }
}

- (void)appClient:(PYARDAppClient *)client didChangeState:(PYARDAppClientState)state {
    switch (state) {
        case kPYARDAppClientStateConnected:
            NSLog(@"Client connected.");
            break;
        case kPYARDAppClientStateConnecting:
            NSLog(@"Client connecting.");
            break;
        case kPYARDAppClientStateDisconnected:
            NSLog(@"Client disconnected.");
//            [self resetUI];
            break;
    }
}

- (void)appClient:(PYARDAppClient *)client didReceiveLocalVideoTrack:(RTCVideoTrack *)localVideoTrack {
    _localVideoTrack = localVideoTrack;
    [_localVideoTrack addRenderer:self.localVideoView];
    self.localVideoView.hidden = NO;
}

- (void)appClient:(PYARDAppClient *)client didReceiveRemoteVideoTrack:(RTCVideoTrack *)remoteVideoTrack {
    NSLog(@"RECEIVED REMOTE VIDEO TRACK FOR **** %@", client.clientId);
    if (!multCallArr) {
        multCallArr = [[NSMutableArray alloc] init];
//        if (confUsers.count) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSLog(@"MAKE OUTGOING CONNECTIONS");
//                [self addUsersToConference];
//            });
//            
//        }
    }
    PYRTCEAGLVideoView *remoteVideoView = [[PYRTCEAGLVideoView alloc] initWithFrame:self.blackView.bounds];
    remoteVideoView.delegate = self;
    remoteVideoView.clientId = client.clientId;
    [remoteVideoView.muteBtn addTarget:self action:@selector(videoViewMuteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [remoteVideoView.cancelBtn addTarget:self action:@selector(videoViewCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    if (client.forSharing) {
        scrShareVideoView = remoteVideoView;
        scrShareVideoView.videoTrack = remoteVideoTrack;
        [scrShareVideoView.videoTrack addRenderer:remoteVideoView];
        [scrShareVideoView hideControls:YES];
        [self.blackView addSubview:scrShareVideoView];
        [_screenShareControl setSelected:YES];
    }else{
        remoteVideoView.videoTrack = remoteVideoTrack;
        [remoteVideoView.videoTrack addRenderer:remoteVideoView];
        [self.blackView addSubview:remoteVideoView];
        [multCallArr addObject:remoteVideoView];
    }
//    [_controlsContainer setHidden:NO];
    [_groupChatBtn setHidden:NO];

}

- (void)appClient:(PYARDAppClient *)client didError:(NSError *)error {
    [self showAlertWithMessage:[NSString stringWithFormat:@"%@", error]];
    [self disconnect:client.clientId];
    [ringtonePlayer stop];
}

#pragma mark - RTCEAGLVideoViewDelegate

- (void)videoViewCancelButtonAction:(id)sender{
    UIButton* btn = (UIButton*)sender;
    PYRTCEAGLVideoView* superView = (PYRTCEAGLVideoView*)btn.superview;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[SavePrefrences sharedInstance].uid forKey:@"uid"];
    [params setObject:superView.clientId forKey:@"fruid"];
    [[SavePrefrences sharedInstance].skthand emitData:@"Chat" :@"ce" :@"" :@"" :params :self ];
    [self disconnect:superView.clientId];
}

- (void)videoViewMuteButtonAction:(id)sender{
    NSLog(@"videoViewMuteButtonAction");
}

- (void)videoView:(RTCEAGLVideoView*)videoView
didChangeVideoSize:(CGSize)size {
    if (videoView == self.localVideoView) {
        _localVideoSize = size;
    } else if ([multCallArr containsObject:videoView] || (videoView == scrShareVideoView)) {
        _remoteVideoSize = size;
    } else {
        NSParameterAssert(NO);
    }
    [self updateVideoViewLayout];
}

#pragma mark --
@end
