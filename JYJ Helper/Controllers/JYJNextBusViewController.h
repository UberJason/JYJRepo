//
//  JYJNextBusViewController.h
//  JYJ Helper
//
//  Created by Jason Ji on 10/26/13.
//  Copyright (c) 2013 Jason Ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYJMainBusViewController.h"

@interface JYJNextBusViewController : UIViewController <UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) BusSelected homeRequested;

@end
