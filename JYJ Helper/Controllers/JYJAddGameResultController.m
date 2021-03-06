//
//  JYJAddGameResultController.m
//  JYJ Helper
//
//  Created by Jason Ji on 11/8/14.
//  Copyright (c) 2014 Jason Ji. All rights reserved.
//

#import "JYJAddGameResultController.h"

@interface JYJAddGameResultController ()

@property (nonatomic) BOOL showingDatePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation JYJAddGameResultController

-(NSDateFormatter *)dateFormatter {
    if(!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"MMMM d, yyyy, h:mm a";
    }
    return _dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.barTintColor = [UIColor emeraldFlatColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
 
    if(!self.record)
        self.record = [GameRecord gameRecordWithWinner:@"Jason" numWinnerCups:3 numLoserCups:0 gameTime:[NSDate date] inManagedObjectContext:((JYJAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    

}

- (IBAction)savePressed:(id)sender {
    [((JYJAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelPressed:(id)sender {
    
    [((JYJAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext rollback];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIBarPositioningDelegate

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

#pragma mark - UITableView Delegate/Data Source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self identifierForRowAtIndexPath:indexPath];
    if([identifier isEqualToString:@"datePickerCell"])
        return 216.0f;
    else
        return 44.0f;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return @"Winner";
    else if(section == 1)
        return @"Winner Cups";
    else if(section == 2)
        return @"Loser Cups";
    else
        return @"Game Time";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0 || section == 1 || section == 2)
        return 3;
    else
        return self.showingDatePicker ? 2 : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self identifierForRowAtIndexPath:indexPath];
    if([identifier isEqualToString:@"playerCell"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(indexPath.row == 0)
            cell.textLabel.text = @"Jason";
        else if(indexPath.row == 1)
            cell.textLabel.text = @"Mary Anne";
        else
            cell.textLabel.text = @"Deadlock";

        if([self.record.winner isEqualToString:cell.textLabel.text])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
    else if([identifier isEqualToString:@"winnerCupsCell"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld Cups", indexPath.row+3];
        if(self.record.numWinnerCups.integerValue == indexPath.row+3)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
    else if([identifier isEqualToString:@"loserCupsCell"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld Cups", indexPath.row];
        if(self.record.numLoserCups.integerValue == indexPath.row)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
    else if([identifier isEqualToString:@"dateCell"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        cell.textLabel.text = [self.dateFormatter stringFromDate:self.record.gameTime];
        
        return cell;
    }
    else {
        DatePickerCell *cell = (DatePickerCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

        cell.datePicker.date = self.record.gameTime;
        cell.delegate = self;
        return cell;
    }
}

-(NSString *)identifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0)
        return @"playerCell";
    else if(indexPath.section == 1)
        return @"winnerCupsCell";
    else if(indexPath.section == 2)
        return @"loserCupsCell";
    else if(indexPath.section == 3 && indexPath.row == 0)
        return @"dateCell";
    else if(indexPath.section == 3 && indexPath.row == 1)
        return @"datePickerCell";
    else return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(indexPath.row == 0)
            self.record.winner = @"Jason";
        else if(indexPath.row == 1)
            self.record.winner = @"Mary Anne";
        else
            self.record.winner = @"Deadlock";

        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if(indexPath.section == 1) {
        self.record.numWinnerCups = @(indexPath.row+3);
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if(indexPath.section == 2) {
        self.record.numLoserCups = @(indexPath.row);
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if(indexPath.section == 3) {
        self.showingDatePicker = ! self.showingDatePicker;
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];

        } completion:^(BOOL finished) {
            if(self.showingDatePicker)
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:3] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }];
    }
    
}

#pragma mark - DatePickerDelegate

-(void)cellDidChangeDate:(DatePickerCell *)cell datePicker:(UIDatePicker *)datePicker {
    self.record.gameTime = datePicker.date;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
}

@end
