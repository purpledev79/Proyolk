//
//  invitePeople.m
//  Proyolk
//
//  Created by PURPLE on 3/3/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "invitePeople.h"
#import "SavePrefrences.h"
#import "AllValidationsViewController.h"
#import "CalendarPopup.h"


@interface invitePeople ()
{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    
    UIScrollView *scrollbar;
    UILabel *promptLabel,*pryk_frnds,*cabinate,*network,*txt_lbl;
    UITextField *search_name;
    UIView *view1;
    UIImageView *img;
}


@end


@implementation invitePeople

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    naviWidth = self.navigationController.navigationBar.frame.size.width;
    naviHght =  self.navigationController.navigationBar.frame.size.height;
    stbarHght= (float)[[UIApplication sharedApplication] statusBarFrame].size.height;
    
    scrollbar=[[UIScrollView alloc]initWithFrame:CGRectMake(0, naviHght, screenWidth, screenHeight)];
    [scrollbar setContentSize:CGSizeMake(screenWidth, screenHeight)];
    scrollbar.backgroundColor=[UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
    [self.view addSubview:scrollbar];
    
    promptLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, screenWidth, 50)];
    promptLabel.text=@"Create a New Event";
    promptLabel.textAlignment=NSTextAlignmentCenter;
    promptLabel.backgroundColor=[UIColor colorWithRed:255.0/255 green:215.0/255 blue:0.0/255 alpha:1];
    [self.view addSubview:promptLabel];
    
    pryk_frnds=[[UILabel alloc]initWithFrame:CGRectMake(5, promptLabel.frame.size.height+promptLabel.frame.origin.y-80, 80, 45)];
    pryk_frnds.text=@"Proyolk Friends";
    pryk_frnds.backgroundColor=[UIColor cyanColor];
    [scrollbar addSubview:pryk_frnds];
    
    cabinate=[[UILabel alloc]initWithFrame:CGRectMake(pryk_frnds.frame.size.width+pryk_frnds.frame.origin.x, promptLabel.frame.size.height+promptLabel.frame.origin.y-80, 80, 45)];
    cabinate.text=@"Proyolk Friends";
    cabinate.backgroundColor=[UIColor cyanColor];
    [scrollbar addSubview:cabinate];

    network=[[UILabel alloc]initWithFrame:CGRectMake(5, promptLabel.frame.size.height+promptLabel.frame.origin.y-80, 80, 45)];
    network.text=@"Proyolk Friends";
    network.backgroundColor=[UIColor cyanColor];
    [scrollbar addSubview:network];
    
    search_name=[[UITextField alloc]initWithFrame:CGRectMake(5, pryk_frnds.frame.size.height+pryk_frnds.frame.origin.y+10, 100, 45)];
    search_name.placeholder=@" Search Name..";
    search_name.backgroundColor=[UIColor whiteColor];
    [search_name setFont:[UIFont fontWithName:@"Times New Roman" size:20]];
    search_name.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1]CGColor];
    search_name.layer.borderWidth=2;
    search_name.layer.cornerRadius=6;
    [scrollbar addSubview:search_name];
 
    UIButton *search=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    search.frame=CGRectMake(search_name.frame.size
                            .width+search_name.frame.origin.x,pryk_frnds.frame.size.height+pryk_frnds.frame.origin.y+10 , 150, 40);
    [search setTitle:@"Discard" forState:UIControlStateNormal];
    [search setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    [search setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    search.layer.cornerRadius=6;
    search.backgroundColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];

    [scrollbar addSubview:search];
    view1=[[UIView alloc]initWithFrame:CGRectMake(5,search_name.frame.size.height+search_name.frame.origin.y+10, scrollbar.frame.size.width-11, 45)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.borderColor=[[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1]CGColor];
    view1.layer.borderWidth=2;
    view1.layer.cornerRadius=6;
    [scrollbar addSubview:view1];
    
    img=[[UIImageView alloc]initWithFrame:CGRectMake(view1.frame.origin.x, view1.frame.origin.y, 60 , 40)];
    img.backgroundColor=[UIColor blueColor];
    img.layer.cornerRadius=6;
    [view1 addSubview:img];
    
    txt_lbl=[[UILabel alloc]initWithFrame:CGRectMake(img.frame.origin.x, view1.frame.origin.y, view1.frame.size.width+view1.frame.origin.x-40, 25)];
    txt_lbl.backgroundColor=[UIColor whiteColor];
    txt_lbl.text=@"Txt";
    [txt_lbl setFont:[UIFont fontWithName:@"Times New Roman" size:20]];
    [view1 addSubview:txt_lbl];
    
    UIButton *sent=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sent.frame=CGRectMake(img.frame.size.width+search_name.frame.origin.x,txt_lbl.frame.size.height+txt_lbl.frame.origin.y+5 , 80, 25);
    [sent setTitle:@"Discard" forState:UIControlStateNormal];
    [sent setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    [sent setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    sent.layer.cornerRadius=6;
    sent.backgroundColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];

    [view1 addSubview:sent];
    
    UIButton *remove=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    remove.frame=CGRectMake(sent.frame.size.width+sent.frame.origin.x,txt_lbl.frame.size.height+txt_lbl.frame.origin.y+5 , 60, 25);
    [remove setTitle:@"Discard" forState:UIControlStateNormal];
    [remove setFont:[UIFont fontWithName:@"Times New Roman" size:22]];
    [remove setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    remove.layer.cornerRadius=6;
    remove.backgroundColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];
    
    [view1 addSubview:remove];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
