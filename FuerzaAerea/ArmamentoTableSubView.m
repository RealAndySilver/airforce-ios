//
//  ArmamentoTableSubView.m
//  FuerzaAerea
//
//  Created by Andres Abril on 5/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "ArmamentoTableSubView.h"

@implementation ArmamentoTableSubView

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
        [self setLabelWithText:@"ID Armamento" position:5 andWidth:200 inThisView:header];
        [self setDivisionInPosition:205 onView:header];
        [self setLabelWithText:@"Armamento" position:215 andWidth:700 inThisView:header];
        [self setDivisionInPosition:915 onView:header];
        [self setLabelWithText:@"Cantidad" position:920 andWidth:100 inThisView:header];
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
    rows=ordenDeVuelo.arregloDeArmamento.count;
    return rows;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"a1";
    
    ArmamentoCell *celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (celda == nil) {
        celda = [[ArmamentoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
