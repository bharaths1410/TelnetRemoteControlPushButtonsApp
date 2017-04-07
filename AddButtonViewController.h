//
//  AddButtonViewController.h
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/14/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appliance.h"

typedef void (^AddApplianceCompletionBlock)(Appliance *appliance, NSArray *groups);

@protocol AddButtonProtocol <NSObject>
@required
-(void)addAppliance:(Appliance *)appliance inGroups:(NSArray *)groups;

@end

@interface AddButtonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic, weak) id<AddButtonProtocol> delegate;
@property(nonatomic) Appliance *appliance;

@property(nonatomic) BOOL addButton;


@property(nonatomic) AddApplianceCompletionBlock addApplianceCompletionBlock;

@end
