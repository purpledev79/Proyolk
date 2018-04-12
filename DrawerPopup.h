//
//  DrawerPopup.h
//  Proyolk
//
//  Created by PURPLE on 5/6/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerPopup : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)IBOutlet UITableView *notiTableView;
-(void)Yolking:(UIViewController*)Vc;
-(void)BoardScreen:(UIViewController*)Vc;
@end
