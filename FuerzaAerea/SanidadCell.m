//
//  SanidadCell.m
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "SanidadCell.h"

@implementation SanidadCell

@synthesize persona_id,orden_vuelo_id,cargo,grado,sanidad_orden_id,notificado;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        persona_id=[[UILabel alloc]init];
        [self createLabelWithPosition:0 andWidth:35 andLabel:persona_id];
        
        orden_vuelo_id=[[UILabel alloc]init];
        [self createLabelWithPosition:40 andWidth:205 andLabel:orden_vuelo_id];
        
        cargo=[[UILabel alloc]init];
        [self createLabelWithPosition:250 andWidth:195 andLabel:cargo];
        
        grado=[[UILabel alloc]init];
        [self createLabelWithPosition:450 andWidth:195 andLabel:grado];
        
        sanidad_orden_id=[[UILabel alloc]init];
        [self createLabelWithPosition:650 andWidth:190 andLabel:sanidad_orden_id];
        
        notificado=[[UILabel alloc]init];
        [self createLabelWithPosition:850 andWidth:170 andLabel:notificado];
        
        [self setDivisionInPosition:38];
        [self setDivisionInPosition:250];
        [self setDivisionInPosition:450];
        [self setDivisionInPosition:650];
        [self setDivisionInPosition:845];
        
        
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
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(position, 0, 0.5, 100)];
    line.backgroundColor=[UIColor grayColor];
    [self addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
