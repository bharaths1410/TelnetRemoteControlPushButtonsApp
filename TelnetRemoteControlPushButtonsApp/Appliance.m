//
//  Appliance.m
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/13/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import "Appliance.h"

@implementation Appliance

-(id) copyWithZone: (NSZone *) zone
{
    Appliance *applianceCopy = [[Appliance allocWithZone: zone] init];
    
    applianceCopy.label = self.label;
    applianceCopy.buttonNumber = self.buttonNumber;
    applianceCopy.ipAddress = self.ipAddress;
    applianceCopy.telnetPort = self.telnetPort;
    applianceCopy.userName = self.userName;
    applianceCopy.password = self.password;
    applianceCopy.telnetStrings = self.telnetStrings;
    
    return applianceCopy;
}

@end
