//
//  ViewController.h
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/11/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddButtonViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddButtonProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

