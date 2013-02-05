//
//  ViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 18/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "LoginViewController.h"
#import <objc/message.h>
#define USERNAME @"omar"
#define PASSWORD @"sinte"
//#define IMEI [DeviceInfo getUUDID]
//#define SERIAL [DeviceInfo getMacAddress]
#define IMEI @"1qaz"
#define SERIAL @"1234"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"device %@ uudid %@ macaddress %@",[DeviceInfo getModel],[DeviceInfo getUUDID],[DeviceInfo getMacAddress]);
    UITapGestureRecognizer *dismissRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard)];
    [self.view addGestureRecognizer:dismissRecognizer];
    //nombreTF.text=USERNAME;
    //passTF.text=PASSWORD;
    container.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.7];
    container.layer.cornerRadius=10;
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *userDic=[file getDictionary:@"User"];
    nombreTF.text=[userDic objectForKey:@"username"];
    passTF.text=[userDic objectForKey:@"password"];
    
    [self loadNextViewController];
}
-(void)viewWillAppear:(BOOL)animated{
    frameInicial=CGRectMake(733, 187, 231, 173);
    frameFinal=CGRectMake(733, 323, 231, 173);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma text delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    touchFlag=YES;
    [self animarHasta:frameInicial];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.01];
}
-(void)delayed{
    if (!touchFlag) {
        [self animarHasta:frameFinal];
    }
}
#pragma mark animacion
-(void)animarHasta:(CGRect)hasta{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    container.frame=hasta;
    [UIView commitAnimations];
}
#pragma mark dismiss keyboard
-(void)resignKeyboard{
    [nombreTF resignFirstResponder];
    [passTF resignFirstResponder];
}
#pragma mark acciones
-(IBAction)irAlDashboard{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Cargando", nil);
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    NSString *params=[NSString stringWithFormat:@"<user>%@</user><pass>%@</pass><imei>%@</imei><serial>%@</serial>",nombreTF.text,passTF.text,IMEI,SERIAL];
    //NSString *params=[NSString stringWithFormat:@"<imei>%@</imei><serial>%@</serial>",IMEI,SERIAL];
    [server callServerWithMethod:@"login" andParameter:params];
}
-(void)loadNextViewController{
    DashBoardViewController *dVC=[[DashBoardViewController alloc]init];
    dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
    [self.navigationController pushViewController:dVC animated:YES];
}
#pragma mark server response
-(void)receivedDataFromServer:(id)sender{
    ServerCommunicator *server=sender;
    if ([[server.resDic objectForKey:@"conexion"] isEqualToString:@"true"]) {
        FileSaver *file=[[FileSaver alloc]init];
        NSMutableDictionary *userDic=[[NSMutableDictionary alloc]init];
        [userDic setObject:nombreTF.text forKey:@"username"];
        [userDic setObject:passTF.text forKey:@"password"];
        [file setDictionary:userDic withName:@"User"];
        [self loadNextViewController];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)receivedDataFromServerWithError:(id)sender{
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *userDic=[file getDictionary:@"User"];
    if ([[userDic objectForKey:@"username"] isEqualToString:nombreTF.text]) {
        if ([[userDic objectForKey:@"password"] isEqualToString:passTF.text]) {
            [self loadNextViewController];
        }
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
