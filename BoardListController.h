//
//  BoardListController.h
//  Proyolk
//
//  Created by Shiv ram on 20/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardListController : UIViewController
@property (strong, nonatomic) NSArray* boardArr;
@property (strong, nonatomic) IBOutlet UITableView *boardTable;

@end
