//
//  SerializadorOV.m
//  FuerzaAerea
//
//  Created by Andres Abril on 4/12/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "SerializadorOV.h"
#import "SBJSON.h"

@implementation SerializadorOV
+(NSMutableDictionary*)getDiccionarioFronJsonString:(NSString*)json_string{
    SBJSON *json=[[SBJSON alloc]init];
    
    if ([json_string isEqualToString:@"{}{}{\"Armamento \":[{\"idOrden\":\"0\",\"idArmamento\":\"0\",\"armamento\":\"0\",\"cantidad\":\"0\"}{}"]) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"false" forKey:@"Success"];
        return dic;
    }
    NSString *errorSubstring=[json_string substringToIndex:2];
    if ([errorSubstring isEqualToString:@"{}"]) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"false" forKey:@"Success"];
        return dic;
    }
    NSString *thresholdString=@"}]}";
    
    NSRange range=[json_string rangeOfString:thresholdString];
    
    NSString *stringOne=[json_string substringWithRange:NSMakeRange(0, range.location+3)];
    
    NSString *json_string2=[json_string substringWithRange:NSMakeRange(range.location+3,[json_string length]-(range.location+3))];
    
    
    NSRange range2=[json_string2 rangeOfString:thresholdString];
    
    NSString *stringTwo=[json_string2 substringWithRange:NSMakeRange(0, range2.location+3)];
    
    NSString *json_string3=[json_string2 substringWithRange:NSMakeRange(range2.location+3,[json_string2 length]-(range2.location+3))];
    
    
    NSRange range3=[json_string3 rangeOfString:thresholdString];
    
    NSString *stringThree=[json_string3 substringWithRange:NSMakeRange(0, range3.location+3)];
    
    NSString *json_string4=[json_string3 substringWithRange:NSMakeRange(range3.location+3,[json_string3 length]-(range3.location+3))];
    
    
    NSRange range4=[json_string4 rangeOfString:thresholdString];
    
    NSString *stringFour=[json_string4 substringWithRange:NSMakeRange(0, range4.location+3)];
    
    NSString *json_string5=[json_string4 substringWithRange:NSMakeRange(range4.location+3,[json_string4 length]-(range4.location+3))];
    
    
    NSRange range5=[json_string5 rangeOfString:thresholdString];
    
    NSString *stringFive=[json_string5 substringWithRange:NSMakeRange(0, range5.location+3)];
    
    NSString *json_string6=[json_string5 substringWithRange:NSMakeRange(range5.location+3,[json_string5 length]-(range5.location+3))];
    
    
    NSRange range6=[json_string6 rangeOfString:thresholdString];
    
    NSString *stringSix=[json_string6 substringWithRange:NSMakeRange(0, range6.location+3)];
    

    
    NSMutableDictionary *jsonDic=[[NSMutableDictionary alloc]init];
    
    NSDictionary *consultaPrincipal=[json objectWithString:stringOne error:nil];
    
    NSDictionary *consultaPiernas=[json objectWithString:stringTwo error:nil];
    
    NSDictionary *armamento=[json objectWithString:stringThree error:nil];
    
    NSDictionary *tripulacion=[json objectWithString:stringFour error:nil];
    
    NSDictionary *teplas=[json objectWithString:stringFive error:nil];
    
    NSDictionary *sanidad=[json objectWithString:stringSix error:nil];
    
    //NSLog(@"El stringo %@",jsonDic);

    
    [jsonDic setObject:[consultaPrincipal objectForKey:@"ConsultaPrincipalOrdenVuelo "] forKey:@"Principal"];
    
    [jsonDic setObject:[consultaPiernas objectForKey:@"ConsultaPiernas "] forKey:@"Piernas"];
    
    [jsonDic setObject:[armamento objectForKey:@"Armamento "] forKey:@"Armamento"];
    
    [jsonDic setObject:[tripulacion objectForKey:@"Tripulacion "] forKey:@"Tripulacion"];
    
    [jsonDic setObject:[teplas objectForKey:@"PerTeplasOrden "] forKey:@"Teplas"];
    
    [jsonDic setObject:[sanidad objectForKey:@"PerSanidadOrden "] forKey:@"Sanidad"];
    
    return jsonDic;
}

@end
