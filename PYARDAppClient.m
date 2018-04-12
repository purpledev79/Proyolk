//
//  PYARDAppClient.m
//  Proyolk
//
//  Created by Rashmikant Makwana on 12/28/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "PYARDAppClient.h"

#import <AVFoundation/AVFoundation.h>

#import "ARDMessageResponse.h"
#import "ARDRegisterResponse.h"
#import "ARDSignalingMessage.h"
#import "ARDUtilities.h"



#define STUN_SERVER_1 @"stun:butikka.com:3479"
#define STUN_SERVER_2 @"stun:proyolk.com:3479"
#define TURN_SERVER_1 @"turn:butikka.com:3478"
#define TURN_SERVER_2 @"turn:proyolk.com:3478"
#define ICE_SERVER_USERNAME @"test"
#define ICE_SERVER_PASSWORD @"1234"


// TODO(tkchin): move these to a configuration object.
static NSString *kARDRoomServerHostUrl =
@"https://apprtc.appspot.com";
static NSString *kARDRoomServerRegisterFormat =
@"%@/join/%@";
static NSString *kARDRoomServerMessageFormat =
@"%@/message/%@/%@";
static NSString *kARDRoomServerByeFormat =
@"%@/leave/%@/%@";

static NSString *kARDDefaultSTUNServerUrl =
@"stun:stun.l.google.com:19302";
// TODO(tkchin): figure out a better username for CEOD statistics.
static NSString *kARDTurnRequestUrl =
@"https://computeengineondemand.appspot.com"
@"/turn?username=iapprtc&key=4080218913";

static NSString *kPYARDAppClientErrorDomain = @"PYARDAppClient";
static NSInteger kPYARDAppClientErrorUnknown = -1;
static NSInteger kPYARDAppClientErrorRoomFull = -2;
static NSInteger kPYARDAppClientErrorCreateSDP = -3;
static NSInteger kPYARDAppClientErrorSetSDP = -4;
static NSInteger kPYARDAppClientErrorNetwork = -5;
static NSInteger kPYARDAppClientErrorInvalidClient = -6;
static NSInteger kPYARDAppClientErrorInvalidRoom = -7;

@interface PYARDAppClient () <ARDWebSocketChannelDelegate,
RTCPeerConnectionDelegate, RTCSessionDescriptionDelegate>
@property(nonatomic, strong) NSMutableArray *messageQueue;

@property(nonatomic, assign) BOOL isTurnComplete;
@property(nonatomic, assign) BOOL hasReceivedSdp;
@property(nonatomic, readonly) BOOL isRegisteredWithRoomServer;

@property(nonatomic, strong) NSString *roomId;
@property(nonatomic, strong) NSMutableArray *iceServers;
@property(nonatomic, strong) NSURL *webSocketURL;
@property(nonatomic, strong) NSURL *webSocketRestURL;
@end

@implementation PYARDAppClient

@synthesize delegate = _delegate;
@synthesize state = _state;
@synthesize serverHostUrl = _serverHostUrl;
@synthesize channel = _channel;
@synthesize peerConnection = _peerConnection;
@synthesize factory = _factory;
@synthesize messageQueue = _messageQueue;
@synthesize isTurnComplete = _isTurnComplete;
@synthesize hasReceivedSdp  = _hasReceivedSdp;
@synthesize roomId = _roomId;
@synthesize clientId = _clientId;
@synthesize isInitiator = _isInitiator;
@synthesize iceServers = _iceServers;
@synthesize webSocketURL = _websocketURL;
@synthesize webSocketRestURL = _websocketRestURL;

