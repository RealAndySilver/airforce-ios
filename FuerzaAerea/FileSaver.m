
#import "FileSaver.h"
#import "IAmCoder.h"
#define DATAFILENAME @"savefile.plist"
#define FRIENDLISTFILE @"friendList.plist"

@implementation FileSaver
-(id) init{
	if ((self = [super init])) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *Path = [paths objectAtIndex:0];
		//NSString *Path = [[NSBundle mainBundle] bundlePath];
		NSString *DataPath = [Path stringByAppendingPathComponent:DATAFILENAME];
		NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:DataPath];
		
        if (!tempDict) {
			tempDict = [[NSDictionary alloc] init];
		}
        datos = tempDict;
        
        NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *Path2 = [paths2 objectAtIndex:0];
		//NSString *Path = [[NSBundle mainBundle] bundlePath];
		NSString *DataPath2 = [Path2 stringByAppendingPathComponent:FRIENDLISTFILE];
		NSDictionary *tempDict2 = [[NSDictionary alloc] initWithContentsOfFile:DataPath2];
		
        if (!tempDict2) {
			tempDict2 = [[NSDictionary alloc] init];
		}
        datosFriendList = tempDict2;
	}    
	return self;
}
-(BOOL)guardar{
	NSData *xmlData;  
	NSString *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *Path = [paths objectAtIndex:0];
	//NSString *Path = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"guardar %@",datosConf);
	NSString *DataPath = [Path stringByAppendingPathComponent:DATAFILENAME];
	xmlData = [NSPropertyListSerialization dataFromPropertyList:datos format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];  
	if (xmlData) {  
		[xmlData writeToFile:DataPath atomically:YES];  
		return YES;
	} else {  
		NSLog(@"Error writing plist to file '%s', error = '%s'", [DataPath UTF8String], [error UTF8String]);  
		return NO;
	}
}
//Método antiguo, sin encripción
//-(NSDictionary*)getDictionary:(NSString*)name{
//    return [datos objectForKey:name];
//}
//-(void)setDictionary:(NSDictionary*)dictionary withName:(NSString*)name{
//	NSMutableDictionary *newData = [datos mutableCopy];
//	[newData setObject:dictionary forKey:name];
//	datos = newData;
//	[self guardar];
//}


-(NSDictionary*)getDictionary:(NSString*)name{
    if (1==1) {
        return [datos objectForKey:name];
    }
    if ([name isEqualToString:@"User"] ||
        [name isEqualToString:@"Temp"] ||
        [name isEqualToString:@"Notams"] ||
        [name isEqualToString:@"metars"] ||
        [name isEqualToString:@"enemigos"] ||
        [name isEqualToString:@"objetivos"] ||
        [name isEqualToString:@"operaciones"] ||
        [name isEqualToString:@"lista"] ||
        [name isEqualToString:@"municipios"] ||
        [name isEqualToString:@"ArchivosGuardados"]){
        return [datos objectForKey:name];
    }
    /*NSData *data=[datos objectForKey:name];
    NSDictionary *userDic=[self getDictionary:@"User"];
    NSData *dcipher=[data AES256DecryptWithKey:@"password"];
    NSDictionary *dic = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:dcipher];*/
    
    NSData *dcipher=[IAmCoder data_decrypt:[datos objectForKey:name] withKey:[[self getDictionary:@"Temp"] objectForKey:@"sha"]];
    
    //NSDictionary *dic = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:dcipher];
    NSError *error;
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData: dcipher options:0 error:&error];
    //NSLog(@"Data recuperada %@", dic);
    return dic;
}

-(void)setDictionary:(NSDictionary*)dictionary withName:(NSString*)name{
    if (1==1) {
        NSMutableDictionary *newData = [datos mutableCopy];
        [newData setObject:dictionary forKey:name];
        datos = newData;
        [self guardar];
        return;
    }
    if ([name isEqualToString:@"User"] ||
        [name isEqualToString:@"Temp"] ||
        [name isEqualToString:@"Notams"] ||
        [name isEqualToString:@"metars"] ||
        [name isEqualToString:@"enemigos"] ||
        [name isEqualToString:@"objetivos"] ||
        [name isEqualToString:@"operaciones"] ||
        [name isEqualToString:@"lista"] ||
        [name isEqualToString:@"municipios"] ||
        [name isEqualToString:@"ArchivosGuardados"]) {
        NSMutableDictionary *newData = [datos mutableCopy];
        [newData setObject:dictionary forKey:name];
        datos = newData;
        [self guardar];
        return;
    }
	/*NSMutableDictionary *newData = [datos mutableCopy];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    NSData *cipher = [data AES256EncryptWithKey:@"password"];
	[newData setObject:cipher forKey:name];*/
    
    NSMutableDictionary *newData = [datos mutableCopy];
    //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    //NSLog(@"Data %@", data);
    NSData *cipher = [IAmCoder data_encrypt:data withKey:[[self getDictionary:@"Temp"] objectForKey:@"sha"]];
    [newData setObject:cipher forKey:name];
    
	datos = newData;
    //NSLog(@"Data: %@",datos);
	[self guardar];
}

