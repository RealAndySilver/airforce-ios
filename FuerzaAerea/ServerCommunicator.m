//
//  ServerCommunicator.m
//  Fuerza Aerea
//
//  Created by Andres Abril on 10/25/12.
//  Copyright (c) 2012 iAmStudio SAS. All rights reserved.
//

#import "ServerCommunicator.h"

@implementation ServerCommunicator
@synthesize dictionary,tag,caller,objectDic,resDic,methodName;
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
                             "<ns2:%@ xmlns:ns2=\"http://ws.sinte.co/\">\n"
                             "%@\n"
                             "</ns2:%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",method,parameter,method];
    tempMethod=method;
    methodName=method;
    NSURL *url=nil;
    if ([method isEqualToString:@"faseVuelos"]||[method isEqualToString:@"departamentos"]||[method isEqualToString:@"armamentos"]||[method isEqualToString:@"listas"]||[method isEqualToString:@"enemigos"]||[method isEqualToString:@"objetivos"]||[method isEqualToString:@"joaOperaciones"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:2626/ServiciosMaletin/WS_Listas?xsd=1"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.100.6:8989/ServiciosMaletin/WS_Listas?xsd=1"]];


    }
    else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:2626/ServiciosMaletin/WS_Inicio?wsdl"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.100.6:8989/ServiciosMaletin/WS_Inicio?wsdl"]];

    }
    /*if ([method isEqualToString:@"faseVuelos"] || [method isEqualToString:@"departamentos"] || [method isEqualToString:@"armamentos"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://webservicesiioc2:8989/ServiciosMaletin/WS_Listas?xsd=1"]];
        
    }
    else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://webservicesiioc2:8989/ServiciosMaletin/WS_Inicio?wsdl"]];
    }*/
    
    
    NSString *soapAction=[NSString stringWithFormat:@"http://ws.sinte.co/%@",method];
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
	NSString *methodResponse=[NSString stringWithFormat:@"ns2:%@Response",tempMethod];
	NSLog(@"Todos los datos recibidos");
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dictionary1 = [XMLReader dictionaryForXMLString:theXML error:nil];
    //NSLog(@"dic %@",theXML);
    //NSString *tempString=[NSString stringWithFormat:@"ns2:%@Response",tempMethod];
    if ([caller respondsToSelector:@selector(receivedDataFromServer:)]) {
        NSDictionary * dictionary2=[[[dictionary1 objectForKey:@"S:Envelope"]
                                     objectForKey:@"S:Body"]
                                    objectForKey:methodResponse];
        SBJSON *json=[[SBJSON alloc]init];
        NSData *data=[[dictionary2 objectForKey:@"return"] dataUsingEncoding:NSUTF8StringEncoding];
        NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"Json %@",json_string);
        if ([tempMethod isEqualToString:@"ordenVuelo"]) {
            
            resDic=[[NSMutableDictionary alloc]initWithDictionary:[SerializadorOV getDiccionarioFronJsonString:json_string]];
            [caller performSelector:@selector(receivedDataFromServer:) withObject:self];
            return;
        }
        else if ([tempMethod isEqualToString:@"listas"]){
            NSString *str=[json_string stringByReplacingOccurrencesOfString:@"}{" withString:@","];
            json_string=[NSString stringWithFormat:@"{\"listas\":%@}",str];
        }
        NSMutableDictionary *dit=[json objectWithString:json_string error:nil];
        resDic=[[NSMutableDictionary alloc]initWithDictionary:dit];
        [caller performSelector:@selector(receivedDataFromServer:) withObject:self];
    }
}

@end
