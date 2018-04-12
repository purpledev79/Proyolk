//
//  JobsViewController.h
//  Proyolk
//
//  Created by iFlame on 10/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTFoldingTableView.h"
@interface JobsViewController : UIViewController<FTFoldingSectionHeaderDelegate,FTFoldingTableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
- (IBAction)btnInterview:(id)sender;
- (IBAction)btnSummaries:(id)sender;

@end
