//
//  ViewController.m
//  pro12
//
//  Created by iFlame on 12/11/16.
//  Copyright © 2016 iFlame. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeActionBar];
    self.lblTitle.text = self.strTitle;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customizeActionBar
{
    
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
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
    
    ////////////
    
    
    //    UIView *ViewTitle=[[UIView alloc] initWithFrame:CGRectMake(0, gap.frame.size.height+gap.frame.origin.y, prMainView.frame.size.width, 45)];
    //    ViewTitle.backgroundColor=[UIColor colorWithRed:225.0f/255.0f green:232.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    //    [headerView addSubview:ViewTitle];
}
-(void)dissmisspop
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
