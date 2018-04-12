//
//  JobListVIewControllerViewController.h
//  Proyolk
//
//  Created by Padam on 11/24/16.
//  Copyright © 2016 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface JobListVIewController : UIViewController{
    NSMutableArray *arrJobs;
}
@property(nonatomic) int frienduid;
@property (strong, nonatomic) IBOutlet UITableView *jobTable;

@end
