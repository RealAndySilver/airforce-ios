//
//  PiernasCell2.m
//  FuerzaAerea
//
//  Created by Andres Abril on 5/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "PiernasCell2.h"

@implementation PiernasCell2
@synthesize operacion,operacionTipo,piernaNumero,hasta,desde,plan;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        piernaNumero=[[UILabel alloc]init];
        [self createLabelWithPosition:0 andWidth:35 andLabel:piernaNumero];
        
        desde=[[UILabel alloc]init];
        [self createLabelWithPosition:40 andWidth:205 andLabel:desde];
        
        hasta=[[UILabel alloc]init];
        [self createLabelWithPosition:250 andWidth:195 andLabel:hasta];
        
        operacionTipo=[[UILabel alloc]init];
        [self createLabelWithPosition:450 andWidth:195 andLabel:operacionTipo];
        
        operacion=[[UILabel alloc]init];
        [self createLabelWithPosition:650 andWidth:190 andLabel:operacion];
        
        plan=[[UILabel alloc]init];
        [self createLabelWithPosition:850 andWidth:170 andLabel:plan];
        
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
