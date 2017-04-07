//
//  Appliance.h
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/13/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appliance : NSObject

@property(nonatomic) NSString *label;
@property(nonatomic) NSString *buttonNumber;
@property(nonatomic) NSString *ipAddress;
@property(nonatomic) NSString *telnetPort;
@property(nonatomic) NSString *userName;
@property(nonatomic) NSString *password;
@property(nonatomic) NSString *telnetStrings;

@end

