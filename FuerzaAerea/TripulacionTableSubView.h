//
//  TripulacionTableSubView.h
//  FuerzaAerea
//
//  Created by Andres Abril on 5/02/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeladorDeOrdenDeVuelo.h"
#import "DetailViewController.h"
#import "PiernasCell2.h"
#import "ArmamentoCell.h"
#import "TripulacionCell.h"
@interface TripulacionTableSubView : UIView<UITableViewDataSource,UITableViewDelegate>{
    ModeladorDeOrdenDeVuelo *ordenDeVuelo;
    id viewController;
}
- (id)initWithFrame:(CGRect)frame ordenDeVuelo:(ModeladorDeOrdenDeVuelo*)laOrdenDeVuelo yCaller:(id)caller;
@end