- (instancetype)initWithDelegate:(id<PYARDAppClientDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        _factory = [[RTCPeerConnectionFactory alloc] init];
        _messageQueue = [NSMutableArray array];
        
        RTCICEServer *iceServer1 = [[RTCICEServer alloc] initWithURI:[NSURL URLWithString:STUN_SERVER_1]
                                                            username:ICE_SERVER_USERNAME
                                                            password:ICE_SERVER_PASSWORD];
        RTCICEServer *iceServer2 = [[RTCICEServer alloc] initWithURI:[NSURL URLWithString:STUN_SERVER_2]
                                                            username:ICE_SERVER_USERNAME
                                                            password:ICE_SERVER_PASSWORD];
        RTCICEServer *iceServer3 = [[RTCICEServer alloc] initWithURI:[NSURL URLWithString:TURN_SERVER_1]
                                                            username:ICE_SERVER_USERNAME
                                                            password:ICE_SERVER_PASSWORD];
        RTCICEServer *iceServer4 = [[RTCICEServer alloc] initWithURI:[NSURL URLWithString:TURN_SERVER_2]
                                                            username:ICE_SERVER_USERNAME
                                                            password:ICE_SERVER_PASSWORD];
        
        
        _iceServers = [NSMutableArray arrayWithObjects:iceServer1, iceServer2, iceServer3, iceServer4, nil];
        _serverHostUrl = kARDRoomServerHostUrl;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged:)
                                                     name:@"UIDeviceOrientationDidChangeNotification"
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [self disconnect];
}

- (void)orientationChanged:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(orientation) || UIDeviceOrientationIsPortrait(orientation)) {
        //Remove current video track
        RTCMediaStream *localStream = _peerConnection.localStreams[0];
        if (localStream.videoTracks.count) [localStream removeVideoTrack:localStream.videoTracks[0]];
        
        RTCVideoTrack *localVideoTrack = [self createLocalVideoTrack];
        if (localVideoTrack) {
            [localStream addVideoTrack:localVideoTrack];
            [_delegate appClient:self didReceiveLocalVideoTrack:localVideoTrack];
        }
        [_peerConnection removeStream:localStream];
        [_peerConnection addStream:localStream];
    }
}


- (void)setState:(PYARDAppClientState)state {
    if (_state == state) {
        return;
    }
    _state = state;
    [_delegate appClient:self didChangeState:_state];
}

- (void)connectWithPeer:(BOOL)isIncoming{
    NSParameterAssert(_state == kPYARDAppClientStateDisconnected);
    self.state = kPYARDAppClientStateConnecting;
    _isInitiator = !isIncoming;
    [self startSignalingIfReady];
}

- (void)acceptIncomingOffer:(NSString*)sdp{
//    _hasReceivedSdp = YES;
    if (!_isInitiator) {
        RTCSessionDescription *remoteDesc = [[RTCSessionDescription alloc] initWithType:@"offer" sdp:sdp];
        [_peerConnection setRemoteDescriptionWithDelegate:self sessionDescription:remoteDesc];
    }
}

- (void)acceptIncomingAnswer:(NSString*)sdp{
    if (_isInitiator) {
        _hasReceivedSdp = YES;
        RTCSessionDescription *remoteDesc = [[RTCSessionDescription alloc] initWithType:@"answer" sdp:sdp];
        [_peerConnection setRemoteDescriptionWithDelegate:self sessionDescription:remoteDesc];
    }
}


- (void)disconnect {
    if (!_clientId) return;
    NSLog(@"DISCONNECTING %@, %d", _clientId, _forSharing);
    if (_state == kPYARDAppClientStateDisconnected) {
        return;
    }
    if (self.isRegisteredWithRoomServer) {
        
    }
    if (_channel) {
        if (_channel.state == kARDWebSocketChannelStateRegistered) {
            // Tell the other client we're hanging up.
        }
        // Disconnect from collider.
        _channel = nil;
    }
    _clientId = nil;
    _roomId = nil;
    _isInitiator = NO;
    _hasReceivedSdp = NO;
    _messageQueue = [NSMutableArray array];
    _peerConnection = nil;
    self.state = kPYARDAppClientStateDisconnected;
}

#pragma mark - RTCPeerConnectionDelegate

- (void)peerConnection:(RTCPeerConnection *)peerConnection
 signalingStateChanged:(RTCSignalingState)stateChanged {
    NSLog(@"PYARDAppClientLog *** Signaling state changed: %u", stateChanged);
}

- (void)peerConnection:(RTCPeerConnection *)peerConnection
           addedStream:(RTCMediaStream *)stream {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"PYARDAppClientLog ***  Received %lu video tracks and %lu audio tracks",
              (unsigned long)stream.videoTracks.count,
              (unsigned long)stream.audioTracks.count);
        if (stream.videoTracks.count) {
            RTCVideoTrack *videoTrack = stream.videoTracks[0];
            [_delegate appClient:self didReceiveRemoteVideoTrack:videoTrack];
        }
    });
}

