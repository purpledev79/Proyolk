//
//  Tvc.m
//  Proyolk
//
//  Created by iFlame on 10/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "Tvc.h"
#import "Interview.h"
@implementation Tvc

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnCancelAction:(id)sender{
    [self.delegate didPressCancel:self];
}
-(IBAction)btnProfileAction:(id)sender{
    [self.delegate didPressProfile:self];
}
-(IBAction)btnViewAction:(id)sender{
    [self.delegate didPressDetail:self];
}

@end
