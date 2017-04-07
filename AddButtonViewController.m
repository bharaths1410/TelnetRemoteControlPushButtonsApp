//
//  AddButtonViewController.m
//  TelnetRemoteControlPushButtonsApp
//
//  Created by Bharath Sirangi on 2/14/17.
//  Copyright © 2017 Bharath Sirangi. All rights reserved.
//

#import "AddButtonViewController.h"
#import "ViewController.h"

@interface AddButtonViewController ()

@property IBOutlet UITableView *tableView;

@property(nonatomic) NSArray *detailArray, *applianceArray, *groupsArray;
@property(nonatomic) NSMutableArray *groupsSelectionArray;
@property(nonatomic) UIButton *doneButton;
@property(nonatomic) BOOL rowSelected;

@end

@implementation AddButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_addButton == YES) {
        self.title = @"New Button";
    }
    else{
        self.title = @"Edit Button";
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    [self.view addSubview:_tableView];
    
    _groupsArray =[NSMutableArray arrayWithObjects:@"Hall",@"Kitchen",@"Bed Room", nil];
    _groupsSelectionArray =[NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
    
    _detailArray = [NSArray arrayWithObjects:@"Label",@"Button Number",@"ipAdderss",@"Telnet Port",@"User Name",@"Password",@"Telnet Strings" ,nil];
    
    _applianceArray = [NSArray arrayWithObjects: _appliance.label, _appliance.buttonNumber, _appliance.ipAddress, _appliance.telnetPort, _appliance.userName,_appliance.password,_appliance.telnetStrings , nil];
    
    _doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_doneButton setTitle:@"DONE" forState:UIControlStateNormal];
    _doneButton.tintColor = [UIColor whiteColor];
    _doneButton.backgroundColor = [UIColor colorWithRed:222/255.0 green:81/255.0 blue:69/255.0 alpha:1.0];
    [_doneButton addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bottomDoneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    [bottomDoneButton setTitle:@"DONE" forState:UIControlStateNormal];
    bottomDoneButton.tintColor = [UIColor whiteColor];
    bottomDoneButton.backgroundColor = [UIColor colorWithRed:222/255.0 green:81/255.0 blue:69/255.0 alpha:1.0];
    [bottomDoneButton addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomDoneButton];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_addButton == YES) {
        return 2;
    }
    else{
        return 1;
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"Button Details";
    }
    else{
        return @"Groups";
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_detailArray count];
    }
    else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
   
    
    if (indexPath.section == 0) {

        UILabel *detailLable =(UILabel *) [cell viewWithTag:100];
        if (detailLable == nil ) {
            detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, cell.frame.size.width/2, cell.frame.size.height)];
            detailLable.tag = 100;
            [cell addSubview:detailLable];
        }
        
        detailLable.text = [_detailArray objectAtIndex:indexPath.row];
       
        UITextField *entryTextField = (UITextField *) [cell viewWithTag:101];
        if (entryTextField == nil) {
            entryTextField = [[UITextField alloc]initWithFrame:CGRectMake(cell.frame.size.width/2, 0, self.view.frame.size.width/2, cell.frame.size.height)];
            entryTextField.tag = 101;
            [cell addSubview:entryTextField];
        }
        entryTextField.textColor = [UIColor blueColor];
        entryTextField.delegate = self;
        entryTextField.keyboardType = [self getAllowedKeyBoardTypeForEntryIndex:indexPath.row];
        entryTextField.font = [UIFont boldSystemFontOfSize:18];
        if (indexPath.row != 6) {
            entryTextField.inputAccessoryView = _doneButton;
        }
        if (indexPath.row == 5) {
            entryTextField.secureTextEntry = YES;
        }
        else {
            entryTextField.secureTextEntry = NO;
        }
        
        if (_addButton == NO) {
            entryTextField.text = [_applianceArray objectAtIndex:indexPath.row];
        }
        else{
            entryTextField.placeholder = @"Enter Text Here.";
        }
        
    }
    else{
        UIImageView *check = (UIImageView *)[cell viewWithTag:102];
        if (check == nil) {
            check = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-40, 10, 25, 25)];
            check.tag = 102;
            [cell addSubview:check];
        }
        
        if ([_groupsSelectionArray[indexPath.row] isEqualToString:@"1"]) {
            [check setImage:[UIImage imageNamed:@"CheckedCheckbox.png"]];
        }else{
            [check setImage:[UIImage imageNamed:@"UncheckedCheckbox.png"]];
        }
        
        
        
        cell.textLabel.text = [_groupsArray objectAtIndex:indexPath.row];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
    if ([_groupsSelectionArray[indexPath.row] isEqualToString:@"1"]) {
        _groupsSelectionArray[indexPath.row] = @"0";
    }else {
        _groupsSelectionArray[indexPath.row] = @"1";
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}
- (void) textFieldDidBeginEditing:(UITextField *)textField {
    UITableViewCell *cell;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        cell = (UITableViewCell *) textField.superview.superview;
        
    } else {
        cell = (UITableViewCell *) textField.superview.superview.superview;
    }
    [_tableView scrollToRowAtIndexPath:[_tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    UITableViewCell *cell = (UITableViewCell *)textField.superview ;
    
    NSIndexPath *indexpath = [_tableView indexPathForCell:cell];
    
    switch (indexpath.row) {
        case 0:
            _appliance.label = textField.text;
            break;
        case 1:
            _appliance.buttonNumber = textField.text;
            break;
        case 2:
            _appliance.ipAddress = textField.text;
            break;
        case 3:
            _appliance.telnetPort = textField.text;
            break;
        case 4:
            _appliance.userName = textField.text;
            break;
        case 5:
            _appliance.password = textField.text;
            break;
        case 6:
            _appliance.telnetStrings = textField.text;
            break;
            
        default:
            break;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)donePressed:(UIButton *)sender{
    [self.tableView endEditing:YES];
    
    if (_appliance.label.length == 0 || _appliance.buttonNumber.length==0 || _appliance.ipAddress.length==0|| _appliance.telnetPort.length==0|| _appliance.userName.length==0|| _appliance.password.length==0|| _appliance.telnetStrings.length == 0) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Note!"
                                     message:@"Please enter Text for all fields"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OkButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        [alert addAction:OkButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if (_addButton == YES &&[_groupsSelectionArray[0] isEqualToString:@"0"] && [_groupsSelectionArray[1] isEqualToString:@"0"]&&[_groupsSelectionArray[2] isEqualToString:@"0"]){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Group"
                                     message:@"Please select minimum one group"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OkButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        [alert addAction:OkButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Save"
                                     message:@"Do you want to save"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noButton = [UIAlertAction
                                   actionWithTitle:@"No"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        UIAlertAction *yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        Appliance *info = _appliance;
                                        [[self delegate] addAppliance:info inGroups:[[NSArray alloc] initWithArray:_groupsSelectionArray]];
                                        self.addApplianceCompletionBlock(info, [[NSArray alloc] initWithArray:_groupsSelectionArray]);
                                        [self.navigationController popViewControllerAnimated:YES];
                                        
                                    }];
        [alert addAction:noButton];
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

-(UIKeyboardType)getAllowedKeyBoardTypeForEntryIndex:(NSInteger)row{
    
    UIKeyboardType type = UIKeyboardTypeDefault;
    switch (row) {
        case 1:
        case 3:
            type = UIKeyboardTypeNumberPad;
            break;
        case 2:
            type = UIKeyboardTypeNumbersAndPunctuation;
            break;
            
        default:
            type = UIKeyboardTypeDefault;
            break;
    }
    
    return type;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
