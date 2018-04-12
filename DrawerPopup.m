//
//  DrawerPopup.m
//  Proyolk
//
//  Created by PURPLE on 5/6/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import "DrawerPopup.h"
#import "AllValidationsViewController.h"
#import "SavePrefrences.h"
#import "LeftRightDrawer.h"
#import "MainController.h"

@interface DrawerPopup ()
{
    float screenWidth,screenHeight;
    NSMutableArray *popUpAr;
    AllValidationsViewController *av;
    UIView *prMainView,*headerView,*main,*cell_View;
    LeftRightDrawer *drawer;
    UIViewController *vc1;
    
}
@end

@implementation DrawerPopup
@synthesize notiTableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    drawer=[[LeftRightDrawer alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(UIView *) MainViewwithouttitle:(UIViewController *)Vc
{
    av=[[AllValidationsViewController alloc]init];
    
    NSLog(@"pop ar count in mainview2   %lu",[popUpAr count]);
    
    UIColor *color = [UIColor blackColor];
    prMainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,[SavePrefrences sharedInstance ].screenWidth,[SavePrefrences sharedInstance ].screenHeight)];
    [Vc.view addSubview:prMainView];
    vc1=Vc;
    prMainView.backgroundColor=[UIColor colorWithRed:132.0f/255.0f green:132.0f/255.0f blue:132.0f/255.0f alpha:.5f];
    if([popUpAr count]>0)
    {
        [popUpAr addObject:prMainView];
    }
    else{
        
        popUpAr =[[NSMutableArray alloc]init];
        [popUpAr addObject:prMainView];
    }
    
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, prMainView.frame.size.width, 56)];
    headerView.backgroundColor=[UIColor colorWithRed:78.0/255 green:119.0/255 blue:145.0/255 alpha:1.0];
    headerView.layer.cornerRadius=5;
    [prMainView addSubview:headerView];
    
    return prMainView;
}
-(void)BoardScreen:(UIViewController*)Vc
{
    [self MainViewwithouttitle:self];
    
    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
    [bckarrow setImage:[UIImage imageNamed:@"back.png"]];
    bckarrow.userInteractionEnabled=YES;
    [headerView addSubview:bckarrow];
    
    
    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoBack)];
    [communityeg setNumberOfTouchesRequired:1];
    [communityeg setDelegate:self];
    bckarrow.userInteractionEnabled = YES;
    [bckarrow addGestureRecognizer:communityeg];
    
    
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150, 40)];
    [logo setImage:[UIImage imageNamed:@"logo.png"]];
    [headerView addSubview:logo];
    
    main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
    main.backgroundColor=[ff valueForKey:@"backcolor"];
    [self.view addSubview:main];
    
    
    
    
}
//-(void)Yolking:(UIViewController*)Vc
//{
//    //[drawer initArs:self];
//
//    NSLog(@"yolking");
//
//    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
//
//    [self MainViewwithouttitle:vc1];
//
//    UIImageView *bckarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
//    [bckarrow setImage:[UIImage imageNamed:@"back.png"]];
//    bckarrow.userInteractionEnabled=YES;
//    [headerView addSubview:bckarrow];
//
//
//    UITapGestureRecognizer *communityeg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoBack)];
//    [communityeg setNumberOfTouchesRequired:1];
//    [communityeg setDelegate:self];
//    bckarrow.userInteractionEnabled = YES;
//    [bckarrow addGestureRecognizer:communityeg];
//
//
//    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(bckarrow.frame.size.width+bckarrow.frame.origin.x+15,5,150, 40)];
//    [logo setImage:[UIImage imageNamed:@"logo.png"]];
//    [headerView addSubview:logo];
//
//    main=[[UIView alloc]initWithFrame:CGRectMake(0,70, screenWidth, screenHeight)];
//    main.backgroundColor=[ff valueForKey:@"backcolor"];
//    [self.view addSubview:main];
//
//    UILabel *activity=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,screenWidth , 30)];
//    activity.text=@"Activities";
//    activity.textAlignment=NSTextAlignmentCenter;
//    activity.textColor=[UIColor whiteColor];
//    activity.backgroundColor=[UIColor blackColor];
//    [main addSubview:activity];
//
//    UILabel *actvty_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, activity.frame.size.height+activity.frame.origin.y,screenWidth , 5)];
//    actvty_lbl.backgroundColor=[UIColor colorWithRed:238.0f/255 green:186.0f/255 blue:48.0f/255 alpha:1.0f];
//    [main addSubview:actvty_lbl];
//
//    notiTableView=[[UITableView alloc]initWithFrame:CGRectMake(5, actvty_lbl.frame.size.height+actvty_lbl.frame.origin.y+10, main.frame.size.width-10, main.frame.size.height-(actvty_lbl.frame.size.height+actvty_lbl.frame.origin.y+75))];
//    notiTableView.backgroundColor=[ff valueForKey:@"backcolor"];
//    notiTableView.delegate = self;
//    notiTableView.dataSource = self;
//    notiTableView.scrollEnabled = YES;
//    notiTableView.separatorColor=[ff valueForKey:@"backcolor"];
//    [main addSubview:notiTableView];

