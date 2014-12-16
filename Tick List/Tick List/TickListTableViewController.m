//
//  TickListTableViewController.m
//  Tick List
//
//  Created by Jamie Currie on 15/12/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import "TickListTableViewController.h"
#import "TickListTableViewCell.h"
#import "MainViewController.h"

@interface TickListTableViewController ()

@end

@implementation TickListTableViewController

@synthesize list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [list objectForKey:@"listName"];
    
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    animating = true;
    
    NSDictionary *data = [[list objectForKey:@"list"] objectAtIndex:indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    if ([[data objectForKey:@"complete"] isEqual:@false]) {
        [[[list objectForKey:@"list"] objectAtIndex:indexPath.row] setObject:@true forKey:@"complete"];
        
        id object = [[list objectForKey:@"list"] objectAtIndex:indexPath.row];
        [[list objectForKey:@"list"] removeObjectAtIndex:indexPath.row];
        [[list objectForKey:@"list"] addObject:object];
        
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:[[list objectForKey:@"list"] count] - 1 inSection:0]];
        
    } else {
        
        [[[list objectForKey:@"list"] objectAtIndex:indexPath.row] setObject:@false forKey:@"complete"];
        
        id object = [[list objectForKey:@"list"] objectAtIndex:indexPath.row];
        [[list objectForKey:@"list"] removeObjectAtIndex:indexPath.row];
        [[list objectForKey:@"list"] insertObject:object atIndex:0];
        
        
        [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = [UIColor whiteColor];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        
    }
    
    [self.mainViewController updateSaves:list];
    [self performSelector:@selector(reloadTabel) withObject:nil afterDelay:0.3];
}

-(void) reloadTabel {
    
    animating = false;
 
    if (animating == false) {
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[list objectForKey:@"list"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *data = [[list objectForKey:@"list"] objectAtIndex:indexPath.row];
    
    TickListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tickCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([[data objectForKey:@"complete"] isEqual:@false]) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.listItem.text = [data objectForKey:@"item"];
    } else {
        cell.backgroundColor = BD_rgb(100, 0, 0, 0.5f);
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[data objectForKey:@"item"]];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        
        cell.listItem.attributedText = attributeString;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


@end
