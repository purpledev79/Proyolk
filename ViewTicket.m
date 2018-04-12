//
//  ViewTicket.m
//  Proyolk
//
//  Created by Padam on 11/17/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "ViewTicket.h"

@implementation ViewTicket

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnCancelAction:(id)sender {
    [self removeFromSuperview];
}
@end
