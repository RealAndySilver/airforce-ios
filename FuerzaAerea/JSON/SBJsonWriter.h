
#import <Foundation/Foundation.h>
#import "SBJsonBase.h"


@protocol SBJsonWriter


@property BOOL humanReadable;

@property BOOL sortKeys;


- (NSString*)stringWithObject:(id)value;

@end



@interface SBJsonWriter : SBJsonBase <SBJsonWriter> {

@private
    BOOL sortKeys, humanReadable;
}

@end

@interface SBJsonWriter (Private)
- (NSString*)stringWithFragment:(id)value;
@end

@interface NSObject (SBProxyForJson)
- (id)proxyForJson;
@end

