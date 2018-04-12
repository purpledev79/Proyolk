//
//  PYRTCEAGLVideoView.h
//  Proyolk
//
//  Created by Shiv ram on 11/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "RTCEAGLVideoView.h"
#import "RTCVideoTrack.h"

@interface PYRTCEAGLVideoView : RTCEAGLVideoView
@property BOOL isPrimary;
@property (strong, nonatomic) NSString* clientId;
@property (strong, nonatomic) RTCVideoTrack* videoTrack;
@property (strong, nonatomic) IBOutlet UIButton *muteBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
- (void)resetConstraints;
- (void)hideControls:(BOOL)hidden;
@end
