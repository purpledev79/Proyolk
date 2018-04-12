//
//  VideoChatController.h
//  Proyolk
//
//  Created by iFlame on 09/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllValidationsViewController.h"
#import "LeftRightDrawer.h"
#import "SavePrefrences.h"
#import "openChat.h"
#import "MainController.h"
#import "ManageArray.h"
#import <HMSegmentedControl.h>
#import "PjsCallBack.h"
#import "CallTo Parent.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

#import "PYARDAppClient.h"
#import <RTCICEServer.h>
#import "RTCPair.h"
#import "RTCPeerConnection.h"
#import "RTCPeerConnectionFactory.h"
#import "RTCPeerConnectionDelegate.h"
#import "RTCSessionDescriptionDelegate.h"
#import "RTCMediaConstraints.h"
#import "RTCVideoCapturer.h"
#import "RTCMediaStream.h"
#import "RTCEAGLVideoView.h"
#import "PYRTCEAGLVideoView.h"


@interface VideoChatController : UIViewController<PjsCallBack, CallTo_Parent, RTCPeerConnectionDelegate, RTCSessionDescriptionDelegate, RTCEAGLVideoViewDelegate, PYARDAppClientDelegate>{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView *main,*cell_View;
    AllValidationsViewController *allValidVC;
    //LeftRightDrawer *drawer;
    MainController *vc1;
    openChat *opop;
    NSMutableDictionary * frChatAr;
    int iscallback;
    NSArray * keyAr;
    ManageArray * mngAr;
    NSArray *Frnd_chat;
    int cnt;
    
    BOOL isIncoming;
    
    RTCVideoTrack* _localVideoTrack;
//    RTCVideoTrack* _remoteVideoTrack1;
//    RTCVideoTrack* _remoteVideoTrack2;
//    RTCVideoTrack* _remoteVideoTrack3;
//    RTCVideoTrack* _remoteVideoTrack4;
    
    CGSize _localVideoSize;
    CGSize _remoteVideoSize;
    
    CGRect videoViewSize;
    UIView* _blackView;
    
    NSMutableDictionary *callsOnline;
    NSMutableDictionary *multCallDict;
    NSString* tempUserId;
    NSMutableArray *multCallArr;
    BOOL scrSharOngoing;
    NSDictionary* scrShareClient;
    PYRTCEAGLVideoView* scrShareVideoView;
    UIView* screenShareContainer;
    BOOL cleanedUp;
    NSMutableArray* confCallArr;
    BOOL isConference;
    
    BOOL alreadyLoaded;
    BOOL isShowingChat;
    NSMutableArray* disconnectedClients;
}

@property(strong, nonatomic)NSString* incomingCall;
@property(strong, nonatomic)NSString* outgoingCall;
@property(strong, nonatomic)NSString* acceptedCall;
@property(strong, nonatomic) NSArray* confUsers;

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentControl;
@property (strong, nonatomic) RTCMediaStream* rtcMediaStream;
@property(nonatomic, strong) RTCEAGLVideoView* localVideoView;
@property(nonatomic, strong) PYRTCEAGLVideoView* remoteVideoView;
//@property(nonatomic, strong) RTCEAGLVideoView* remoteVideoView2;
//@property(nonatomic, strong) RTCEAGLVideoView* remoteVideoView3;
//@property(nonatomic, strong) RTCEAGLVideoView* remoteVideoView4;


// Video Tab
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIView *connectCallView;
@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ic_contactImageView;
@property (strong, nonatomic) IBOutlet UILabel *contactNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *ic_contactNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *muteBtnIcon;
@property (weak, nonatomic) IBOutlet UILabel *muteBtnLabel;
@property (weak, nonatomic) IBOutlet UIImageView *speakerBtnIcon;
@property (weak, nonatomic) IBOutlet UILabel *speakerBtnLbl;
@property (weak, nonatomic) IBOutlet UIImageView *cancelBtnIcon;
@property (weak, nonatomic) IBOutlet UILabel *cancelBtnLbl;
@property (weak, nonatomic) IBOutlet UIView *incomingCallView;
@property (strong, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *controlsContainer;
@property (weak, nonatomic) IBOutlet UIButton *muteControl;
@property (weak, nonatomic) IBOutlet UIButton *speakerControl;
@property (weak, nonatomic) IBOutlet UIButton *fullscreenControl;
@property (strong, nonatomic) IBOutlet UIButton *screenShareControl;
@property (weak, nonatomic) IBOutlet UIButton *endCallControl;
@property (strong, nonatomic) IBOutlet UIView *fullscreenView;

// Conference Tab
@property (strong, nonatomic) IBOutlet UIView *Conference;

@property (strong, nonatomic) IBOutlet UIButton *groupChatBtn;


@end
