//
//  Storage.h
//  Proyolk
//
//  Created by Purple Intellect on 08/04/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjsCallBack.h"
@interface Storage : UIViewController<PjsCallBack,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSMutableDictionary *dictFilter;
}

@property(nonatomic,strong)IBOutlet UITableView *InboxtableView,*notificationTable;;
@end


/*
 UILabel *lblline=[[UILabel alloc]initWithFrame:CGRectMake(0, prMainView.frame.size.height-2, prMainView.frame.size.width, 2)];
 lblline.backgroundColor=[UIColor colorWithRed:153.0f/255 green: 153.0f/255 blue:153.0f/255 alpha:1.0];
 [option addSubview:lblline];
 
 */