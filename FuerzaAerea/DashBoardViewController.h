//
//  DashBoardViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewerController.h"
#import "ServerCommunicator.h"
#import "ImageDownloader.h"
#import "MBProgressHud.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Metar.h"
#import "Notam.h"
#import "FileSaver.h"
#import "ModeladorDeOrdenDeVuelo.h"
#import "OrdenDeVueloMenuViewController.h"
#import "Archivo.h"
#import "RegistroDeVueloViewController.h"
#import "FaseVuelo.h"
#import "Departamentos.h"
#import "Armamentos.h"
#import "Lista.h"
#import "TutorialViewController.h"
#import "DeviceInfo.h"
#import "IAmCoder.h"
#import "ZoomViewController.h"
@interface DashBoardViewController : UIViewController<UITextFieldDelegate,UISearchBarDelegate,UIDocumentInteractionControllerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>{
    IBOutlet UIView *containerOV;
    IBOutlet UIView *containerMetar;

    IBOutlet UITextField *ovTF;
    IBOutlet UITextField *matriTF;

    IBOutlet UITextField *mtTF;
    
    IBOutlet UISwitch *notamSwitch;
    IBOutlet UISwitch *metarSwitch;
    IBOutlet UISwitch *conservarSwitch;
    
    //IBOutlet UISearchDisplayController *leftSearchBar;

    IBOutlet UITableView *leftTableView;
    NSMutableArray *leftTableArray;
    NSMutableDictionary *leftSectionDictionary;

    NSMutableArray *leftTableResults;
    NSArray *leftStaticArray;
    
    IBOutlet UITableView *rightTableView;
    NSMutableArray *rightTableMetarArray;
    NSMutableArray *rightTableMetarArrayParcial;
    NSMutableArray *rightTableMetarArrayFijo;

    NSMutableArray *rightTableNotamArray;
    NSMutableArray *rightTableNotamArrayParcial;
    NSMutableArray *rightTableNotamArrayFijo;

    CGRect frameInicialOV;
    CGRect frameFinalOV;
    
    CGRect frameInicialMT;
    CGRect frameFinalMT;
    CGRect searchInicialMT;
    CGRect searchFinalMT;

    BOOL touchFlag;
    
    MBProgressHUD *hud;
    
    NSMutableArray *serverFileArray;
    
    ModeladorDeOrdenDeVuelo *ordenDeVuelo;
    
    NSMutableArray *arrayFaseVuelo;
    NSMutableArray *arrayDepartamentos;
    NSMutableArray *arrayMunicipios;
    NSMutableArray *arrayArmamentos;
    
    Lista *lista;
    
    NSMutableArray *arrayForBool;

}
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (weak, nonatomic) IBOutlet UISearchBar *leftSearchBar;

@end
