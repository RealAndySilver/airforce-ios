#import <Foundation/Foundation.h>

@interface FileSaver : NSObject{
    NSDictionary *datos;
    NSDictionary *datosFriendList;

}
-(NSDictionary*)getDictionary:(NSString*)name;
-(void)setDictionary:(NSDictionary*)dictionary withName:(NSString*)name;
-(NSString*)getUserWithName:(NSString*)name andPassword:(NSString*)password;
-(void)setUserName:(NSString*)name password:(NSString*)password andId:(NSString*)ID;
-(NSString*)getUpdateFile:(int)tag;
-(NSString *)getUpdateFileWithString:(NSString*)tag;
-(void)setUpdateFile:(NSString*)name date:(NSString*)date andTag:(int)tag;
-(void)setUpdateFile:(NSString*)name date:(NSString*)date andTag:(int)tag andId:(NSString*)ID;
-(void)setLastUserName:(NSString*)name andPassword:(NSString*)password;
-(NSDictionary*)getLastUserNameAndPassword;

-(NSString*)getNombre;
-(NSString*)getPassword;

-(void)setIP:(NSString*)ip;
-(NSString*)getIp;



@end
