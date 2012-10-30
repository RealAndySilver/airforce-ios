//
//  XMLReader.m
//  Fuerza Aerea
//
//  Created by Andres Abril on 10/10/12.
//  Copyright (c) 2012 iAmStudio SAS. All rights reserved.
//

#import "XMLReader.h"

NSString *const kXMLReaderTextNodeKey = @"text";

@interface XMLReader (Internal)

- (id)initWithError:(NSError **)error;
- (NSDictionary *)objectWithData:(NSData *)data;

@end

@implementation NSDictionary (XMLReaderNavigation)

- (id)retrieveForPath:(NSString *)navPath
{
    NSArray *pathItems = [navPath componentsSeparatedByString:@"."];
    
    NSEnumerator *e = [pathItems objectEnumerator];
    NSString *path;
    
    id branch = [self objectForKey:[e nextObject]];
    int count = 1;
    
    while ((path = [e nextObject]))
    {
        if([branch isKindOfClass:[NSArray class]])
        {
            if ([path isEqualToString:@"last"])
            {
                branch = [branch lastObject];
            }
            else
            {
                if ([branch count] > [path intValue])
                {
                    branch = [branch objectAtIndex:[path intValue]];
                }
                else
                {
                    branch = nil;
                }
            }
        }
        else
        {
            branch = [branch objectForKey:path];
        }
        
        count++;
    }
    
    return branch;
}

@end

@implementation XMLReader

#pragma mark -
#pragma mark Public methods

+ (NSDictionary *)dictionaryForPath:(NSString *)path error:(NSError **)errorPointer
{
    NSString *fullpath = [[NSBundle bundleForClass:self] pathForResource:path ofType:@"xml"];
	NSData *data = [[NSFileManager defaultManager] contentsAtPath:fullpath];
    NSDictionary *rootDictionary = [XMLReader dictionaryForXMLData:data error:errorPointer];
    
	return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)error
{
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data];
    [reader release];
    
    return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)error
{
    NSArray* lines = [string componentsSeparatedByString:@"\n"];
    NSMutableString* strData = [NSMutableString stringWithString:@""];
    
    for (int i = 0; i < [lines count]; i++)
    {
        [strData appendString:[[lines objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    
    NSData *data = [strData dataUsingEncoding:NSUTF8StringEncoding];
    return [XMLReader dictionaryForXMLData:data error:error];
}

#pragma mark -
#pragma mark Parsing

- (id)initWithError:(NSError **)error
{
    if ((self = [super init]))
    {
        errorPointer = error;
    }
    
    return self;
}

- (void)dealloc
{
    [dictionaryStack release];
    [textInProgress release];
    
    [super dealloc];
}

- (NSDictionary *)objectWithData:(NSData *)data
{
    // Clear out any old data
    [dictionaryStack release];
    [textInProgress release];
    
    dictionaryStack = [[NSMutableArray alloc] init];
    textInProgress = [[NSMutableString alloc] init];
    
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];
	[parser release];
    
    if (success)
    {
        NSDictionary *resultDict = [dictionaryStack objectAtIndex:0];
        
        return resultDict;
    }
    
    return nil;
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSMutableDictionary *parentDict = [dictionaryStack lastObject];
    
    NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in attributeDict) {
        [childDict setValue:[attributeDict objectForKey:key]
                     forKey:[NSString stringWithFormat:@"@%@", key]];
    }
    
    id existingValue = [parentDict objectForKey:elementName];
    
    if (existingValue)
    {
        NSMutableArray *array = nil;
        
        if ([existingValue isKindOfClass:[NSMutableArray class]])
        {
            array = (NSMutableArray *) existingValue;
        }
        else
        {
            array = [NSMutableArray array];
            [array addObject:existingValue];
            
            [parentDict setObject:array forKey:elementName];
        }
        
        [array addObject:childDict];
    }
    else
    {
        [parentDict setObject:childDict forKey:elementName];
    }
    
    [dictionaryStack addObject:childDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSMutableDictionary *dictInProgress = [dictionaryStack lastObject];
    
    [dictionaryStack removeLastObject];
    
    if ([textInProgress length] > 0)
    {
        if ([dictInProgress count] > 0)
        {
            [dictInProgress setObject:textInProgress forKey:kXMLReaderTextNodeKey];
        }
        else
        {

            NSMutableDictionary *parentDict = [dictionaryStack lastObject];
            id parentObject = [parentDict objectForKey:elementName];
            
            if ([parentObject isKindOfClass:[NSArray class]])
            {
                [parentObject removeLastObject];
                [parentObject addObject:textInProgress];
            }
            
            else
            {
                [parentDict removeObjectForKey:elementName];
                [parentDict setObject:textInProgress forKey:elementName];
            }
        }
        
        [textInProgress release];
        textInProgress = [[NSMutableString alloc] init];
    }
    
    else if ([dictInProgress count] == 0)
    {
        NSMutableDictionary *parentDict = [dictionaryStack lastObject];
        [parentDict removeObjectForKey:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[textInProgress appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if (errorPointer)
        errorPointer = parseError;
}

@end
