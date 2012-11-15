//
//  DashBoardViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 30/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "DashBoardViewController.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController
@synthesize searchDisplayController,leftSearchBar;
- (void)viewDidLoad
{
    [super viewDidLoad];
    frameInicialOV=CGRectMake(804, 567, 220, 181);
    frameFinalOV=CGRectMake((self.view.frame.size.width/2)+27.5,
                            (self.view.frame.size.height/2)/2,
                            220,
                            181);
    frameInicialMT=CGRectMake(634, 45, 211, 107);
    frameFinalMT=CGRectMake((self.view.frame.size.width/2)+27.5,
                            ((self.view.frame.size.height/2)/2)+40,
                            211,
                            107);
    searchInicialMT=CGRectMake(0, 45, 298, 44);
    searchFinalMT=CGRectMake(0,
                            (self.view.frame.size.height/3)+12,
                            self.view.frame.size.height,
                            44);
    leftTableArray=[[NSMutableArray alloc]initWithObjects:@"pptexample.ppt",@"docexample.doc",@"pdf.pdf", nil];
    searchDisplayController.searchResultsTableView.frame=CGRectMake(0, 200, 300, 500);
    //[leftTableArray addObject:@"pptexample.ppt"];
    //[leftTableArray addObject:@"docexample.doc"];
    //[leftTableArray addObject:@"pdf.pdf"];
    
    
    rightTableArray = [[NSMutableArray alloc]init];
    [rightTableArray addObject:@"SKBO A1947/12 STRIP RWY 13L/31R AND ASSOCIATED TWY, WIP EXER CTN. H24, 26 JUN 02:40 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 02:40 2012"];
    [rightTableArray addObject:@"SKBO A1949/12 STRIP RWY 13R/31L AND ASSOCIATED TWY, WIP EXER CTN. H24, 26 JUN 02:40 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 02:51 2012"];
    [rightTableArray addObject:@"SKBO A1950/12 STRIP TWY A AND F, WIP EXER CTN. H24, 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 03:06 2012 "];
    [rightTableArray addObject:@"SKBO A1955/12 STRIP TWY R AND TWY S, WIP EXER CTN. H24, 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 03:37 2012"];
    [rightTableArray addObject:@"SKBO A1956/12 STRIP TWY M, WIP EXER CTN. 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 01 JUL 05:59 2012"];
    [rightTableArray addObject:@"SKBO A1957/12 STRIP TWY D BTN TWY A AND TWY M, WIP EXER CTN. H24, 01 JUL 00:00 2012 UNTIL 31 DEC 23:59 2012. CREATED: 26 JUN 05:01 2012"];
    
    
    NSLog (@"%d subviews", [self.searchDisplayController.searchContentsController.view.subviews count]);
    for (int i = 0; i < [self.searchDisplayController.searchContentsController.view.subviews count]; i++)
    {
        id view = [self.searchDisplayController.searchContentsController.view.subviews objectAtIndex:i];
        NSRange rng = [[view description] rangeOfString:@"UIControl"];
        if (rng.length != 0)
        {
            UIView * backgroundView = (UIView*)view;
            CGRect frame = leftTableView.frame;
            frame.size.height = self.searchDisplayController.searchContentsController.view.frame.size.height;
            backgroundView.frame = frame;
        }
        
        //NSLog (@"%@", view);
    }
    containerOV.layer.borderColor=[UIColor darkGrayColor].CGColor;
    containerOV.layer.borderWidth=2;
    containerOV.layer.cornerRadius=10;
    containerMetar.layer.borderColor=[UIColor darkGrayColor].CGColor;
    containerMetar.layer.cornerRadius=10;
    containerMetar.layer.borderWidth=2;
    
    notamSwitch.onTintColor=[UIColor grayColor];
    metarSwitch.onTintColor=[UIColor grayColor];
    conservarSwitch.onTintColor=[UIColor grayColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma text delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    touchFlag=YES;
    if (textField.tag==1000) {
        [self animarView:containerOV Hasta:frameFinalOV];
        [self animarView:containerMetar Hasta:frameInicialMT];
        //[self animarView:leftSearchBar Hasta:searchInicialMT];
    }
    else if(textField.tag==1001){
        [self animarView:containerMetar Hasta:frameFinalMT];
        [self animarView:containerOV Hasta:frameInicialOV];
        //[self animarView:leftSearchBar Hasta:searchInicialMT];
    }
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    touchFlag=YES;
    //[self animarView:leftSearchBar Hasta:searchFinalMT];
    [self animarView:containerOV Hasta:frameInicialOV];
    [self animarView:containerMetar Hasta:frameInicialMT];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.001];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.001];
}
-(void)delayed{
    if (!touchFlag) {
        [self animarView:containerOV Hasta:frameInicialOV];
        [self animarView:containerMetar Hasta:frameInicialMT];
        //[self animarView:leftSearchBar Hasta:searchInicialMT];
    }
}

