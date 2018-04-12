//
//  JobListTableCell.h
//  Proyolk
//
//  Created by Shiv ram on 20/02/17.
//  Copyright © 2017 PURPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobListTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UILabel *postedDate;
@property (strong, nonatomic) IBOutlet UILabel *statusLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *durationLbl;
@property (strong, nonatomic) IBOutlet UILabel *postedByLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobDescriptionLbl;

@end
