
//
//  MyLabel.m
//  Proyolk
//
//  Created by Padam on 10/20/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//
#define PADDING 10
#import "MyLabel.h"

@implementation MyLabel
- (void)drawTextInRect:(CGRect)rect {
    
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, PADDING, 0, PADDING))];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    return CGRectInset([self.attributedText boundingRectWithSize:CGSizeMake(999, 999)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                         context:nil], -PADDING, 0);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
