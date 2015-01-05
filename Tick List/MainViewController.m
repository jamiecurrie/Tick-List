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

@synthesize textView, inputHeight;

#pragma Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Debug showDebugLog:false];
    
    textView.layer.cornerRadius = 15;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    inputHeight.constant = 0;
    CreateBtn.title = @"New List";
    
    [self loadTable];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
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
        [popup textFieldAtIndex:0].autocapitalizationType = UITextAutocapitalizationTypeSentences;
        
        [popup show];
        
        textView.editable = true;
        CreateBtn.title = @"New List";
        editBtn.title = @"Edit";
        [self setInputViewHeight:0];

        
    } else {
        
        if (inputHeight.constant == 0) {
            [self performSelector:@selector(showHint:) withObject:@true afterDelay:0.2];
            editBtn.title = @"Cancel";
            CreateBtn.title = @"Create";
            [self.tableView setEditing:false animated:false];
            
            [self setInputViewHeight:310];

        } else {
            addText.textColor = [UIColor redColor];
            addText.alpha = 0.8f;

        }
    }
}

-(void)setInputViewHeight: (int) height {
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.inputHeight.constant = height;
                         [self.view layoutIfNeeded];
                     }];
    
}



-(void)showHint: (BOOL) input {
    
    if (input) {
        addText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        addText.text = @"ADD TEXT HERE";
        [addText sizeToFit];
        addText.center = self.textViewRef.center;
        addText.textColor = [UIColor blackColor];
        addText.alpha = 0.4f;
        [self.view addSubview:addText];
    } else {
        [addText removeFromSuperview];
    }
    
}

- (IBAction)editButton:(id)sender {
    
    if ([editBtn.title isEqualToString:@"Cancel"]) {
        [self setInputViewHeight:0];
        editBtn.title = @"Edit";
        CreateBtn.title = @"New List";
        [textView resignFirstResponder];
        textView.text = nil;
        [self showHint:false];
        
    }
    
    else if ([editBtn.title isEqualToString:@"Done"]) {
        [self.tableView setEditing:false animated:true];
        editBtn.title = @"Edit";
    }
    
    else if ([editBtn.title isEqualToString:@"Edit"]) {
        [self.tableView setEditing:true animated:true];
        editBtn.title = @"Done";
    }
    
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
            
            [self loadTable];
            
        }
    }
    
    textView.text = nil;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self showHint:false];
}

#pragma Table view

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    sendDict = [savedLists objectAtIndex:indexPath.row];
    listNumber = (int)indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"goToList" sender:self];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return savedLists.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int numberLeft = 0;
    
    for (NSDictionary *item in [[savedLists objectAtIndex:indexPath.row] objectForKey:@"list"]) {
        if ([[item objectForKey:@"complete"] isEqual:@false]) {
            numberLeft++;
        }
    }
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.listName.text = [[savedLists objectAtIndex:indexPath.row] objectForKey:@"listName"];
    cell.listNumber.text = [NSString stringWithFormat:@"%i" ,numberLeft];
    cell.listNumber.alpha = 0.5f;
    cell.listNumber.textAlignment = NSTextAlignmentRight;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSDictionary *data = [savedLists objectAtIndex:sourceIndexPath.row];
    
    NSLog(@"Moving %@ from %li to %li", data , (long)sourceIndexPath.row, (long)destinationIndexPath.row);
    
    [savedLists removeObjectAtIndex:sourceIndexPath.row];
    [savedLists insertObject:data atIndex:destinationIndexPath.row];
    [Storage saveObject:savedLists withFileName:@"SAVED_LISTS"];
    
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
