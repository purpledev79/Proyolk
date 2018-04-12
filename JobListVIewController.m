//
//  JobListVIewControllerViewController.m
//  Proyolk
//
//  Created by Padam on 11/24/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "JobListVIewController.h"
#import "SavePrefrences.h"
#import "JobListTableCell.h"
#import "Jobpopup.h"

@interface JobListVIewController (){
    int iscallback;
    UIView *headerView;
    Jobpopup *jpop;
}
@end

@implementation JobListVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeActionBar];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%d",self.frienduid] forKey:@"id"];
    iscallback=0;
    [[SavePrefrences sharedInstance].skthand  emitData:@"PostedProject" :@"getJobsPosted" :@"" :@"" :dic :self];
    
    jpop=[[Jobpopup alloc]init];
    // Do any additional setup after loading the view.
}

-(void)customizeActionBar{
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    headerView.backgroundColor=[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [self.view addSubview:headerView];
    ////////////
    
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 30, 50, 25)];
    [bckarrow setImage:[UIImage imageNamed:@"back1.png"]];
    bckarrow.userInteractionEnabled=YES;
    bckarrow.backgroundColor=[UIColor clearColor];
    [headerView addSubview:bckarrow];
    
    UITapGestureRecognizer *astreg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmisspop)];
    [astreg setNumberOfTouchesRequired:1];
    [astreg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:astreg];
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake((headerView.frame.size.width-112)/2,25,112, 40)];
    
    // UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150,50)];
    [logo setImage:[UIImage imageNamed:@"logo_new.png"]];
    [headerView addSubview:logo];
    
    //130:197:246
    UILabel *gap=[[UILabel alloc] initWithFrame:CGRectMake(0,68, headerView.frame.size.width, 2)];
    gap.backgroundColor=[UIColor colorWithRed:130.0f/255.0f green:197.0f/255.0f blue:246.0f/255.0f alpha:1.0f];
    [headerView addSubview:gap];
}

-(void)dissmisspop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callBack:(NSArray *)meta :(NSArray *)data{
//    NSLog(@"meta======== %@",meta);
//    NSLog(@"data=========  %@",data);
    if(iscallback==0){
        arrJobs = (NSMutableArray *)data;
        [_jobTable reloadData];
    }
}


#pragma mark UITABLEVIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrJobs.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* cellIdentifier = @"JOB_CELL";
    
    JobListTableCell* cell = (JobListTableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary* job = arrJobs[indexPath.row];
    [cell.jobTitle setText:job[@"title"]];
    [cell.postedDate setText:job[@"timelog"]];
    [cell.statusLbl setText:job[@"status"]];
    [cell.dateLbl setText:job[@"timelog"]];
    [cell.durationLbl setText:job[@"duration"]];
    [cell.postedByLbl setText:job[@"uname"]];
    [cell.jobDescriptionLbl setText:job[@"job_desc"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* job = arrJobs[indexPath.row];
    int jobId = [job[@"job_id"] intValue];
    NSString* uid = [NSString stringWithFormat:@"%@", job[@"u_id"]];
    [jpop OpenJobDetails :self :jobId :uid:4];
}

#pragma mark --

-(void) callMethod:(NSArray *)meta{
}
@end
