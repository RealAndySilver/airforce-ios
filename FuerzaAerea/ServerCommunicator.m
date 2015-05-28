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
                             "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns=\"http://apps.sinte.co/app/service/\"\n"
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
    FileSaver *file=[[FileSaver alloc]init];
    NSString *ip=[file getIp];
    if ([method isEqualToString:@"faseVuelos"]||[method isEqualToString:@"departamentos"]||[method isEqualToString:@"armamentos"]||[method isEqualToString:@"listas"]||[method isEqualToString:@"enemigos"]||[method isEqualToString:@"objetivos"]||[method isEqualToString:@"joaOperaciones"]||[method isEqualToString:@"municipios"]) {
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:2626/ServiciosMaletin/WS_Listas?xsd=1"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.100.6:8989/ServiciosMaletin/WS_Listas?xsd=1"]];
        if ([ip isEqualToString:@""]) {
            //URL Producción
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.100.6:8989/ServiciosMaletin/WS_Listas?xsd=1"]];
            //URL Sinte
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:8383/ServiciosMaletin/WS_Listas?xsd=1"]];
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.122.123:8989/ServiciosMaletin/WS_Inicio?wsdl"]];

        }
        else{
            //URL Custom usando el login admin
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/ServiciosMaletin/WS_Listas?xsd=1",ip]];
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.122.123:8989/ServiciosMaletin/WS_Inicio?wsdl"]];

        }
    }
    else if ([method isEqualToString:@"ListaTipoOperacion"]) {
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:2626/ServiciosMaletin/WS_Listas?xsd=1"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.100.6:8989/ServiciosMaletin/WS_Listas?xsd=1"]];
        //if ([ip isEqualToString:@""]) {
            //URL Producción
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.197:8080/TestMisionCumplida/ListasMisionCumplidaWS?wsdl"]];
            //URL Sinte
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:8383/ServiciosMaletin/WS_Listas?xsd=1"]];
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.122.123:8989/ServiciosMaletin/WS_Inicio?wsdl"]];
            
        //}
        //else{
            //URL Custom usando el login admin
        //    url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/TestMisionCumplida/ListasMisionCumplidaWS?wsdl",ip]];
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.122.123:8989/ServiciosMaletin/WS_Inicio?wsdl"]];
            
        //}
    }
    else{
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:2626/ServiciosMaletin/WS_Inicio?wsdl"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.100.6:8989/ServiciosMaletin/WS_Inicio?wsdl"]];
        if ([ip isEqualToString:@""]) {
            //URL Producción
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.100.6:8989/ServiciosMaletin/WS_Inicio?wsdl"]];
            //URL Sinte
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:8383/ServiciosMaletin/WS_Inicio?wsdl"]];
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.122.123:8989/ServiciosMaletin/WS_Inicio?wsdl"]];

        }
        else{
            //URL Custom usando el login admin
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/ServiciosMaletin/WS_Inicio?wsdl",ip]];
            //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://172.20.122.123:8989/ServiciosMaletin/WS_Inicio?wsdl"]];

        }
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://app.sinte.co:2626/ServiciosMaletin/WS_Inicio?wsdl"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://174.120.23.123/~api/archivos2.json"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.46:8080/ServiciosMaletin/WS_Inicio?wsdl"]];
        //url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.46:8080/ServiciosMaletin/WS_Inicio?wsdl"]];
    }
    NSLog(@"URL -> %@",url);
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
    
    NSLog(@"Request %@",[NSString stringWithUTF8String:[theRequest.HTTPBody bytes]]);
    
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
	//NSLog(@"didReceiveData");
    
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
    
    //    FileSaver *temp=[[FileSaver alloc]init];
    
    NSDictionary *dictionary1 = [XMLReader dictionaryForXMLString:theXML error:nil];
    NSLog(@"dic %@",theXML);
    //NSString *tempString=[NSString stringWithFormat:@"ns2:%@Response",tempMethod];
    if ([caller respondsToSelector:@selector(receivedDataFromServer:)]) {
        NSDictionary * dictionary2=[[[dictionary1 objectForKey:@"S:Envelope"]
                                     objectForKey:@"S:Body"]
                                    objectForKey:methodResponse];
        SBJSON *json=[[SBJSON alloc]init];
        NSData *data=[[dictionary2 objectForKey:@"return"] dataUsingEncoding:NSUTF8StringEncoding];
        NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"Json %@",json_string);
        //login,ordenVuelo,
        if ([tempMethod isEqualToString:@"login"]) {
            //json_string=[IAmCoder base64DecodeString:json_string];
            json_string=[IAmCoder base64AndDecrypt:json_string withKey:[IAmCoder dateKey]];
        }
        if ([tempMethod isEqualToString:@"ordenVuelo"]) {
            //json_string=[IAmCoder base64DecodeString:json_string];
            json_string=[IAmCoder base64AndDecrypt:json_string withKey:[IAmCoder dateKey]];
            if (json_string.length>0) {
                NSLog(@"json %@",json_string);
                resDic=[[NSMutableDictionary alloc]initWithDictionary:[SerializadorOV getDiccionarioFronJsonString:json_string]];
                [caller performSelector:@selector(receivedDataFromServer:) withObject:self];
                return;
            }
            else{
                [caller performSelector:@selector(receivedDataFromServer:) withObject:self];
                return;
            }
        }
        else if ([tempMethod isEqualToString:@"listas"]){
            NSString *str=[json_string stringByReplacingOccurrencesOfString:@"}{" withString:@","];
            json_string=[NSString stringWithFormat:@"{\"listas\":%@}",str];
        }
        NSMutableDictionary *dit=[json objectWithString:json_string error:nil];
        //NSMutableDictionary *dit=[json objectWithString:theXML error:nil];
        
        resDic=[[NSMutableDictionary alloc]initWithDictionary:dit];
        [caller performSelector:@selector(receivedDataFromServer:) withObject:self];
    }
}

@end
