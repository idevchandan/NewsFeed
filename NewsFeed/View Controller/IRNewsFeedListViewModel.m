//
//  IRNewsFeedListViewModel.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRNewsFeedListViewModel.h"
#import "IRNetworkManager.h"
#import "IRNewsResponse.h"
#import "IRNewsArticles.h"
#import "IRNewsCellViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "Reachability.h"

@interface IRNewsFeedListViewModel ()
@property (nonatomic, readwrite) NSArray <IRNewsCellViewModel *> *newsCellModels;
@property (nonatomic) Reachability *reachabilityMonitor;
@end

@implementation IRNewsFeedListViewModel

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)setReachability
{
    self.reachabilityMonitor = [Reachability reachabilityForInternetConnection];
    [self.reachabilityMonitor startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(networkAvailabilityChanged:) name:  kReachabilityChangedNotification object: self.reachabilityMonitor];
}

- (BOOL)isNetworkConnectionAvailable
{
    return  ([self.reachabilityMonitor currentReachabilityStatus] != NotReachable);
}

- (void)fetchNewsList
{
    self.progressState = IREndPointStarted;
    
    [[IRNetworkManager fetchDataFromAPI] subscribeNext:^(id x) {
        IRNewsResponse *newsResponse = x;
        [self listNewsItem: newsResponse];
    } error:^(NSError *error) {
        self.errors = error;
        self.progressState = IRNewsDataFetchedWithError;
    }];
}

- (void)listNewsItem:(IRNewsResponse *)newsResponse
{
    NSArray *newsList = newsResponse.newsArticles;
    if (newsList.count) {
        NSMutableArray *tempNewsCellModels = [[NSMutableArray alloc] init];
        [newsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            IRNewsCellViewModel *cellViewModel = [[IRNewsCellViewModel alloc] initWithModel:obj forCellIndex:idx];
            [tempNewsCellModels addObject:cellViewModel];
        }];
        self.newsCellModels = [tempNewsCellModels copy];
        self.progressState = IRNewsDataFetchedWithSuccess;
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:kReachabilityChangedNotification];
}

- (void)networkAvailabilityChanged:(NSNotification *)notice
{
    Reachability *reachability = (Reachability *)[notice object];
    if ([reachability currentReachabilityStatus] == NotReachable) {
        self.progressState = IRNetworkNotAvailable;
    } else {
        self.progressState = IRNetworkAvailable;
    }
}

@end
