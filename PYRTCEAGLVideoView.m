//
//  PYRTCEAGLVideoView.m
//  Proyolk
//
//  Created by Shiv ram on 11/01/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "PYRTCEAGLVideoView.h"

@implementation PYRTCEAGLVideoView

- (id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (!self)
        return nil;
    
    [self commonInit];
    
    return self;
    
}

- (void) commonInit{
    _muteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_muteBtn setBackgroundImage:[UIImage imageNamed:@"mute-small"] forState: UIControlStateNormal];
    [_muteBtn setBackgroundImage:[UIImage imageNamed:@"unmute-small"] forState: UIControlStateSelected];
    [_muteBtn setTitle:@"" forState:UIControlStateNormal];
    _muteBtn.frame = CGRectMake(80.0, 210.0, 30.0, 30.0);
    [self addSubview:_muteBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"call-end"] forState: UIControlStateNormal];
    [_cancelBtn setTitle:@"" forState:UIControlStateNormal];
    _cancelBtn.frame = CGRectMake(80.0, 210.0, 30.0, 30.0);
    [self addSubview:_cancelBtn];
    
    [_muteBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_cancelBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self resetConstraints];
}

- (void)hideControls:(BOOL)hidden{
    [_muteBtn setHidden:hidden];
    [_cancelBtn setHidden:hidden];
}

- (void)resetConstraints{
    [self removeConstraints:self.constraints];
    float padFloat = (self.frame.size.width-90)/2;
    NSNumber *padding = [NSNumber numberWithFloat:padFloat];
    NSDictionary *views = NSDictionaryOfVariableBindings(_muteBtn, _cancelBtn);
    
    NSArray *horizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[_muteBtn(44)]-30@750-[_cancelBtn(44)]-padding-|" options:0 metrics:@{@"padding":padding} views:views];
    NSArray *verticalConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=50)-[_muteBtn(44)]-5-|" options:0 metrics:nil views:views];
    NSArray *verticalConstraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=50)-[_cancelBtn(44)]-5-|" options:0 metrics:nil views:views];
//    NSArray *verticalConstraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_muteBtn(44)]-5-|" options:0 metrics:nil views:views];
    
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints1];
    [self addConstraints:verticalConstraints2];
//    [self addConstraints:verticalConstraints3];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (IBAction)cancelCallAction:(id)sender {
//    NSLog(@"CANCEL VIDEO CALL");
//}
//
//- (IBAction)muteButtonAction:(id)sender {
//    NSLog(@"MUTE VIDEO CALL");
//}
@end
