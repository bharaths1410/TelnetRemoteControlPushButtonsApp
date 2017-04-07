//
//  ButtonsViewController.h
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/11/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appliance.h"
#import "AddButtonViewController.h"

@interface ButtonsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, AddButtonProtocol>

@property(nonatomic) NSString *groupName;
@property(nonatomic) Appliance *appliance;

@end
