//
//  MainViewController.m
//  Tick List
//
//  Created by Jamie Currie on 15/12/2014.
//  Copyright (c) 2014 balloondog. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "TickListTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize textView;

#pragma Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Debug showDebugLog:false];
    
    textView.layer.cornerRadius = 15;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadTable];
    
}

-(void)updateSaves:(NSDictionary *)list {

    [savedLists replaceObjectAtIndex:listNumber withObject:list];
    [Storage saveObject:savedLists withFileName:@"SAVED_LISTS"];
    
}

-(void) loadTable {
    
    savedLists = [Storage openFileWithName:@"SAVED_LISTS"];
        
    if (savedLists == nil) {
        savedLists = [[NSMutableArray alloc] init];
    }
    
    [self.tableView reloadData];
    
}

#pragma Creating Lists

- (IBAction)createList:(id)sender {
    
    if (![textView.text isBlank]) {
        
        textView.editable = false;
        
        UIAlertView *popup = [[UIAlertView alloc] initWithTitle:@"Create a List" message:@"What would you like to call the list?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
        popup.alertViewStyle = UIAlertViewStylePlainTextInput;
        [popup textFieldAtIndex:0].autocapitalizationType = UITextAutocapitalizationTypeWords;

        [popup show];
        
        textView.editable = true;
    }
    
}

- (IBAction)wipeList:(id)sender {
    
    [self.textView resignFirstResponder];
}

-(NSArray *)removeBlanks: (NSArray *) list {
    
    NSMutableArray *listDict = [[NSMutableArray alloc] init];
    
    for (NSString *item in list) {
        if (![item isBlank]) {
            NSMutableDictionary *itemDict = [[NSMutableDictionary alloc] initWithDictionary: @{ @"item" : item, @"complete" : @false }];
            [listDict addObject:itemDict];
        }
    }
    
    return listDict;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        if ([[alertView textFieldAtIndex:0].text isBlank]) {
            [self createList:self];
        } else {
            
            NSArray *list = [textView.text splitOnChar:'\n'];
            NSString *listName = [alertView textFieldAtIndex:0].text;
            
            list = [self removeBlanks: list];
            
            NSDictionary *listItem = @{@"listName" : listName, @"list" : list};
                    
            [savedLists addObject:listItem];
            
            [Storage saveObject:savedLists withFileName:@"SAVED_LISTS"];
            
            textView.text = nil;
            
            [self loadTable];
            
        }
    }
    
}

#pragma Table view

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    sendDict = [savedLists objectAtIndex:indexPath.row];
    listNumber = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"goToList" sender:self];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return savedLists.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.listName.text = [[savedLists objectAtIndex:indexPath.row] objectForKey:@"listName"];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [savedLists removeObjectAtIndex:indexPath.row];
        [Storage saveObject:savedLists withFileName:@"SAVED_LISTS"];
        [self loadTable];
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TickListTableViewController *vc = [segue destinationViewController];
    vc.list = [[NSMutableDictionary alloc] initWithDictionary:sendDict];
    vc.mainViewController = self;
}

@end
