//
//  TeplasTableSubView.h
//  FuerzaAerea
//
//  Created by Andres Abril on 9/02/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeladorDeOrdenDeVuelo.h"
#import "TeplasCell.h"

@interface TeplasTableSubView : UIView<UITableViewDataSource,UITableViewDelegate>{
    ModeladorDeOrdenDeVuelo *ordenDeVuelo;
    id viewController;
}
- (id)initWithFrame:(CGRect)frame ordenDeVuelo:(ModeladorDeOrdenDeVuelo*)laOrdenDeVuelo yCaller:(id)caller;
@end
