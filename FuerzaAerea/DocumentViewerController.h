//
//  DocumentViewerController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 8/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentViewerController : UIViewController{
    IBOutlet UIWebView *webView;
}
@property(nonatomic,retain)NSString *path;
@end
