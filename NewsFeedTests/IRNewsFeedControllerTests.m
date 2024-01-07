//
//  IRNewsFeedControllerTests.m
//  NewsFeedTests
//
//  Created by Chandan Kumar on 07/01/24.
//

#import <XCTest/XCTest.h>
#import "IRNewsFeedsController_Private.h"

@interface IRNewsFeedControllerTests : XCTestCase

@property (nonatomic) IRNewsFeedsController *newsFeedViewController;

@end

@implementation IRNewsFeedControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.newsFeedViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"news_feed_view_controller"];
    [self.newsFeedViewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [self.newsFeedViewController performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
}

- (void)tearDown {
    self.newsFeedViewController = nil;
}

#pragma mark - News Feed Controller tests

-(void)testThatNewsFeedControllerViewLoads
{
    XCTAssertNotNil(self.newsFeedViewController.view, @"View not initiated properly");
}

- (void)testNewsFeedControllerIsComposedOfTableView {
    NSArray *subviews = self.newsFeedViewController.view.subviews;
        XCTAssertTrue([subviews containsObject:self.newsFeedViewController.newsFeedTableView], @"ViewController under test is not composed of a UITableView");
}

-(void)testThatNewsFeedTableViewLoads
{
    XCTAssertNotNil(self.newsFeedViewController.newsFeedTableView, @"News Feed TableView not initiated");
}

#pragma mark - UITableView tests

- (void)testThatNewsFeedViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.newsFeedViewController conformsToProtocol:@protocol(UITableViewDataSource) ], @"News Feed View does not conform to UITableView datasource protocol");
}

- (void)testThatNewsFeedTableViewHasDataSource
{
    XCTAssertNotNil(self.newsFeedViewController.newsFeedTableView.dataSource, @"News Feed Table datasource cannot be nil");
}

- (void)testThatNewsFeedViewConformsToUITableViewDelegate
{
     XCTAssertTrue([self.newsFeedViewController conformsToProtocol:@protocol(UITableViewDelegate) ], @"News Feed View does not conform to UITableView delegate protocol");
}

- (void)testNewsFeedTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.newsFeedViewController.newsFeedTableView.delegate, @"News Feed Table delegate cannot be nil");
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.newsFeedViewController tableView:self.newsFeedViewController.newsFeedTableView cellForRowAtIndexPath:indexPath];
    NSString *expectedReuseIdentifier = @"newsCell";
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
