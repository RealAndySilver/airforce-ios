//
//  DashBoardViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "DashBoardViewController.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    frameInicialOV=CGRectMake(804, 568, 220, 180);
    frameFinalOV=CGRectMake((self.view.frame.size.width/2)+27.5,
                            (self.view.frame.size.height/2)/2,
                            220,
                            180);
    frameInicialMT=CGRectMake(634, 45, 211, 105);
    frameFinalMT=CGRectMake((self.view.frame.size.width/2)+27.5,
                            ((self.view.frame.size.height/2)/2)+40,
                            211,
                            105);
    searchInicialMT=CGRectMake(0, 45, 298, 44);
    searchFinalMT=CGRectMake(0,
                            (self.view.frame.size.height/3)+12,
                            self.view.frame.size.height,
                            44);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma text delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    touchFlag=YES;
    if (textField.tag==1000) {
        [self animarView:containerOV Hasta:frameFinalOV];
        [self animarView:containerMetar Hasta:frameInicialMT];
        [self animarView:leftSearchBar Hasta:searchInicialMT];
    }
    else if(textField.tag==1001){
        [self animarView:containerMetar Hasta:frameFinalMT];
        [self animarView:containerOV Hasta:frameInicialOV];
        [self animarView:leftSearchBar Hasta:searchInicialMT];
    }
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    touchFlag=YES;
    [self animarView:leftSearchBar Hasta:searchFinalMT];
    [self animarView:containerOV Hasta:frameInicialOV];
    [self animarView:containerMetar Hasta:frameInicialMT];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.001];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.001];
}
-(void)delayed{
    if (!touchFlag) {
        [self animarView:containerOV Hasta:frameInicialOV];
        [self animarView:containerMetar Hasta:frameInicialMT];
        [self animarView:leftSearchBar Hasta:searchInicialMT];
    }
}

#pragma mark animacion
-(void)animarView:(UIView*)view Hasta:(CGRect)hasta{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.frame=hasta;
    [UIView commitAnimations];
}
#pragma mark dismiss keyboard
-(void)resignKeyboard{
    [ovTF resignFirstResponder];
}
@end
