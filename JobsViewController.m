//
//  JobsViewController.m
//  Proyolk
//
//  Created by iFlame on 10/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "JobsViewController.h"
#import "RecruitmentCell.h"
static NSString *SectionHeaderViewIdentifier    = @"SectionHeaderViewIdentifier";
static NSString *DemoTableViewIdentifier        = @"DemoTableViewIdentifier";
@interface JobsViewController (){
    NSMutableArray *arrSection;
}
@property (weak, nonatomic) IBOutlet FTFoldingTableView *ft_tableView;
@property (nonatomic, assign)FTFoldingSectionHeaderArrowPosition arrowPosition;

@end

@implementation JobsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrowPosition = FTFoldingSectionHeaderArrowPositionRight;
    arrSection = [NSMutableArray arrayWithObjects:@"Need iOS Developer",@"Need Android Developer",@"Need Node developer", nil];
    self.ft_tableView.foldingDelegate = self;
    [self.ft_tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnInterview:(id)sender
{
  //  self.view1.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)btnSummaries:(id)sender
{
    //self.view2.backgroundColor = [UIColor lightGrayColor];
}

- (FTFoldingSectionHeaderArrowPosition)perferedArrowPositionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return self.arrowPosition;
}
- (NSInteger )numberOfSectionForFTFoldingTableView:(FTFoldingTableView *)ftTableView
{
    return 3;
}
- (NSInteger )ftFoldingTableView:(FTFoldingTableView *)ftTableView numberOfRowsInSection:(NSInteger )section
{
    return 2;
}
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )ftFoldingTableView:(FTFoldingTableView *)ftTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (UIColor *)ftFoldingTableView:(FTFoldingTableView *)ftTableView backgroundColorForHeaderInSection:(NSInteger )section{
    return [UIColor whiteColor];
}
- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@",[arrSection objectAtIndex:section]];
}
- (UITableViewCell *)ftFoldingTableView:(FTFoldingTableView *)ftTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecruitmentCell *cell = [ftTableView dequeueReusableCellWithIdentifier:@"RecruitmentCell" forIndexPath:indexPath];
    return cell;

}
- (void )ftFoldingTableView:(FTFoldingTableView *)ftTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ftTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - FTFoldingTableViewDelegate / optional delegates, change almost everything using delegate

- (NSString *)ftFoldingTableView:(FTFoldingTableView *)ftTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"";
}


@end
