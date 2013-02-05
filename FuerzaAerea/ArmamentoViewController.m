//
//  ArmamentoViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 6/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "ArmamentoViewController.h"

@interface ArmamentoViewController ()

@end

@implementation ArmamentoViewController
@synthesize ordenDeVuelo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    unidadLabel.text=ordenDeVuelo.principal.unidad;
    unidadAsumeLabel.text=ordenDeVuelo.principal.unidadAsume;
    ordenLabel.text=ordenDeVuelo.principal.idOrdenVuelo;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark button actions
-(IBAction)buttonPressed:(UIButton*)sender{
    if (sender.tag==5) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    //NSLog(@"Button %i pressed",sender.tag);
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @" ";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}
- (UIView *) tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]];
    UILabel *titleHeader=[[UILabel alloc]initWithFrame:CGRectMake(10,0, 300, 20)];
    titleHeader.textColor=[UIColor whiteColor];
    titleHeader.backgroundColor=[UIColor clearColor];
    [headerView addSubview:titleHeader];
    
    return headerView;
}
- (UIView *) tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]];
    UILabel *titleHeader=[[UILabel alloc]initWithFrame:CGRectMake(10,0, 300, 20)];
    titleHeader.textColor=[UIColor whiteColor];
    titleHeader.backgroundColor=[UIColor clearColor];
    [headerView addSubview:titleHeader];
    
    return headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger rows=0;
    rows=ordenDeVuelo.arregloDeArmamento.count;
    return rows;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"a1";
    
    PiernasCell *celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (celda == nil) {
        celda = [[PiernasCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [celda setSelectionStyle:UITableViewCellSelectionStyleNone];
    Armamento *armamento=[ordenDeVuelo.arregloDeArmamento objectAtIndex:indexPath.row];
    celda.idArmamento.text=armamento.idArmamento;
    celda.armamento.text=armamento.armamento;
    celda.cantidad.text=armamento.cantidad;
    
    return celda;
}


#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
