//
//  ViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 18/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "LoginViewController.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
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
    NSLog(@"device %@ uudid %@ macaddress %@",[DeviceInfo getModel],[DeviceInfo getUUDID],[DeviceInfo getMacAddress]);
    
    UITapGestureRecognizer *dismissRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard)];
    [self.view addGestureRecognizer:dismissRecognizer];
    //nombreTF.text=USERNAME;
    //passTF.text=PASSWORD;
    container.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.7];
    container.layer.cornerRadius=10;
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *userDic = [file getDictionary:@"User"];
    nombreTF.text = [userDic objectForKey:@"username"];
    //passTF.text=[userDic objectForKey:@"password"];
    FileSaver *file2=[[FileSaver alloc]init];
    if (![file2 getIp]) {
        [file2 setIP:@"172.20.100.6:8989"];
    }
    //[self loadNextViewController];
    /*NSArray *numberVerifyingArray=[[NSArray alloc]initWithObjects:
                                   @"12",
                                   @"12",
                                   @"1234",
                                   @"1234",
                                   @"11",
                                   @"123",
                                   @"01a",nil];
    
    BOOL esNumero=[self isAllDigitsFromArray:numberVerifyingArray];
    if (!esNumero) {
        NSLog(@"No Hay números");
        [self stopAlert];
        return;
    }
    else{
        NSLog(@"Si Hay números");
    }*/

    vendorLabel.text = [NSString stringWithFormat:@"ID Único: %@",[UIDevice currentDevice].identifierForVendor.UUIDString];
}

-(void)viewWillAppear:(BOOL)animated{
    frameInicial=CGRectMake(733, 187, 231, 205);
    frameFinal=CGRectMake(733, 323, 231, 205);
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
    if ([nombreTF.text isEqualToString:@"admin"] && [passTF.text isEqualToString:@"admin"]) {
        AdminViewController *adVC=[[AdminViewController alloc]init];
        adVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Admin"];
        [self.navigationController pushViewController:adVC animated:YES];
        return;
    }
    FileSaver *temp=[[FileSaver alloc]init];
    //[temp setDictionary:[NSDictionary dictionaryWithObject:[NSString base64StringFromData:[IAmCoder md5:passTF.text] length:[[IAmCoder md5:passTF.text] length]] forKey:@"sha"] withName:@"Temp"];
    [temp setDictionary:[NSDictionary dictionaryWithObject:@"WVRJjNZ2Ml5yE0sC" forKey:@"sha"] withName:@"Temp"];

    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Cargando", nil);
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    //NSString *key=[[temp getDictionary:@"Temp"] objectForKey:@"sha"] ;
    NSString *key=[IAmCoder dateKey];
    NSLog(@"DateKey == %@",key);
    NSLog(@"la llave %@",[DeviceInfo getUUDID]);
    NSString *params=[NSString stringWithFormat:@"<user>%@</user><pass>%@</pass><uuid>%@</uuid><macaddress>%@</macaddress><passcode>%@</passcode>",[IAmCoder encryptAndBase64:nombreTF.text withKey:key],[IAmCoder encryptAndBase64:passTF.text withKey:key],[IAmCoder encryptAndBase64:[DeviceInfo getUUDID] withKey:key],[IAmCoder encryptAndBase64:[DeviceInfo getMacAddress] withKey:key], [IAmCoder encryptAndBase64:tokenTF.text withKey:key]];
    //Zif1sbIcOxHWcei/RXccwg==</user><pass>IJaKbJAepuX9WPAOdqLvdg==
    //NSString *params=[NSString stringWithFormat:@"<user>%@</user><pass>%@</pass><uuid>%@</uuid><macaddress>%@</macaddress>",[IAmCoder encryptAndBase64:@"siio" withKey:key],[IAmCoder encryptAndBase64:@"siioplmnko0" withKey:key],[IAmCoder encryptAndBase64:@"11" withKey:key],[IAmCoder encryptAndBase64:@"1" withKey:key]];
    NSLog(@"Params: %@",params);
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
    NSLog(@"Resultado %@",server.resDic);
    BOOL conexion = [[server.resDic objectForKey:@"conexion"] boolValue];;
    if (conexion) {
        FileSaver *file=[[FileSaver alloc]init];
        NSMutableDictionary *userDic=[[NSMutableDictionary alloc]init];
        if (nombreTF.text) {
            [userDic setObject:nombreTF.text forKey:@"username"];
        }
        if (passTF.text) {
            [userDic setObject:passTF.text forKey:@"password"];
        }
        [file setDictionary:userDic withName:@"User"];
        [self loadNextViewController];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Usuario o contraseña inválidos. Por favor intente de nuevo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //[self loadNextViewController];
}
-(void)receivedDataFromServerWithError:(id)sender{
    FileSaver *file=[[FileSaver alloc]init];
    NSDictionary *userDic=[file getDictionary:@"User"];
    if ([[userDic objectForKey:@"username"] isEqualToString:nombreTF.text]) {
        if ([[userDic objectForKey:@"password"] isEqualToString:passTF.text]) {
            [self loadNextViewController];
        }
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"El usuario ingresado no se encuentra registrado en la aplicación offline. Por favor conéctese a una red disponible e inténtelo nuevamente." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark number check
- (BOOL) isAllDigitsFromArray:(NSArray*)array
{
    for (NSString *string in array) {
        NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSRange r = [string rangeOfCharacterFromSet: nonNumbers];
        if (r.location != NSNotFound) {
            return NO;
        }
        NSLog(@"Hay");
    }
    return YES;
}
- (void) stopAlert{
    NSString *titulo=@"Error";
    NSString *mensaje=@"Su registro no pudo ser enviado ya que contiene un elemento no numérico en un campo numérico. Por favor verifique y vuelva a intentarlo.";
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:titulo message:mensaje delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
