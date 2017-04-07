//
//  ButtonsViewController.m
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/11/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import "ButtonsViewController.h"
#import "AddButtonViewController.h"

@interface ButtonsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic) NSArray *detailArray, *applianceArray;

@end

@implementation ButtonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _detailArray = [NSArray arrayWithObjects:@"Label",@"Button Number",@"ipAdderss",@"Telnet Port",@"User Name",@"Password",@"Telnet Strings" ,nil];

    _applianceArray = [NSArray arrayWithObjects: _appliance.label, _appliance.buttonNumber, _appliance.ipAddress, _appliance.telnetPort, _appliance.userName,_appliance.password,_appliance.telnetStrings , nil];
    
    UIButton *editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-80, self.view.frame.size.width, 80)];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    editButton.tintColor = [UIColor whiteColor];
    editButton.backgroundColor = [UIColor colorWithRed:132/255.0 green:201/255.0 blue:158/255.0 alpha:1.0];
    [editButton addTarget:self action:@selector(editPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
    
    self.title = _groupName;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_applianceArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    
    NSString *cellString = [NSString stringWithFormat:@"  %@",[_detailArray objectAtIndex:indexPath.row]];
    
    UILabel *detailLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width/2, cell.frame.size.height)];
    detailLable.text = cellString;
    [cell addSubview:detailLable];
    
    UILabel *applianceLable = [[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width/2, 0, cell.frame.size.width/2, cell.frame.size.height)];
    applianceLable.text = [_applianceArray objectAtIndex:indexPath.row];
    applianceLable.textColor = [UIColor blueColor];
    applianceLable.adjustsFontSizeToFitWidth = YES;
    applianceLable.font = [UIFont boldSystemFontOfSize:18];
    [cell addSubview:applianceLable];
    
    return cell;
    
}

-(void)editPressed:(UIButton *)sender{
    AddButtonViewController *addButtonVC = [[AddButtonViewController alloc]initWithNibName:nil bundle:nil];
    addButtonVC.appliance = _appliance;
    addButtonVC.addButton = NO;
    addButtonVC.delegate = self;
    [[self navigationController] pushViewController:addButtonVC animated:YES];

}

-(void)addAppliance:(Appliance *)appliance inGroups:(NSArray *)groups{
    _appliance = appliance;
    _applianceArray = [NSArray arrayWithObjects: _appliance.label, _appliance.buttonNumber, _appliance.ipAddress, _appliance.telnetPort, _appliance.userName,_appliance.password,_appliance.telnetStrings , nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