//}

//-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
//{
//
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    NSMutableDictionary *ff=[SavePrefrences sharedInstance].colorDictionry;
//    NSString *MyCellIdentifier = @"MyCellIdentifier";
//    UITableViewCell *cell = [self.notiTableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
//
//    @try {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCellIdentifier];
//        cell.selectionStyle = UITableViewCellEditingStyleNone;
//        cell.layer.cornerRadius=8;
//        cell.clipsToBounds=YES;
//        cell.backgroundColor=[UIColor whiteColor];
//
//        if(theTableView==notiTableView)
//        {
//
//            cell_View=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width+50,120)];
//            cell_View.backgroundColor=[UIColor whiteColor];
//            cell_View.layer.borderWidth=1;
//            cell_View.layer.borderColor=[[UIColor grayColor] CGColor];
//            cell_View.layer.cornerRadius=6;
//            [cell addSubview: cell_View];
//
//            UIImageView *userpic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 55, 55)];
//            [userpic setImage:[UIImage imageNamed:@"user.png"]];
//            [cell_View addSubview:userpic];
//
//            UILabel  *user_lbl=[[UILabel alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10, 15, 110,15)];
//            user_lbl.text=@"User name";
//            [user_lbl setFont:[UIFont systemFontOfSize:14]];
//            user_lbl.backgroundColor=[UIColor whiteColor];
//            user_lbl.textColor=[ff valueForKey:@"Scrollcolor"];
//            [cell_View addSubview:user_lbl];
//
//            UILabel *timlb=[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width-85, 10, 80,15)];
//            timlb.text=@"7 days ago";
//            timlb.textColor=[UIColor grayColor];
//            [timlb setFont:[UIFont systemFontOfSize:8]];
//            timlb.backgroundColor=[UIColor whiteColor];
//            [cell_View addSubview:timlb];
//
//            UITextView *request=[[UITextView alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10, user_lbl.frame.size.height+user_lbl.frame.origin.y,cell.frame.size.width/2, 25)];
//            request.text=@"Sent you a friend";
//            [request setFont:[UIFont systemFontOfSize:14]];
//            request.backgroundColor=[UIColor whiteColor];
//            request.userInteractionEnabled=NO;
//            request.textColor=[UIColor grayColor];
//            [cell_View addSubview:request];
//
//            UIButton *accept = [[UIButton alloc]initWithFrame:CGRectMake(userpic.frame.size.width+userpic.frame.origin.x+10,request.frame.size.height+request.frame.origin.y+15, cell_View.frame.size.width/2-55,20)];
//            [accept setTitle: @"Accept" forState: UIControlStateNormal];
//            accept.backgroundColor=[ff valueForKey:@"Yellowbtncolor"];
//            //   [accept addTarget:self action:@selector(saveEmployementProfile:) forControlEvents:UIControlEventTouchUpInside];
//            [accept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            accept.layer.cornerRadius=5;
//            accept.tag=0;
//            [cell_View addSubview:accept];
//
//
//            UIButton *decline = [[UIButton alloc]initWithFrame:CGRectMake(accept.frame.size.width+accept.frame.origin.x+2,request.frame.size.height+request.frame.origin.y+15, cell_View.frame.size.width/2-55, 20)];
//            [decline setTitle: @"Decline" forState: UIControlStateNormal];
//            decline.backgroundColor=[ff valueForKey:@"Declinecolor"];
//            //   [decline addTarget:self action:@selector(saveEmployementProfile:) forControlEvents:UIControlEventTouchUpInside];
//            [decline setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            decline.layer.cornerRadius=5;
//            decline.tag=0;
//            [cell_View addSubview:decline];
//
//            return cell;
//        }
//
//
//        return cell;
//    }
//    @catch (NSException *exception) {
//        NSLog(@"exception is===%@",exception);
//    }
//    @finally {
//
//    }
//
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    return 110;
//}
//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//
//

@end
