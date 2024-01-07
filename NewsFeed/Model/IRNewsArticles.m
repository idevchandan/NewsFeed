//
//  IRNewsArticles.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRNewsArticles.h"
#import "NSDictionary+IRDictionary.h"
#import "APIDefines.h"

@implementation IRNewsArticles

+ (id)objectFromJSON:(NSDictionary *)json
{
    return [[IRNewsArticles alloc] initWithJson:json];
}

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        _newsTitle = [json safeValueForKey:kKEY_NEWS_TITLE];
        _newsDescription = [json safeValueForKey:kKEY_NEWS_DESCRIPTION];
        _newsURL = [json safeValueForKey:kKEY_NEWS_URL];
        _newsImageURL = [json safeValueForKey:kKEY_NEWS_IMAGE_URL];
        _newsPublishedDate = [json safeValueForKey:kKEY_NEWS_PUBLISHED_DATE];
        _newsContent = [json safeValueForKey:kKEY_NEWS_CONTENT];
    }
    return self;
}


@end
