//
//  MainViewController.h
//  Tick List
//
//  Created by Jamie Currie on 15/12/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AwesomeBD/AwesomeBD.h>

@interface MainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate, UIAlertViewDelegate> {
    
    NSMutableArray *savedLists;
    NSDictionary *sendDict;
    int listNumber;
    
}

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void) updateSaves: (NSDictionary *) list;

@end
