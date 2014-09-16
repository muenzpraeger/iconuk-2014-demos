//
//  PersonDetailTableViewController.h
//  iconuk2014
//
//  Created by René Winkelmeyer on 11.09.14.
//  Copyright (c) 2014 René Winkelmeyer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Http.h"

@interface PersonDetailTableViewController : UITableViewController <HttpDelegate>

// This property is used to get the NSMutableDictionary from the UI table.
@property (nonatomic, strong) NSMutableDictionary *dictPerson;

@end
