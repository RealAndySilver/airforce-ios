

#import <Foundation/Foundation.h>
#import "SBJsonParser.h"
#import "SBJsonWriter.h"


@interface SBJSON : SBJsonBase <SBJsonParser, SBJsonWriter> {

@private    
    SBJsonParser *jsonParser;
    SBJsonWriter *jsonWriter;
}


- (id)fragmentWithString:(NSString*)jsonrep
                   error:(NSError**)error;

- (id)objectWithString:(NSString*)jsonrep
                 error:(NSError**)error;

- (id)objectWithString:(id)value
           allowScalar:(BOOL)x
    			 error:(NSError**)error;


- (NSString*)stringWithObject:(id)value
                        error:(NSError**)error;

- (NSString*)stringWithFragment:(id)value
                          error:(NSError**)error;

- (NSString*)stringWithObject:(id)value
                  allowScalar:(BOOL)x
    					error:(NSError**)error;


@end
