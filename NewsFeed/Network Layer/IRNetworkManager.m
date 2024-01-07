//
//  IRNetworkManager.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRNetworkManager.h"
#import "IRNewsResponse.h"
#import "NewsResponseParser.h"
#import "APIDefines.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation IRNetworkManager

+ (RACSignal *)fetchDataFromAPI {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURL *url = [self getNewsFeedURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                NSError *jsonError;
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    [subscriber sendError:jsonError];
                } else {
                    IRNewsResponse *newsResponse = [NewsResponseParser newsParsedFromJSON:responseObject];
                    [subscriber sendNext:newsResponse];
                    [subscriber sendCompleted];
                }
            }
        }];

        [task resume];

        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

+ (NSURL *)getNewsFeedURL
{
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = kKEY_SCHEME;
    components.host = kKEY_HOST;
    components.path = kKEY_END_POINT;
    NSURLQueryItem *country = [NSURLQueryItem queryItemWithName:kKEY_COUNTRY value:kKEY_SELLECTED_COUNTRY];
    NSURLQueryItem *pageSize = [NSURLQueryItem queryItemWithName:kKEY_PAGE_SIZE value:kKEY_MAX_PAGE_SIZE];
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:kKEY_API_KEY value:kKEY_NEWS_FEED_API_KEY];
    components.queryItems = @[ country, pageSize, apiKey ];
    return components.URL;
}

@end
