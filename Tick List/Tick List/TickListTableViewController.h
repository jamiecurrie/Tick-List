//
//  TickListTableViewController.h
//  Tick List
//
//  Created by Jamie Currie on 15/12/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AwesomeBD/AwesomeBD.h>


@class MainViewController;

@interface TickListTableViewController : UITableViewController <UITabBarDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableDictionary *list;
@property (strong, nonatomic) MainViewController *mainViewController;

@end
