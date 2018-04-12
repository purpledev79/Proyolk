//
//  ViewController.h
//  faq_Page
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 iFlame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAScrollSegmentControl.h"
#import "FTFoldingTableView.h"
static NSString *SectionHeaderViewIdentifier    = @"SectionHeaderViewIdentifier";
static NSString *DemoTableViewIdentifier        = @"DemoTableViewIdentifier";
@interface FAQViewController : UIViewController<FTFoldingTableViewDelegate,FTFoldingSectionHeaderDelegate>{
    NSMutableArray *arrData;
}
@property(nonatomic) int strSelectedTab;
@property (nonatomic, assign)FTFoldingSectionHeaderArrowPosition arrowPosition;
@property (weak, nonatomic) IBOutlet FTFoldingTableView *ft_tableView;
@property(nonatomic,strong) IBOutlet YAScrollSegmentControl *segmentControl;
@property(nonatomic,strong) IBOutlet UIButton *btn1,*btn2;
@property (strong, nonatomic) IBOutlet UITableView *tblview;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
- (IBAction)btnSearchAction:(id)sender;
-(IBAction)btnselectTab:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *container;

@end

