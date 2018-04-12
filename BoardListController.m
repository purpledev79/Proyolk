//
//  BoardListController.m
//  Proyolk
//
//  Created by Shiv ram on 20/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import "BoardListController.h"
#import "ManageArray.h"
#import "UIImageView+WebCache.h"
#import "BoardPopUp.h"

@interface BoardListController (){
    BoardPopUp *bpop;
}

@end

@implementation BoardListController

- (void)viewDidLoad {
    [super viewDidLoad];
    bpop=[[BoardPopUp alloc]init];
    // Do any additional setup after loading the view.
    UIView *selectionView = [UIView new];
    selectionView.backgroundColor = [UIColor clearColor];
    [[UITableViewCell appearance] setSelectedBackgroundView:selectionView];
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
    return _boardArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* aBoard = _boardArr[indexPath.row];

    UITableViewCell* cell;
    if([aBoard[@"cmnt_contentCheck"] boolValue]) {
        NSString* cellIdentifier = @"BOARD_DETAIL_CELL";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UILabel* titleLbl = (UILabel*)[cell viewWithTag:3];
        [titleLbl setText:aBoard[@"title"]];
        
        UILabel* dateLbl = (UILabel*)[cell viewWithTag:4];
        [dateLbl setText:aBoard[@"timelog"]];
        
        NSString *img = aBoard[@"img"];
        ManageArray* mang=[[ManageArray alloc]init];
        NSString* imgUrl = [mang concatUrl:img];
        UIImageView* profileImg = (UIImageView*)[cell viewWithTag:5];
        [profileImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        
        UILabel* profileName = (UILabel*)[cell viewWithTag:6];
        [profileName setText:aBoard[@"uname"]];
        
        UILabel* commentLbl = (UILabel*)[cell viewWithTag:7];
        
        NSString *clearStr = [self clearString:aBoard[@"cmnt_content"]];

        NSLog(@"CLEAN STING *** %@", clearStr);
        [commentLbl setText:clearStr];
    }else{
        NSString* cellIdentifier = @"BOARD_CELL";
        cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        UILabel* titleLbl = (UILabel*)[cell viewWithTag:3];
        [titleLbl setText:aBoard[@"title"]];
    }

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
    NSDictionary* aBoard = _boardArr[indexPath.row];
    int brdId = [aBoard[@"b_id"] intValue];
    [bpop showcommentView :self :brdId:0:0];
}

#pragma mark --

-(void) callMethod:(NSArray *)meta{
}
@end
