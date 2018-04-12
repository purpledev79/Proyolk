//
//  PYARDAppClient.h
//  Proyolk
//
//  Created by Rashmikant Makwana on 12/28/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RTCVideoTrack.h"
#import "ARDWebSocketChannel.h"
#import "RTCICECandidate+JSON.h"
#import "RTCICEServer+JSON.h"
#import "RTCMediaConstraints.h"
#import "RTCMediaStream.h"
#import "RTCPair.h"
#import "RTCPeerConnection.h"
#import "RTCPeerConnectionDelegate.h"
#import "RTCPeerConnectionFactory.h"
#import "RTCSessionDescription+JSON.h"
#import "RTCSessionDescriptionDelegate.h"
#import "RTCVideoCapturer.h"

typedef NS_ENUM(NSInteger, PYARDAppClientState) {
    // Disconnected from servers.
    kPYARDAppClientStateDisconnected,
    // Connecting to servers.
    kPYARDAppClientStateConnecting,
    // Connected to servers.
    kPYARDAppClientStateConnected,
};

@class PYARDAppClient;
@protocol PYARDAppClientDelegate <NSObject>

- (void)appClient:(PYARDAppClient *)client didChangeState:(PYARDAppClientState)state;

- (void)appClient:(PYARDAppClient *)client didReceiveLocalVideoTrack:(RTCVideoTrack *)localVideoTrack;

- (void)appClient:(PYARDAppClient *)client didReceiveRemoteVideoTrack:(RTCVideoTrack *)remoteVideoTrack;

- (void)appClient:(PYARDAppClient *)client didError:(NSError *)error;

- (void)appClient:(PYARDAppClient *)client didReceiveCandidate:(RTCICECandidate*)candidate;

- (void)appClient:(PYARDAppClient *)client didSetLocalDesc:(RTCSessionDescription*)description;

- (void)appClient:(PYARDAppClient *)client didSetRemoteDesc:(RTCSessionDescription*)description;

- (void)appClient:(PYARDAppClient *)client didCompleteICEGathering:(RTCSessionDescription*)description;

@end

// Handles connections to the AppRTC server for a given room.
@interface PYARDAppClient : NSObject

@property BOOL hasAudio;
@property BOOL hasCamera;
@property BOOL forSharing;
@property(nonatomic, assign) BOOL isInitiator;
@property(nonatomic, strong) RTCMediaStream* localClientStream;
@property(nonatomic, strong) ARDWebSocketChannel *channel;
@property(nonatomic, strong) RTCPeerConnection *peerConnection;
@property(nonatomic, strong) RTCPeerConnectionFactory *factory;
@property(nonatomic, strong) NSString *clientId;

@property(nonatomic, readonly) PYARDAppClientState state;
@property(nonatomic, weak) id<PYARDAppClientDelegate> delegate;
@property(nonatomic, strong) NSString *serverHostUrl;

- (instancetype)initWithDelegate:(id<PYARDAppClientDelegate>)delegate;

// Establishes a connection with the AppRTC servers for the given room id.
// TODO(tkchin): provide available keys/values for options. This will be used
// for call configurations such as overriding server choice, specifying codecs
// and so on.
- (void)connectToRoomWithId:(NSString *)roomId
                    options:(NSDictionary *)options;


- (void)connectWithPeer:(BOOL)isIncoming;
- (void)acceptIncomingOffer:(NSString*)sdp;
- (void)acceptIncomingAnswer:(NSString*)sdp;
- (void)acceptIncomingCandidate:(NSDictionary*)candidate;

// Disconnects from the AppRTC servers and any connected clients.
- (void)disconnect;

@end

