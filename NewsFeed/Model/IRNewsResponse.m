//
//  IRNewsResponse.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRNewsResponse.h"
#import "NSDictionary+IRDictionary.h"
#import "APIDefines.h"

@implementation IRNewsResponse

+ (id)objectFromJSON:(NSDictionary *)JSONValue
{
    return JSONValue ? [[IRNewsResponse alloc] initWithJson:JSONValue] : nil;
}

- (instancetype)initWithJson:(NSDictionary *)Json
{
    if (self) {
        [self setUpWithJSON:Json];
    }
    return self;
}

- (void)setUpWithJSON:(NSDictionary *)json
{
    _totalNewsArticles = [[json safeValueForKey:kKEY_TOTAL_NEWS_ARTICLES] integerValue];
    _newsArticles = [self newsArticlesFromJSON:json];
}

- (NSArray<IRNewsArticles *> *)newsArticlesFromJSON:(NSDictionary *)json
{
    NSMutableArray<IRNewsArticles *> *newsArticleObjects = [NSMutableArray new];
    NSArray *newsArticleList = [json safeValueForKey:kKEY_NEWS_ARTICLES];
    for (NSDictionary *newsArticleJSON in newsArticleList) {
        IRNewsArticles *newsArticle = [IRNewsArticles objectFromJSON:newsArticleJSON];
        [newsArticleObjects addObject:newsArticle];
    }
    return [newsArticleObjects copy];
}

@end