#pragma mark animacion
-(void)animarView:(UIView*)view Hasta:(CGRect)hasta{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.frame=hasta;
    [UIView commitAnimations];
}
#pragma mark dismiss keyboard
-(void)resignKeyboard{
    [ovTF resignFirstResponder];
}
#pragma mark button actions
-(IBAction)showImage:(UIButton*)sender{
    if (sender.tag==100) {
        /*DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        dVC.path=[[NSBundle mainBundle] pathForResource:@"test.pdf" ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:@"test.pdf" inView:nil];*/
        [self getImageFromServerWithNumber:@"1"];
    }
    else if (sender.tag==101) {
        /*DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        dVC.path=[[NSBundle mainBundle] pathForResource:@"test.pdf" ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:@"test.pdf" inView:nil];*/
        [self getImageFromServerWithNumber:@"2"];
    }
    else if (sender.tag==102) {
        /*DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        dVC.path=[[NSBundle mainBundle] pathForResource:@"test.pdf" ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        [self loadDocument:@"test.pdf" inView:nil];*/
        [self getImageFromServerWithNumber:@"3"];
    }
}
#pragma mark external request
-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView{
    //NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSString *path = documentName;

    NSURL *url = [NSURL fileURLWithPath:path];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[webView loadRequest:request];
    //[self loadDocument:@"test.pdf" inView:nil];
    //UIDocumentInteractionController *UIC=[self setupControllerWithURL:url usingDelegate:self];
    //[UIC presentOpenInMenuFromRect:CGRectMake(0, 0, 200, 200) inView:self.view animated:YES];
    [self previewDocumentWithURL:url];
}
-(void)loadLocalDocument:(NSString*)documentName inView:(UIWebView*)webView{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    //NSString *path = documentName;
    
    NSURL *url = [NSURL fileURLWithPath:path];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[webView loadRequest:request];
    //[self loadDocument:@"test.pdf" inView:nil];
    //UIDocumentInteractionController *UIC=[self setupControllerWithURL:url usingDelegate:self];
    //[UIC presentOpenInMenuFromRect:CGRectMake(0, 0, 200, 200) inView:self.view animated:YES];
    [self previewDocumentWithURL:url];
}
- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL
                                               usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    
    UIDocumentInteractionController *interactionController =
    [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    
    return interactionController;
}
- (void)previewDocumentWithURL:(NSURL*)url
{
    UIDocumentInteractionController* preview = [UIDocumentInteractionController interactionControllerWithURL:url];
    preview.delegate = self;
    [preview presentPreviewAnimated:YES];
}
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}
#pragma mark Server requests
-(void)getImageFromServerWithNumber:(NSString*)number{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    server.tag=[number intValue];
    NSString *params=[NSString stringWithFormat:@"<canal>%@</canal>",number];
    [server callServerWithMethod:@"getImage" andParameter:params];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=NSLocalizedString(@"Cargando imagen", nil);
}
#pragma mark server response
-(void)receivedDataFromServer:(ServerCommunicator*)sender{
    //NSString *result=[sender.resDic objectForKey:@"url"];
    if (sender.tag==1) {
        //NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:@"http://www.worldpress.org/images/maps/world_600w.jpg" yTipo:@"imagenOne"];
        //NSLog(@"url %@",url);

        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        //[self loadDocument:url inView:nil];
        [self loadLocalDocument:@"vapordeagua.png" inView:nil];

    }
    else if(sender.tag==2){
        //NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:@"http://3.bp.blogspot.com/-bT0csKe5NuQ/TzlXVff2ooI/AAAAAAAAAS8/vhgh3RBXyKw/s1600/Europe_on_The_World_map.jpg" yTipo:@"imagenTwo"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        //[self loadDocument:url inView:nil];
        [self loadLocalDocument:@"visual.png" inView:nil];

    }
    else if(sender.tag==3){
        //NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:@"http://1.bp.blogspot.com/_7kmVJTlRj38/TBjjak80ujI/AAAAAAAABD0/4aV8kZ4MOMM/s1600/map1942world1600.jpg" yTipo:@"imagenThree"];
        //NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        //dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        //[self loadDocument:url inView:nil];
        [self loadLocalDocument:@"infrarojo.png" inView:nil];

    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)receivedDataFromServerWithError:(ServerCommunicator*)sender{
    //NSString *result=[sender.resDic objectForKey:@"url"];
    if (sender.tag==1) {
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:@"http://www.worldpress.org/images/maps/world_600w.jpg" yTipo:@"imagenOne"];
        NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        //[self loadDocument:url inView:nil];
        [self loadLocalDocument:@"vapordeagua.png" inView:nil];
    }
    else if(sender.tag==2){
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:@"http://3.bp.blogspot.com/-bT0csKe5NuQ/TzlXVff2ooI/AAAAAAAAAS8/vhgh3RBXyKw/s1600/Europe_on_The_World_map.jpg" yTipo:@"imagenTwo"];
        NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        //[self loadDocument:url inView:nil];
        [self loadLocalDocument:@"visual.png" inView:nil];

    }
    else if(sender.tag==3){
        NSString *url=[ImageDownloader descargarImagenRetornarPathDesde:@"http://1.bp.blogspot.com/_7kmVJTlRj38/TBjjak80ujI/AAAAAAAABD0/4aV8kZ4MOMM/s1600/map1942world1600.jpg" yTipo:@"imagenThree"];
        NSLog(@"url %@",url);
        
        DocumentViewerController *dVC=[[DocumentViewerController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Document"];
        dVC.path=[[NSBundle mainBundle] pathForResource:url ofType:nil];
        //[self.navigationController pushViewController:dVC animated:YES];
        //[self loadDocument:url inView:nil];
        [self loadLocalDocument:@"infrarojo.png" inView:nil];

    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag==10000) {
        return @"Archivos";
    }
    else if(tableView.tag==10001){
        return @"Información Aeronáutica";
    }
    else{
        return @"";
    }
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger rows=0;
        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
           // if (tableView.tag==1002) {
                rows=[leftStaticArray count];
            //}
        }
        else{
            if (tableView.tag==10000) {
                rows= leftTableArray.count;
            }
            else if(tableView.tag==10001){
                rows= rightTableArray.count;
            }
        }

    return rows;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==10001) {
        return 80;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"id1";
    
    UITableViewCell *celda = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (celda == nil) {
        celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [celda setSelectionStyle:UITableViewCellSelectionStyleGray];

    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        
        //if (tableView.tag==1002) {
            celda.textLabel.text=[leftStaticArray objectAtIndex:indexPath.row];
        //}

    }
    else{
        if (tableView.tag==10000) {
            celda.textLabel.text=[leftTableArray objectAtIndex:indexPath.row];
        }
        else if(tableView.tag==10001){
            celda.textLabel.text=[rightTableArray objectAtIndex:indexPath.row];
            celda.textLabel.font=[UIFont systemFontOfSize:12];
            celda.textLabel.numberOfLines=3;
        }
    }
    
    return celda;
}

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope{
    NSPredicate *resultPredicate=[NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    leftStaticArray = [leftTableArray filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark uisearchdisplay controller delegate
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:searchOption]];
    return YES;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView  {
    searchDisplayController.searchResultsTableView.tag=10002;
    tableView.frame = leftTableView.frame;
    
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==10000||tableView.tag==10002) {
        NSLog(@"Touched cell in left tableview");
        [self loadLocalDocument:[leftTableArray objectAtIndex:indexPath.row] inView:nil];
    }
    else if(tableView.tag==10001){
        InfoAeroViewController *iaVC=[[InfoAeroViewController alloc]init];
        iaVC=[self.storyboard instantiateViewControllerWithIdentifier:@"InfoAero"];
        iaVC.delegatedString=[rightTableArray objectAtIndex:indexPath.row];
        iaVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        //iaVC.modalPresentationStyle = UIModalPresentationCurrentContext;
        iaVC.modalPresentationStyle = UIModalPresentationFormSheet;

        
        [self.navigationController presentViewController:iaVC animated:YES completion:nil];
        //[self.navigationController pushViewController:iaVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
