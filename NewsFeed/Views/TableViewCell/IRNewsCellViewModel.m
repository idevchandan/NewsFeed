//
//  IRNewsCellViewModel.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRNewsCellViewModel.h"
#import "IRFetchImageManager.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface IRNewsCellViewModel()

@property (nonatomic, readwrite) NSString *newsTitle;
@property (nonatomic, readwrite) NSString *newsDescription;
@property (nonatomic, readwrite) NSString *newsURL;
@property (nonatomic, readwrite) NSString *newsImageURL;
@property (nonatomic, readwrite) NSString *newsPublishedDate;
@property (nonatomic, readwrite) NSString *newsContent;
@property (nonatomic, readwrite) UIImage *newsArticleImage;

@end

@implementation IRNewsCellViewModel

- (instancetype)initWithModel:(IRNewsArticles *)newsArticle forCellIndex:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.newsTitle = newsArticle.newsTitle;
        self.newsDescription = newsArticle.newsDescription;
        self.newsURL = newsArticle.newsURL;
        self.newsImageURL = newsArticle.newsImageURL;
        self.newsPublishedDate = [self formattedDate:newsArticle.newsPublishedDate];
        self.newsContent = newsArticle.newsContent;
        [self fetchNewsArticleImage];
    }
    
    return  self;
}

- (NSString *)formattedDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *formattedDate = [dateFormatter dateFromString:dateStr];
    
    return [NSDateFormatter localizedStringFromDate:formattedDate
                                                          dateStyle:NSDateFormatterMediumStyle
                                                          timeStyle:NSDateFormatterMediumStyle];
}

- (void)fetchNewsArticleImage
{
    NSURL *imageURL = [NSURL URLWithString:self.newsImageURL];
    [[[IRFetchImageManager sharedInstance] fetch:imageURL] subscribeNext:^(id x) {
        UIImage *newsArticleImage = x;
        self.newsArticleImage = newsArticleImage;
        
    } error:^(NSError * _Nullable error) {
        self.newsArticleImage = [UIImage imageNamed:@"Placeholder"];
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

@end
