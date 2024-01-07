//
//  NewsResponseParser.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "NewsResponseParser.h"
#import "NSDictionary+IRDictionary.h"
#import "IRNewsResponse.h"
#import "APIDefines.h"

@implementation NewsResponseParser

+ (IRNewsResponse *)newsParsedFromJSON:(NSDictionary *)json
{
    return [IRNewsResponse objectFromJSON:json];
}

@end
