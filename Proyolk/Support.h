//
//  Storage.h
//  Proyolk
//
//  Created by Purple Intellect on 08/04/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
#import "TermsViewController.h"
#import "FAQViewController.h"
#import "AllValidationsViewController.h"
#import "LeftRightDrawer.h"
#import "SavePrefrences.h"
#import "openChat.h"
#import "MainController.h"
#import "FTFoldingTableView.h"
#import "SupportCell.h"
#import "ContactUs.h"
#import "ChangePassword.h"
#import "TutorialViewController.h"
@interface Support : UIViewController<PjsCallBack,FTFoldingTableViewDelegate,UITextFieldDelegate>
{
    float screenWidth,screenHeight,naviWidth,naviHght,stbarHght;
    UIView *main,*cell_View;
    AllValidationsViewController *av;
    //LeftRightDrawer *drawer
    MainController *vc1;
    openChat *opop;
    NSMutableDictionary * frChatAr;
    int iscallback;
    NSArray * keyAr;
    ManageArray * mngAr;
    NSArray *Frnd_chat;
    int cnt;
    
}
@property (weak, nonatomic) IBOutlet FTFoldingTableView *ft_tableView;
@property (nonatomic, assign)FTFoldingSectionHeaderArrowPosition arrowPosition;

@property(nonatomic,strong)IBOutlet UITableView *InboxtableView;
@end


/*
 UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, prMainView.frame.size.height-2, prMainView.frame.size.width, 2)];
 lblline.backgroundColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
 [option addSubview:lblline];
 
 */