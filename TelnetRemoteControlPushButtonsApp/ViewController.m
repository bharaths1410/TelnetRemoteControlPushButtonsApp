//
//  ViewController.m
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/11/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import "ViewController.h"
#import "ButtonsViewController.h"
#import "AddButtonViewController.h"
#import "Appliance.h"

#define kGroupNameBedRoom @"Bed Room"
#define kGroupNameHall @"Hall"
#define kGroupNameKitchen @"Kitchen"

@interface ViewController ()

- (IBAction)settingsButtonAction:(id)sender;
- (IBAction)addNewButtonAction:(id)sender;

@property NSMutableDictionary *groupsDict;
@property NSMutableArray *array,*bedRoomArray,*hallArray,*kitchenArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:24/255.0 green:66/255.0 blue:177/255.0 alpha:1.0];
    _tableView.backgroundColor = [UIColor clearColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:236/255.0 green:74/255.0 blue:138/255.0 alpha:1.0]];
    [self createSampleAppliances];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;

}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:1.0 animations:^{
        self.tableView.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-150);
    } completion:^(BOOL finished) {
        self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }];

}

-(void)createSampleAppliances{
    _groupsDict = nil;
    
    Appliance *fan = [[Appliance alloc] init];
    fan.label = @"Fan";
    fan.buttonNumber = @"1";
    fan.ipAddress = @"198.77.22.97";
    fan.telnetPort = @"port1";
    fan.userName = @"fan";
    fan.password = @"1234";
    fan.telnetStrings = @"fanStrng1, fanStrng2";

    Appliance *airConditioner = [[Appliance alloc] init];
    airConditioner.label = @"Air Conditioner";
    airConditioner.buttonNumber = @"2";
    airConditioner.ipAddress = @"198.77.20.96";
    airConditioner.telnetPort = @"portAC";
    airConditioner.userName = @"AC";
    airConditioner.password = @"12345";
    airConditioner.telnetStrings = @"acStrng1, acStrng2";

    _bedRoomArray = [NSMutableArray arrayWithObjects: fan, airConditioner, nil];

   
    Appliance *fan2 = [[Appliance alloc] init];
    fan2.label = @"Fan Hall";
    fan2.buttonNumber = @"1";
    fan2.ipAddress = @"198.22.334.43";
    fan2.telnetPort = @"port2";
    fan2.userName = @"fan2";
    fan2.password = @"12342";
    fan2.telnetStrings = @"fan2Strng1, fan2Strng2";

    Appliance *airConditioner2 = [[Appliance alloc] init];
    airConditioner2.label = @"Air Conditioner";
    airConditioner2.buttonNumber = @"3";
    airConditioner2.ipAddress = @"197.22.33.24";
    airConditioner2.telnetPort = @"port2";
    airConditioner2.userName = @"AC2";
    airConditioner2.password = @"1113";
    airConditioner2.telnetStrings = @"ac2Strng1, ac2Strng2";
    
    Appliance *light = [[Appliance alloc]init];
    light.label = @"Light";
    light.buttonNumber = @"2";
    light.ipAddress = @"198.22.366.43";
    light.telnetPort = @"port1";
    light.userName = @"light1";
    light.password = @"3456";
    light.telnetStrings = @"lightStrng1, lightStrng2";

    _hallArray = [NSMutableArray arrayWithObjects: fan2, airConditioner2, light, nil];

    
    Appliance *fan3 = [[Appliance alloc] init];
    fan3.label = @"Fan Kitchen";
    fan3.buttonNumber = @"2";
    fan3.ipAddress = @"198.242.334.44";
    fan3.telnetPort = @"port3";
    fan3.userName = @"fan3";
    fan3.password = @"12882";
    fan3.telnetStrings = @"fan3Strng1, fan3Strng2";
    
    Appliance *oven = [[Appliance alloc] init];
    oven.label = @"Oven";
    oven.buttonNumber = @"1";
    oven.ipAddress = @"195.242.334.44";
    oven.telnetPort = @"port1";
    oven.userName = @"oven";
    oven.password = @"1285";
    oven.telnetStrings = @"ovenStrng1, ovenStrng2";
    
    _kitchenArray = [NSMutableArray arrayWithObjects: fan3, oven, nil];

    _groupsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys: _bedRoomArray,kGroupNameBedRoom,_hallArray,kGroupNameHall, _kitchenArray,kGroupNameKitchen,nil];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSArray *keysArray = [_groupsDict allKeys];
    return keysArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rows = 0;
    NSArray *keysArray = [_groupsDict allKeys];
    NSArray *array = [_groupsDict valueForKey:keysArray[section]];
    rows = [array count];

    return rows;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSArray *keysarray = [_groupsDict allKeys];
    return [keysarray objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    NSArray *keysArray = [_groupsDict allKeys];
    NSArray *array = [_groupsDict valueForKey:keysArray[indexPath.section]];
    
    Appliance *someAppliance = array[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@. %@",someAppliance.buttonNumber, someAppliance.label];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"button"]) {
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
       
        NSArray *keysArray = [_groupsDict allKeys];
        
        NSArray *array = [_groupsDict valueForKey:[keysArray objectAtIndex:myIndexPath.section]];

        Appliance *someAppliance = [array objectAtIndex:myIndexPath.row];
        
         NSString *groupObject = [keysArray objectAtIndex:myIndexPath.section];
        
        groupObject = [NSString stringWithFormat:@"%@ - %@",[keysArray objectAtIndex:myIndexPath.section], someAppliance.label];
        
        ButtonsViewController *buttonsViewController = [segue destinationViewController];

        buttonsViewController.appliance = someAppliance;
        buttonsViewController.groupName = groupObject;
      
        }
}

