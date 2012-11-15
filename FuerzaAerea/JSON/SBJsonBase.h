

#import <Foundation/Foundation.h>

extern NSString * SBJSONErrorDomain;


enum {
    EUNSUPPORTED = 1,
    EPARSENUM,
    EPARSE,
    EFRAGMENT,
    ECTRL,
    EUNICODE,
    EDEPTH,
    EESCAPE,
    ETRAILCOMMA,
    ETRAILGARBAGE,
    EEOF,
    EINPUT
};

@interface SBJsonBase : NSObject {
    NSMutableArray *errorTrace;

@protected
    NSUInteger depth, maxDepth;
}

@property NSUInteger maxDepth;

 @property(copy,readonly) NSArray* errorTrace;

- (void)addErrorWithCode:(NSUInteger)code description:(NSString*)str;

- (void)clearErrorTrace;

@end