- (void)peerConnection:(RTCPeerConnection *)peerConnection
         removedStream:(RTCMediaStream *)stream {
    NSLog(@"PYARDAppClientLog ***  Stream was removed.");
}

- (void)peerConnectionOnRenegotiationNeeded:(RTCPeerConnection *)peerConnection {
    NSLog(@"PYARDAppClientLog ***  WARNING: Renegotiation needed but unimplemented.");
//    RTCMediaStream *localStream = [self createLocalMediaStream];
//    [_peerConnection addStream:localStream];
//    //    if (_isInitiator) {
//    [self sendOffer];
}

- (void)peerConnection:(RTCPeerConnection *)peerConnection
  iceConnectionChanged:(RTCICEConnectionState)newState {
    
    switch (newState) {
        case RTCICEConnectionNew:
            NSLog(@"peerConnectioniceConnectionChanged *** %@ **** RTCICEConnectionNew", _clientId);
            break;
        case RTCICEConnectionChecking:
            NSLog(@"peerConnectioniceConnectionChanged **** %@ **** RTCICEConnectionChecking", _clientId);
            break;
        case RTCICEConnectionConnected:
            NSLog(@"peerConnectioniceConnectionChanged **** %@ **** RTCICEConnectionConnected", _clientId);
            break;
        case RTCICEConnectionCompleted:
            NSLog(@"peerConnectioniceConnectionChanged **** %@ **** RTCICEConnectionCompleted", _clientId);
            break;
        case RTCICEConnectionFailed:
            NSLog(@"peerConnectioniceConnectionChanged **** %@ **** RTCICEConnectionFailed", _clientId);
            break;
        case RTCICEConnectionDisconnected:
            NSLog(@"peerConnectioniceConnectionChanged **** %@ **** RTCICEConnectionDisconnected", _clientId);
            break;
        case RTCICEConnectionClosed:
            NSLog(@"peerConnectioniceConnectionChanged **** %@ **** RTCICEConnectionClosed", _clientId);
            break;
        case RTCICEConnectionMax:
            NSLog(@"peerConnectioniceConnectionChanged **** %@ **** RTCICEConnectionMax", _clientId);
            break;
            
        default:
            NSLog(@"PYARDAppClientLog *** ICE state changed: %d", newState);
            break;
    }
    
}

- (void)peerConnection:(RTCPeerConnection *)peerConnection
   iceGatheringChanged:(RTCICEGatheringState)newState {
    if (newState == RTCICEGatheringComplete) {
        NSLog(@"PYARDAppClientLog *** ICE gathering state changed: Gathered");
        [_delegate appClient:self didCompleteICEGathering:peerConnection.localDescription];
    }
}

- (void)peerConnection:(RTCPeerConnection *)peerConnection
       gotICECandidate:(RTCICECandidate *)candidate {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"PYARDAppClientLog *** gotICECandidate");
        [self.delegate appClient:self didReceiveCandidate:candidate];
//        [_peerConnection addICECandidate:candidate];
    });
}

- (void)peerConnection:(RTCPeerConnection*)peerConnection
    didOpenDataChannel:(RTCDataChannel*)dataChannel {
    NSLog(@"PYARDAppClientLog ***** didOpenDataChannel");
}

#pragma mark - RTCSessionDescriptionDelegate

- (void)peerConnection:(RTCPeerConnection *)peerConnection
didCreateSessionDescription:(RTCSessionDescription *)sdp
                 error:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            NSLog(@"PYARDAppClientLog ***  Failed to create session description. Error: %@", error);
            [self disconnect];
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: @"Failed to create session description.",
                                       };
            NSError *sdpError =
            [[NSError alloc] initWithDomain:kPYARDAppClientErrorDomain
                                       code:kPYARDAppClientErrorCreateSDP
                                   userInfo:userInfo];
            [_delegate appClient:self didError:sdpError];
            return;
        }
        
        if (!_isInitiator) {
            NSLog(@"Signaling state changed ***** CREATE SESION DESC INCOMING *** %d *** %@", _peerConnection.signalingState, _clientId);
            [_peerConnection setLocalDescriptionWithDelegate:self sessionDescription:sdp];
        }else{
            NSLog(@"Signaling state changed ***** CREATE SESION DESC *** %d *** %@", _peerConnection.signalingState, _clientId);
            [_peerConnection setLocalDescriptionWithDelegate:self sessionDescription:sdp];
        }
    });
}

