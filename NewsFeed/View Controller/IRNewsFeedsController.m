//
//  IRNewsFeedsController.m
//  NewsFeed
//
//  Created by Chandan Kumar on 05/01/24.
//

#import "IRNewsFeedsController.h"
#import "IRNewsFeedListViewModel.h"
#import "IRNewsItemCell.h"
#import "IRNewsCellViewModel.h"
#import "IRNewsDetailsController.h"
#import <Masonry/Masonry.h>

@interface IRNewsFeedsController()

@property (weak, nonatomic) IBOutlet UITableView *newsFeedTableView;
@property (nonatomic) IRNewsFeedListViewModel *newsListVM;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) UIActivityIndicatorView *loadingIndicator;

@end

@implementation IRNewsFeedsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"News Feed";
    [self.newsListVM addObserver:self forKeyPath:NSStringFromSelector(@selector(progressState)) options:NSKeyValueObservingOptionNew context:nil];
    [self addSubViews];
    [self fetchNewsList];
    [self.newsListVM setReachability];
}

- (void)addSubViews
{
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.newsFeedTableView addSubview:self.refreshControl];
    [self.view addSubview:self.loadingIndicator];
    [self setupView];
}

- (void)setupView
{
    [self.loadingIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(250);
    }];
}

- (void)fetchNewsList
{
    [self.newsListVM fetchNewsList];
    [self.loadingIndicator startAnimating];
}

- (UIActivityIndicatorView *)loadingIndicator
{
    if (!_loadingIndicator) {
        _loadingIndicator= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        _loadingIndicator.hidesWhenStopped = true;
        _loadingIndicator.frame = CGRectZero;
    }
    return _loadingIndicator;
}

- (IRNewsFeedListViewModel *)newsListVM
{
    if (!_newsListVM) {
        _newsListVM = [[IRNewsFeedListViewModel alloc] init];
    }
    return _newsListVM;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(progressState))]) {
        switch (self.newsListVM.progressState) {
            case IREndPointStarted:
                [self.loadingIndicator startAnimating];
                break;
            case IRNewsDataFetchedWithSuccess: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loadingIndicator stopAnimating];
                    [self.newsFeedTableView reloadData];
                });
                break;
            }
            case IRNewsDataFetchedWithError: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loadingIndicator stopAnimating];
                    [self DisplayAlertWithMSG:self.newsListVM.errors.localizedDescription];
                });
                break;
            }
            case IRNetworkNotAvailable: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loadingIndicator stopAnimating];
                    [self DisplayAlertWithMSG:@"Network not available currently. Please refresh page after some time."];
                });
                break;
            }
            case IRNetworkAvailable:
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self fetchNewsList];
                });
                break;
        }
    }
}

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    [self.newsListVM fetchNewsList];
}

- (void)DisplayAlertWithMSG:(NSString *)message {
  UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Alert! "
                                 message: message preferredStyle: UIAlertControllerStyleAlert];
  UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Dismiss"
                            style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {}];
  [alertvc addAction: action];
  [self presentViewController: alertvc animated: true completion: nil];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsListVM.newsCellModels.count;
}

- (IRNewsItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IRNewsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    IRNewsCellViewModel *cellViewModel = [self.newsListVM.newsCellModels objectAtIndex:indexPath.row];
    cell.cellViewModel = cellViewModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IRNewsCellViewModel *cellViewModel = [self.newsListVM.newsCellModels objectAtIndex:indexPath.row];
    IRNewsDetailsController *detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"news_details_view_controller"];
    detailsView.newsCellVM = cellViewModel;
    [self.navigationController pushViewController:detailsView animated:true];
}


@end