- (IBAction)settingsButtonAction:(id)sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Sort!"
                                 message:@"Select the way of sorting"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *numberButton = [UIAlertAction
                               actionWithTitle:@"Button Number"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   [self sortWithKey:@"buttonNumber"];
                                   [self.tableView reloadData];

                               }];
    UIAlertAction *labelButton = [UIAlertAction
                                actionWithTitle:@"Button Label"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self sortWithKey:@"label"];
                                    [self.tableView reloadData];

                                }];
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];

    
    [alert addAction:numberButton];
    [alert addAction:labelButton];
    [alert addAction:cancelButton];
    

    [self presentViewController:alert animated:YES completion:nil];
}

-(void)sortWithKey:(NSString *)key{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSArray *sortedArray = [_hallArray sortedArrayUsingDescriptors:sortDescriptors];
    [_hallArray removeAllObjects];
    [_hallArray addObjectsFromArray:sortedArray];
    sortedArray = nil;
    
    sortedArray = [_bedRoomArray sortedArrayUsingDescriptors:sortDescriptors];
    [_bedRoomArray removeAllObjects];
    [_bedRoomArray addObjectsFromArray:sortedArray];
    sortedArray = nil;
    
    sortedArray = [_kitchenArray sortedArrayUsingDescriptors:sortDescriptors];
    [_kitchenArray removeAllObjects];
    [_kitchenArray addObjectsFromArray:sortedArray];
    sortedArray = nil;

}
- (IBAction)addNewButtonAction:(id)sender {
    AddButtonViewController *addButtonVC = [[AddButtonViewController alloc]initWithNibName:nil bundle:nil];
    Appliance *appliance = [[Appliance alloc]init];
    addButtonVC.addButton = YES;
    addButtonVC.delegate = self;
    addButtonVC.appliance = appliance;
    
    addButtonVC.addApplianceCompletionBlock = ^void (Appliance *appliance, NSArray *groups) {
        if ([groups[0] isEqualToString:@"1"]) {
            [_hallArray addObject:[appliance copy]];
        }
        if (([groups[1] isEqualToString:@"1"])){
            [_kitchenArray addObject:[appliance copy]];
        }
        if (([groups[2] isEqualToString:@"1"])){
            [_bedRoomArray addObject:[appliance copy]];
        }
        
        [self.tableView reloadData];
    };
    
    [[self navigationController] pushViewController:addButtonVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *keysArray = [_groupsDict allValues];
        
        NSMutableArray *array = [keysArray objectAtIndex:indexPath.section];
        
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Delete"
                                      message:@"Do you want to delete?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"No"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [array removeObjectAtIndex:indexPath.row];
                             [self.tableView reloadData];
                         }];

        [alert addAction:cancel];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - AddButtonProtocol
-(void)addAppliance:(Appliance *)appliance inGroups:(NSArray *)groups{

//    if ([groups[0] isEqualToString:@"1"]) {
//        [_hallArray addObject:[appliance copy]];
//    }
//    if (([groups[1] isEqualToString:@"1"])){
//        [_kitchenArray addObject:[appliance copy]];
//    }
//    if (([groups[2] isEqualToString:@"1"])){
//        [_bedRoomArray addObject:[appliance copy]];
//    }
//
//    [self.tableView reloadData];

}

@end
