//
//  TutorialViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 11/03/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    int numeroDePaginas=6;
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.height*numeroDePaginas, scrollView.frame.size.width);
    [scrollView setPagingEnabled:YES];
    [scrollView setAlwaysBounceHorizontal:YES];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [scrollView addGestureRecognizer:doubleTap];
    for (int i=0; i<numeroDePaginas; i++) {
        NSString *nombreImagen=[NSString stringWithFormat:@"%i.jpg",i];
        [self addImageNamed:nombreImagen inPosition:i];
    }
    
}
-(void)addImageNamed:(NSString*)name inPosition:(int)position{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
    imageView.frame=CGRectMake(scrollView.frame.size.height*position, 0, scrollView.frame.size.height, scrollView.frame.size.width);
    [scrollView addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handleDoubleTap:(UITapGestureRecognizer*)tap{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