- (void)peerConnection:(RTCPeerConnection *)peerConnection
didSetSessionDescriptionWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            NSLog(@"PYARDAppClientLog *** Failed to set session description. Error: %@", error);
            [self disconnect];
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: @"Failed to set session description.",
                                       };
            NSError *sdpError =
            [[NSError alloc] initWithDomain:kPYARDAppClientErrorDomain
                                       code:kPYARDAppClientErrorSetSDP
                                   userInfo:userInfo];
            [_delegate appClient:self didError:sdpError];
            return;
        }
        // If we're answering and we've just set the remote offer we need to create
        // an answer and set the local description.
        
        if (!_isInitiator) {
            if (peerConnection.signalingState == RTCSignalingHaveRemoteOffer) {
                // If we have a remote offer we should add it to the peer connection
                NSLog(@"PYARDAppClientLog *** I HAVE *** REMOTE *** OFFER");
                [_peerConnection createAnswerWithDelegate:self constraints:[self defaultAnswerConstraints]];
            }else if (_peerConnection.signalingState == RTCSignalingHaveLocalPrAnswer && !_peerConnection.localDescription){
                NSLog(@"PYARDAppClientLog *** I HAVE *** LOCALL *** ANSWER");
                RTCMediaConstraints *constraints = [self defaultAnswerConstraints];
                [_peerConnection createAnswerWithDelegate:self constraints:constraints];
            }else{
                [_delegate appClient:self didSetLocalDesc:nil];
            }
            
        }else if (_isInitiator){
            if ((_peerConnection.signalingState == RTCSignalingHaveLocalOffer) || (_peerConnection.signalingState == RTCSignalingHaveLocalPrAnswer)) {
                NSLog(@"PYARDAppClientLog *** I HAVE LOCAL OFFER / ANSWER");
                [_delegate appClient:self didSetLocalDesc:nil];
                // Send offer/answer through the signaling channel of our application
            } else if (peerConnection.signalingState == RTCSignalingHaveRemoteOffer) {
                // If we have a remote offer we should add it to the peer connection
                NSLog(@"PYARDAppClientLog *** I HAVE *** REMOTE *** OFFER");
                [_peerConnection createAnswerWithDelegate:self constraints:[self defaultAnswerConstraints]];
            }
        }
        NSLog(@"Signaling state changed ***** SET SESION DESC *** %d", _peerConnection.signalingState);
        
        
    });
}

#pragma mark - Private


- (void)acceptIncomingCandidate:(NSDictionary *)candidate{
    if ([candidate[@"candidate"] isKindOfClass:[NSDictionary class]]) {
        NSString* index = [NSString stringWithFormat:@"%@", candidate[@"sdpMLineIndex"]];
        RTCICECandidate *iceCandidate = [[RTCICECandidate alloc] initWithMid:candidate[@"sdpMid"]
                                                                       index:[index integerValue]
                                                                         sdp:candidate[@"candidate"][@"sdp"]];
        [_peerConnection addICECandidate:iceCandidate];
    }else{
        NSString* index = [NSString stringWithFormat:@"%@", candidate[@"sdpMLineIndex"]];
        RTCICECandidate *iceCandidate = [[RTCICECandidate alloc] initWithMid:candidate[@"sdpMid"]
                                                                       index:[index integerValue]
                                                                         sdp:candidate[@"candidate"]];
        [_peerConnection addICECandidate:iceCandidate];
    }
}

- (void)startSignalingIfReady {
    self.state = kPYARDAppClientStateConnected;
    
    // Create peer connection.
    RTCMediaConstraints *constraints = [self defaultPeerConnectionConstraints];
    _peerConnection = [_factory peerConnectionWithICEServers:_iceServers
                                                 constraints:constraints
                                                    delegate:self];
    if (!_localClientStream) {
        _localClientStream = [self createLocalMediaStream];
    }
    if (!_forSharing) [_peerConnection addStream:_localClientStream];
    if (_isInitiator) {
        [self sendOffer];
    } else {
        [self waitForAnswer];
    }
}

