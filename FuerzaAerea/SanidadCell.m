//
//  SanidadCell.m
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "SanidadCell.h"

@implementation SanidadCell

@synthesize persona_id,orden_vuelo_id,cargo,grado,sanidad_orden_id,notificado,nombre;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        cargo=[[UILabel alloc]init];
        [self createLabelWithPosition:0 andWidth:80 andLabel:cargo];
        
        nombre=[[UILabel alloc]init];
        [self createLabelWithPosition:80 andWidth:800 andLabel:nombre];
        
        grado=[[UILabel alloc]init];
        [self createLabelWithPosition:880 andWidth:120 andLabel:grado];
        
        [self setDivisionInPosition:80];
        [self setDivisionInPosition:880];
        
    }
    return self;
}
-(void)createLabelWithPosition:(int)position andWidth:(int)width andLabel:(UILabel*)theLabel{
    UILabel *label=theLabel;
    label.frame=CGRectMake(position, 5, width, 90);
    UIColor *bgcolor=[UIColor clearColor];
    UIColor *textcolor=[UIColor blackColor];
    label.numberOfLines=3;
    label.backgroundColor=bgcolor;
    label.textColor=textcolor;
    label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:label];
}
-(void)setDivisionInPosition:(int)position{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(position, 0, 1, 100)];
    line.backgroundColor=[UIColor grayColor];
    [self addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
