//
//  TeplasCell.m
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "TeplasCell.h"

@implementation TeplasCell

@synthesize persona_id,orden_vuelo_id,tipo,grado,teplas_orden_id,nombre_tipo,notificado, nombre, cargo;
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
        
//        grado=[[UILabel alloc]init];
//        [self createLabelWithPosition:450 andWidth:195 andLabel:grado];
//        
//        teplas_orden_id=[[UILabel alloc]init];
//        [self createLabelWithPosition:650 andWidth:190 andLabel:teplas_orden_id];
//        
//        nombre_tipo=[[UILabel alloc]init];
//        [self createLabelWithPosition:850 andWidth:170 andLabel:nombre_tipo];
//        
//        notificado=[[UILabel alloc]init];
//        [self createLabelWithPosition:850 andWidth:170 andLabel:notificado];
        
        [self setDivisionInPosition:80];
        [self setDivisionInPosition:880];
//        [self setDivisionInPosition:450];
//        [self setDivisionInPosition:650];
//        [self setDivisionInPosition:845];
        
        
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
    line.backgroundColor=[UIColor blackColor];
    [self addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

