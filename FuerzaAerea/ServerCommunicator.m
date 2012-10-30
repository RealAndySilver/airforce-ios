//
//  ServerCommunicator.m
//  Fuerza Aerea
//
//  Created by Andres Abril on 10/25/12.
//  Copyright (c) 2012 iAmStudio SAS. All rights reserved.
//

#import "ServerCommunicator.h"

@implementation ServerCommunicator
@synthesize dictionary,tag,caller,objectDic,resDic;
-(id)init {
    self = [super init];
    if (self) {
        tag = 0;
        caller = nil;
        webData = nil;
        theConnection = nil;
    }
    return self;
}
-(void)callServerWithMethod:(NSString*)method 
               andParameter:(NSString*)parameter{
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns=\"http://droidsecure.dglabs.com/app/service/\"\n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "%@\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",method,parameter,method];
    tempMethod=method;
	//NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.ekoomedia.com.co/ekoobot3d/web/ws/bot_api?wsdl"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://droidsecure.dglabs.com/app/service/UserService.php"]];

    NSString *soapAction=[NSString stringWithFormat:@"http://droidsecure.dglabs.com/app/service/"];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];  
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];          
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];       
	[theRequest addValue: soapAction forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	dictionary = [[NSDictionary alloc]init];
	if(theConnection) {
		webData = [NSMutableData data];
	}
	else {
		NSLog(@"theConnection is NULL");
	}
}


//Implement the NSURL and XMLParser protocols
#pragma mark -
#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[webData setLength:0];
	NSLog(@"didReceiveresponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[webData appendData:data];
	NSLog(@"didReceiveData");
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NSLog(@"didFailWithError");
    if ([caller respondsToSelector:@selector(receivedDataFromServerWithError:)]) {
        [caller performSelector:@selector(receivedDataFromServerWithError:) withObject:self];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
	NSString *methodResponse=[NSString stringWithFormat:@"ns1:%@Response",tempMethod];
	NSLog(@"Todos los datos recibidos");
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];

    NSDictionary *dictionary1 = [XMLReader dictionaryForXMLString:theXML error:nil];
    
    if ([caller respondsToSelector:@selector(receivedDataFromServer:)]) {
        NSDictionary * dictionary2=[[[[dictionary1 objectForKey:@"SOAP-ENV:Envelope"]
                                      objectForKey:@"SOAP-ENV:Body"]
                                     objectForKey:methodResponse]
                                    objectForKey:@"return"];
        
        resDic=[[NSMutableDictionary alloc]initWithDictionary:dictionary2];
        NSLog(@"xml %@",resDic);
        [caller performSelector:@selector(receivedDataFromServer:) withObject:self];
    }

}

@end
