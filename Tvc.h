//
//  Tvc.h
//  Proyolk
//
//  Created by iFlame on 10/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TvcProtocoll <NSObject>

-(void) didPressCancel:(id)obj;
-(void) didPressProfile:(id)obj;
-(void) didPressDetail:(id)obj;
@end
@interface Tvc : UITableViewCell
@property (nonatomic,assign) id<TvcProtocoll> delegate;
@property(nonatomic,strong) IBOutlet UILabel *lblTime;
-(IBAction)btnCancelAction:(id)sender;
-(IBAction)btnProfileAction:(id)sender;
-(IBAction)btnViewAction:(id)sender;
@end