- (void)sendOffer {
    [_peerConnection createOfferWithDelegate:self constraints:[self defaultOfferConstraints]];
}

- (void)waitForAnswer {
    
//    [self drainMessageQueueIfReady];
}


- (RTCVideoTrack *)createLocalVideoTrack {
    // The iOS simulator doesn't provide any sort of camera capture
    // support or emulation (http://goo.gl/rHAnC1) so don't bother
    // trying to open a local stream.
    // TODO(tkchin): local video capture for OSX. See
    // https://code.google.com/p/webrtc/issues/detail?id=3417.
    
    RTCVideoTrack *localVideoTrack = nil;
    if (_forSharing) return localVideoTrack;
#if !TARGET_IPHONE_SIMULATOR && TARGET_OS_IPHONE
    
    NSString *cameraID = nil;
    for (AVCaptureDevice *captureDevice in
         [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if (captureDevice.position == AVCaptureDevicePositionFront) {
            cameraID = [captureDevice localizedName];
            break;
        }
    }
    NSAssert(cameraID, @"Unable to get the front camera id");
    
    RTCVideoCapturer *capturer = [RTCVideoCapturer capturerWithDeviceName:cameraID];
    RTCMediaConstraints *mediaConstraints = [self defaultMediaStreamConstraints];
    RTCVideoSource *videoSource = [_factory videoSourceWithCapturer:capturer constraints:mediaConstraints];
    localVideoTrack = [_factory videoTrackWithID:@"ARDAMSv0" source:videoSource];
#endif
    return localVideoTrack;
}

- (RTCMediaStream *)createLocalMediaStream {
    RTCMediaStream* localStream = [_factory mediaStreamWithLabel:@"ARDAMS"];
    
    RTCVideoTrack *localVideoTrack = [self createLocalVideoTrack];
    if (localVideoTrack) {
        [localStream addVideoTrack:localVideoTrack];
        [_delegate appClient:self didReceiveLocalVideoTrack:localVideoTrack];
    }
    
    [localStream addAudioTrack:[_factory audioTrackWithID:@"ARDAMSa0"]];
    return localStream;
}

#pragma mark - Defaults

- (RTCMediaConstraints *)defaultMediaStreamConstraints {
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:nil
     optionalConstraints:nil];
    return constraints;
}

- (RTCMediaConstraints *)defaultAnswerConstraints {
    return [self defaultOfferConstraints];
}

- (RTCMediaConstraints *)defaultOfferConstraints {
    NSArray *mandatoryConstraints;
    if (_forSharing) {
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                 ];
    }else if (_hasAudio && _hasCamera) {
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                 ];
    }else if (_hasCamera){
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                 ];
    }else if (_hasAudio){
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"]
                                 ];
    }
    
    RTCMediaConstraints* constraints =
    [[RTCMediaConstraints alloc]
     initWithMandatoryConstraints:mandatoryConstraints
     optionalConstraints:nil];
    return constraints;
}

- (RTCMediaConstraints *)defaultPeerConnectionConstraints {
    NSArray *mandatoryConstraints;
    if (_forSharing) {
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                 ];
    }else if (_hasAudio && _hasCamera) {
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"],
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                 ];
    }else if (_hasCamera){
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveVideo" value:@"true"]
                                 ];
    }else if (_hasAudio){
        mandatoryConstraints = @[
                                 [[RTCPair alloc] initWithKey:@"OfferToReceiveAudio" value:@"true"]
                                 ];
    }
    
    RTCMediaConstraints* constraints = [[RTCMediaConstraints alloc] initWithMandatoryConstraints:mandatoryConstraints optionalConstraints:nil];
    return constraints;
}

- (RTCICEServer *)defaultSTUNServer {
    NSURL *defaultSTUNServerURL = [NSURL URLWithString:kARDDefaultSTUNServerUrl];
    return [[RTCICEServer alloc] initWithURI:defaultSTUNServerURL
                                    username:@""
                                    password:@""];
}

@end

