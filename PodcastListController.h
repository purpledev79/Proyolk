//
//  PodcastListController.h
//  Proyolk
//
//  Created by Shiv ram on 21/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PodcastListController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *podcastTable;
@property (strong, nonatomic) NSArray* podcastsArr;

@end
