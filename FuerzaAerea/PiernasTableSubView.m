//
//  PiernasTableSubView.m
//  FuerzaAerea
//
//  Created by Andres Abril on 5/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "PiernasTableSubView.h"
#import "OrdenDeVueloMenuViewController.h"
@implementation PiernasTableSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame ordenDeVuelo:(ModeladorDeOrdenDeVuelo*)laOrdenDeVuelo yCaller:(id)caller
{
    self = [super initWithFrame:frame];
    if (self) {
        ordenDeVuelo=laOrdenDeVuelo;
        viewController=caller;
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        header.backgroundColor=[UIColor colorWithRed:0.4 green:0.8 blue:0.9 alpha:1];
        [self addSubview:header];
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30)];
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.backgroundColor=[UIColor clearColor];
        [self addSubview:tableView];
        [self setLabelWithText:@"No." position:5 andWidth:30 inThisView:header];
        [self setDivisionInPosition:38 onView:header];
        [self setLabelWithText:@"Desde" position:45 andWidth:80 inThisView:header];
        [self setDivisionInPosition:250 onView:header];
        [self setLabelWithText:@"Hasta" position:255 andWidth:80 inThisView:header];
        [self setDivisionInPosition:450 onView:header];
        [self setLabelWithText:@"Operación Tipo" position:455 andWidth:150 inThisView:header];
        [self setDivisionInPosition:650 onView:header];
        [self setLabelWithText:@"Operación" position:655 andWidth:100 inThisView:header];
        [self setDivisionInPosition:845 onView:header];
        [self setLabelWithText:@"Plan" position:850 andWidth:100 inThisView:header];
    }
    return self;
}
-(void)setLabelWithText:(NSString*)text position:(int)position andWidth:(int)width inThisView:(UIView*)view{
    UIColor *bgcolor=[UIColor clearColor];
    UIColor *textcolor=[UIColor whiteColor];
    UILabel *noLabel=[[UILabel alloc]initWithFrame:CGRectMake(position, 0, width, 30)];
    noLabel.backgroundColor=bgcolor;
    noLabel.text=text;
    noLabel.textColor=textcolor;
    noLabel.font=[UIFont boldSystemFontOfSize:18];
    [view addSubview:noLabel];
}
-(void)setDivisionInPosition:(int)position onView:(UIView*)view{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(position, 0, 1, view.frame.size.height)];
    line.backgroundColor=[UIColor grayColor];
    [view addSubview:line];
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
    rows=ordenDeVuelo.arregloDePiernas.count;
    return rows;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"";
    
    PiernasCell2 *celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (celda == nil) {
        celda = [[PiernasCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [celda setSelectionStyle:UITableViewCellSelectionStyleGray];
    Piernas *pierna=[ordenDeVuelo.arregloDePiernas objectAtIndex:indexPath.row];
    celda.plan.text=pierna.plan;
    celda.piernaNumero.text=pierna.piernaNumero;
    celda.operacionTipo.text=pierna.operacionTipo;
    celda.operacion.text=pierna.operacion;
    celda.desde.text=pierna.desdeAerodromo;
    celda.hasta.text=pierna.hastaAerodromo;
    
    return celda;
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *iAVC=[[DetailViewController alloc]init];
    OrdenDeVueloMenuViewController *ovVC=viewController;
    iAVC=[ovVC.storyboard instantiateViewControllerWithIdentifier:@"InfoAero"];
    Piernas *piernas=[ordenDeVuelo.arregloDePiernas objectAtIndex:indexPath.row];
    iAVC.delegatedString=[NSString stringWithFormat:@"Entidad Apoyada: %@ \nDescripción de la misión: %@\nDe: %@\nA: %@",piernas.entidadApoyada,piernas.descripcionMision,piernas.de,piernas.a];
    iAVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //iaVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    iAVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [ovVC presentViewController:iAVC animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
