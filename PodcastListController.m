//
//  PodcastListController.m
//  Proyolk
//
//  Created by Shiv ram on 21/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "PodcastListController.h"
#import "ManageArray.h"
#import "UIImageView+WebCache.h"
#import "PodcastPopUp.h"

@interface PodcastListController (){
    PodcastPopUp *ppop;
}

@end

@implementation PodcastListController

- (void)viewDidLoad {
    [super viewDidLoad];
    ppop = [[PodcastPopUp alloc] init];
    // Do any additional setup after loading the view.
    _podcastTable.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITABLEVIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _podcastsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* aPodcast = _podcastsArr[indexPath.row];
    
    NSString* cellIdentifier = @"PODCAST_CELL";
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *img = aPodcast[@"image"];
    ManageArray* mang=[[ManageArray alloc]init];
    NSString* imgUrl = [mang concatUrl:img];
    UIImageView* profileImg = (UIImageView*)[cell viewWithTag:3];
    [profileImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
    UILabel* titleLbl = (UILabel*)[cell viewWithTag:4];
    [titleLbl setText:aPodcast[@"title"]];
    
    UILabel* subTitleLbl = (UILabel*)[cell viewWithTag:5];
    [subTitleLbl setText:aPodcast[@"description"]];
    
    UILabel* startTimeLbl = (UILabel*)[cell viewWithTag:6];
    [startTimeLbl setText:aPodcast[@"start_time"]];
    
    UILabel* durationLbl = (UILabel*)[cell viewWithTag:7];
    [durationLbl setText:aPodcast[@"duration"]];
    
    UILabel* dateLbl = (UILabel*)[cell viewWithTag:8];
    [dateLbl setText:aPodcast[@"timelog"]];
    
    UILabel* type = (UILabel*)[cell viewWithTag:9];
    if ([aPodcast[@"mode"] intValue] == 1) {
        [type setText:@"Recorded"];
    }else [type setText:@"Live"];
    
    
    return cell;
}

-(NSString *)clearString:(NSString*)str{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* aPodcast = _podcastsArr[indexPath.row];
    NSString *podId = [NSString stringWithFormat:@"%@", aPodcast[@"po_id"]];
    NSString *uid = [NSString stringWithFormat:@"%@", aPodcast[@"u_id"]];
    [ppop openUprcntEvent : self:podId:uid:11];
}

#pragma mark --

-(void) callMethod:(NSArray *)meta{
}
@end
