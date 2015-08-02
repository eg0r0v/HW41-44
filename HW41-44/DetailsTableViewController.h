//
//  DetailsTableTableViewController.h
//  HW41-44
//
//  Created by Илья Егоров on 02.08.15.
//  Copyright (c) 2015 Илья Егоров. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTableViewController : UITableViewController < UITableViewDelegate,
                                                                UITextFieldDelegate>

@property (strong, nonatomic) Class className;
@property (strong, nonatomic) NSObject* object;

@end