/*-(NSString*)getUserWithName:(NSString*)name andPassword:(NSString*)password{
    if ([[datos objectForKey:@"nombreLocal"]isEqualToString:name]&&[[datos objectForKey:@"passwordLocal"]isEqualToString:password]) {
        return [datos objectForKey:@"idLocal"];
    }
    else{
        return nil;
    }
}
-(void)setUserName:(NSString*)name password:(NSString*)password andId:(NSString*)ID{
    NSMutableDictionary *newData = [datos mutableCopy];
    [newData setObject:name forKey:@"nombreLocal"];
    [newData setObject:password forKey:@"passwordLocal"];
    [newData setObject:ID forKey:@"idLocal"];
	datos = newData;
	[self guardar];
}*/

-(NSString*)getUserWithName:(NSString*)name andPassword:(NSString*)password{
    if ([[datos objectForKey:name]isEqualToString:name]&&[[datos objectForKey:password]isEqualToString:password]) {
        NSString *namePass=[NSString stringWithFormat:@"%@%@",name,password];
        return [datos objectForKey:namePass];
    }
    else{
        return nil;
    }
}
-(void)setUserName:(NSString*)name password:(NSString*)password andId:(NSString*)ID{
    NSMutableDictionary *newData = [datos mutableCopy];
    [newData setObject:name forKey:name];
    [newData setObject:password forKey:password];
    NSString *namePass=[NSString stringWithFormat:@"%@%@",name,password];
    [newData setObject:ID forKey:namePass];
	datos = newData;
	[self guardar];
}

-(NSString *)getUpdateFile:(int)tag{
    NSString *string=[NSString stringWithFormat:@"%i",tag];
    NSString *date=[datos objectForKey:string];
    return date;
}
-(NSString *)getUpdateFileWithString:(NSString*)tag{
    NSString *string=[NSString stringWithFormat:@"%@",tag];
    NSString *date=[datos objectForKey:string];
    return date;
}

-(void)setUpdateFile:(NSString *)name date:(NSString *)date andTag:(int)tag{
    NSMutableDictionary *newData = [datos mutableCopy];
    NSString *string=[NSString stringWithFormat:@"%i",tag];
    [newData setObject:date forKey:string];
	datos = newData;
	[self guardar];
}
-(void)setUpdateFile:(NSString *)name date:(NSString *)date andTag:(int)tag andId:(NSString *)ID{
    NSMutableDictionary *newData = [datos mutableCopy];
    NSString *string=[NSString stringWithFormat:@"%i%@",tag,ID];
    [newData setObject:date forKey:string];
	datos = newData;
	[self guardar];
}
-(NSString*)getNombre{
    return [datos objectForKey:@"nombreLocal"];
}
-(NSString*)getPassword{
    return [datos objectForKey:@"passwordLocal"];
}

-(void)setLastUserName:(NSString *)name andPassword:(NSString *)password{
    NSMutableDictionary *newData = [datos mutableCopy];
	[newData setObject:name forKey:@"name"];
    [newData setObject:password forKey:@"password"];
	datos = newData;
	[self guardar];
}
-(NSDictionary *)getLastUserNameAndPassword{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    if ([[datos objectForKey:@"name"] isKindOfClass:[NSString class]]) {
        [dic setObject:[datos objectForKey:@"name"] forKey:@"name"];
        [dic setObject:[datos objectForKey:@"password"] forKey:@"password"];
    }
    return dic;
}
-(void)setIP:(NSString *)ip{
    NSMutableDictionary *newData = [datos mutableCopy];
	[newData setObject:ip forKey:@"IP"];
	datos = newData;
	[self guardar];
}
-(NSString*)getIp{
    return [datos objectForKey:@"IP"];
}
@end
