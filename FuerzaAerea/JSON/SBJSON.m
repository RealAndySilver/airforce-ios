

#import "SBJSON.h"

@implementation SBJSON

- (id)init {
    self = [super init];
    if (self) {
        jsonWriter = [SBJsonWriter new];
        jsonParser = [SBJsonParser new];
        [self setMaxDepth:512];

    }
    return self;
}

- (void)dealloc {
    [jsonWriter release];
    [jsonParser release];
    [super dealloc];
}

#pragma mark Writer 


- (NSString *)stringWithObject:(id)obj {
    NSString *repr = [jsonWriter stringWithObject:obj];
    if (repr)
        return repr;
    
    [errorTrace release];
    errorTrace = [[jsonWriter errorTrace] mutableCopy];
    return nil;
}


- (NSString*)stringWithObject:(id)value allowScalar:(BOOL)allowScalar error:(NSError**)error {
    
    NSString *json = allowScalar ? [jsonWriter stringWithFragment:value] : [jsonWriter stringWithObject:value];
    if (json)
        return json;

    [errorTrace release];
    errorTrace = [[jsonWriter errorTrace] mutableCopy];
    
    if (error)
        *error = [errorTrace lastObject];
    return nil;
}


- (NSString*)stringWithFragment:(id)value error:(NSError**)error {
    return [self stringWithObject:value
                      allowScalar:YES
                            error:error];
}


- (NSString*)stringWithObject:(id)value error:(NSError**)error {
    return [self stringWithObject:value
                      allowScalar:NO
                            error:error];
}

#pragma mark Parsing

- (id)objectWithString:(NSString *)repr {
    id obj = [jsonParser objectWithString:repr];
    if (obj)
        return obj;

    [errorTrace release];
    errorTrace = [[jsonParser errorTrace] mutableCopy];
    
    return nil;
}


- (id)objectWithString:(id)value allowScalar:(BOOL)allowScalar error:(NSError**)error {

    id obj = allowScalar ? [jsonParser fragmentWithString:value] : [jsonParser objectWithString:value];
    if (obj)
        return obj;
    
    [errorTrace release];
    errorTrace = [[jsonParser errorTrace] mutableCopy];

    if (error)
        *error = [errorTrace lastObject];
    return nil;
}


- (id)fragmentWithString:(NSString*)repr error:(NSError**)error {
    return [self objectWithString:repr
                      allowScalar:YES
                            error:error];
}


- (id)objectWithString:(NSString*)repr error:(NSError**)error {
    return [self objectWithString:repr
                      allowScalar:NO
                            error:error];
}



#pragma mark Properties - parsing

- (NSUInteger)maxDepth {
    return jsonParser.maxDepth;
}

- (void)setMaxDepth:(NSUInteger)d {
     jsonWriter.maxDepth = jsonParser.maxDepth = d;
}


#pragma mark Properties - writing

- (BOOL)humanReadable {
    return jsonWriter.humanReadable;
}

- (void)setHumanReadable:(BOOL)x {
    jsonWriter.humanReadable = x;
}

- (BOOL)sortKeys {
    return jsonWriter.sortKeys;
}

- (void)setSortKeys:(BOOL)x {
    jsonWriter.sortKeys = x;
}

@end
