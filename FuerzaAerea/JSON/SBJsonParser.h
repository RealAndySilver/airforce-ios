

#import <Foundation/Foundation.h>
#import "SBJsonBase.h"


@protocol SBJsonParser


- (id)objectWithString:(NSString *)repr;

@end



@interface SBJsonParser : SBJsonBase <SBJsonParser> {
    
@private
    const char *c;
}

@end

@interface SBJsonParser (Private)
- (id)fragmentWithString:(id)repr;
@end


