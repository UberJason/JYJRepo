//
//  JYJTrackingViewController.h
//  JYJ Helper
//
//  Created by Jason Ji on 12/28/13.
//  Copyright (c) 2013 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYJAddCell.h"

@interface JYJTrackingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger currentSectionAboutToBeDeleted;

-(void)addJason:(JYJAddCell *)sender;
-(void)addKevin:(JYJAddCell *)sender;
-(void)deleteSection:(JYJAddCell *)sender;

@end
