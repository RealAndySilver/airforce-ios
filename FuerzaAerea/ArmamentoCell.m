//
//  ArmamentoCell.m
//  FuerzaAerea
//
//  Created by Andres Abril on 5/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "ArmamentoCell.h"

@implementation ArmamentoCell
@synthesize idArmamento,armamento,cantidad;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        idArmamento=[[UILabel alloc]init];
        [self createLabelWithPosition:5 andWidth:200 andLabel:idArmamento];
        
        armamento=[[UILabel alloc]init];
        [self createLabelWithPosition:215 andWidth:690 andLabel:armamento];
        
        cantidad=[[UILabel alloc]init];
        [self createLabelWithPosition:920 andWidth:100 andLabel:cantidad];
        
                
        [self setDivisionInPosition:205];
        [self setDivisionInPosition:915];
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
