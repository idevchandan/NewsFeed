//
//  IRFetchImageManager.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRFetchImageManager.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface IRFetchImageManager ()

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSCache *imageCache;

- (RACSignal *) downloadImageFrom:(NSURL *)url;

@end

@implementation IRFetchImageManager

+ (instancetype)sharedInstance
{
    static IRFetchImageManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [IRFetchImageManager new];
        [sharedInstance initManager];
    });
    return sharedInstance;
}

- (void) initManager
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    

    NSURLCache *newsFeedCache = [[NSURLCache alloc] initWithMemoryCapacity: 16384 diskCapacity: 268435456 diskPath: @"/NewsFeedCacheDirectory"];
    defaultConfigObject.URLCache = newsFeedCache;
    defaultConfigObject.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;

    self.session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    self.imageCache = [NSCache new];
}

- (RACSignal *) downloadImageFrom:(NSURL *)url
{
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        
        NSLog(@"downloading : %@", url);
        
        NSURLSessionDataTask *task = [self.session dataTaskWithURL: url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error){
                NSLog(@"download error : %@", error);
                [subscriber sendError:error];
                
            } else {
                NSLog(@"download success : %@", response.URL);
                [subscriber sendNext:data];
                [subscriber sendCompleted];
            }
            
        }] ;
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *) decode:(NSData *)data
{
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    return [[RACSignal startLazilyWithScheduler:scheduler block:^(id <RACSubscriber> subscriber) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        [subscriber sendNext:image];
        [subscriber sendCompleted];
        
    }] deliverOn:[RACScheduler mainThreadScheduler]];
}

- (RACSignal *) fetch:(NSURL *)url
{
    UIImage *image = [self.imageCache objectForKey:url];
    if (image){
        return [RACSignal return:image];
    }
    
    NSLog(@"cache miss %@", url);
    return [[[self downloadImageFrom:url]
             flattenMap:^(NSData *data) {
        return [self decode:data];
        
    }] doNext:^(UIImage *image) {
        
        [self.imageCache setObject:image forKey:url];
        
    }];
}


@end
