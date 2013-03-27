//
//  ViewController.m
//  DYTextImageView
//
//  Created by MISS.RKK on 13-3-22.
//  Copyright (c) 2013年 Dskyu. All rights reserved.
//

#import "ViewController.h"
#import "YBLHttpApi.h"
#import "ContentCell.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize refreshing;
@synthesize dataArray = _dataArray;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataArray = [[NSMutableArray alloc] init];
    _lastItemTime = 0;
    
    CGRect bounds = self.view.bounds;
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];

    [self loadData];
    if (_lastItemTime == 0) {
        [self.tableView launchRefreshing];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadData
{
    YBLHttpApi *httpApi = [[YBLHttpApi alloc] initWithDomain:URL_DOMAIN clientVersion:nil isHttps:NO];
    [httpApi setResponseDelegate:self];
    [httpApi searchJobsByName:nil time:_lastItemTime];
}


#pragma mark -
#pragma Http Api Delegate
- (void)weiboSearchJobsRecevied:(YBLJobArray *)jobs
{
    if (self.refreshing) {
        self.refreshing = NO;
        [self.dataArray removeAllObjects];
        self.dataArray = jobs;        
    }else{
        for (NSMutableArray *one in jobs) {
            [_dataArray addObject:one];
        }
        
    }
    YBLJob *job = [jobs lastObject];
    _lastItemTime = [job.time integerValue];
    
   [self.tableView reloadData];
    if ([jobs count] < 10) {
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"下面没有了.."];
        self.tableView.reachedTheEnd  = YES;
    } else {
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd  = NO;
        
    }
}


#pragma mark -
#pragma TableView DataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Contentidentifier = @"ContentCELL";
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:Contentidentifier];
    if (cell == nil){
        //设置cell 样式
        cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Contentidentifier] ;
        cell.textImageView.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    YBLJob *job = [self.dataArray objectAtIndex:indexPath.row];
    [cell refreshData:job];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellHeight:indexPath];
}

- (CGFloat) getCellHeight:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    
    YBLJob *job = [self.dataArray objectAtIndex:indexPath.row];
    NSString *content = job.content;
    CGFloat maxHeight = [font lineHeight]*MaxNumberOfLines;
    if (job.thumbnail) {
        NSLog(@"thumbnail  %@",job.thumbnail);
        NSLog(@"oripic   %@",job.origpic);
    }
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(300, maxHeight) lineBreakMode:UILineBreakModeTailTruncation];
    
    if (size.height > maxHeight) {
        size.height = maxHeight;
    }
    
    if (job.thumbnail) {
        size.height += 120;
    }
    
    return size.height + 80;
}


#pragma mark -
#pragma PullRefresh Delegate

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    _lastItemTime = 0;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - 
#pragma DYTextImageView Delegate


- (void)textImageView:(DYTextImageView*)textImageView textDidBeginTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    
}

- (void)textImageView:(DYTextImageView*)textImageView textDidMoveTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{

}
- (void)textImageView:(DYTextImageView*)textImageView textDidEndTouch:(UITouch*)touch onKeyInRange:(NSRange)range
{
    
    [self touchedInside:range inTextImageView:textImageView];
}
- (void)textImageView:(DYTextImageView *)textImageView textDidCancelTouch:(UITouch *)touch
{
    
}

- (void)textImageView:(DYTextImageView *)textImageView imageDidTouchedInside:(DYinternalImageView *)imageView
{
    FullScreenImageView *fullView = [[FullScreenImageView alloc] initWithImage:imageView.image inFrame:self.view.window.bounds withThumbnailImageFrame:[imageView convertRect:imageView.bounds toView:self.view.window] andOriginUrl:[NSURL URLWithString:imageView.oripicUrl]];
   // fullView.myDelegate = self;
    [self.view.window addSubview:fullView];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

#pragma mark --

- (void)touchedInside:(NSRange)range inTextImageView:(DYTextImageView *)textImageView
{
    NSMutableAttributedString* attributedString = [textImageView.label.attributedText mutableCopy];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor grayColor] range:range];
    textImageView.label.attributedText = attributedString;
    self.highlightedRange = range;
    
    [textImageView.label.attributedText enumerateAttributesInRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        NSString *str = [attrs objectForKey:@"href"];
        if (str ) {
            NSString *a = [[textImageView.label.attributedText attributedSubstringFromRange:range] string];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"selected"
                                                            message:[NSString stringWithFormat:@"%@ say:%@",a,str]
                                                           delegate:nil
                                                  cancelButtonTitle:@"nonono"
                                                  otherButtonTitles:@"go!", nil];
            [alert show];
        }
    }];
    
    [self performSelector:@selector(touchEndInTextImageView:) withObject:textImageView afterDelay:.3f];
}

- (void)touchEndInTextImageView:(DYTextImageView *)textImageView
{
    NSMutableAttributedString *attributedString = [textImageView.label.attributedText mutableCopy];
    [attributedString removeAttribute:NSBackgroundColorAttributeName range:self.highlightedRange];
    textImageView.label.attributedText = attributedString;
}





@end
