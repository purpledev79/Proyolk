//
//  Interview.h
//  Proyolk
//
//  Created by iFlame on 10/11/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonProfile.h"
@interface Interview : UIViewController<UITableViewDataSource,UITableViewDelegate>{

}
@property (strong, nonatomic) IBOutlet UITableView *tview;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;

- (IBAction)btnSearch:(id)sender;

@end
