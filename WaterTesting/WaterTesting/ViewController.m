//
//  ViewController.m
//  WaterTesting
//
//  Created by 胡金友 on 15/7/2.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewLayout.h"
#import "AUUCollectionViewLayout.h"
#import "Control.h"
#import "CustomCollectionViewCell.h"

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
AUUCollectionViewLayoutDelegate
//MyCollectionViewLayoutDelegate
>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSMutableArray *itemHeights;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
    _itemHeights = [[NSMutableArray alloc] init];
    
    [self addDataSource];
}

- (void)addDataSource
{
    for (NSInteger i = 0; i < 20 ; i ++)
    {
        [_dataSource addObject:@"1"];
        
        CGFloat itemHeight = arc4random()%200 + 30;
        [_itemHeights addObject:@(itemHeight)];
    }
}

- (void)initializeUserInterface
{
#ifdef MoreRows
    AUUCollectionViewLayout *layout = [[AUUCollectionViewLayout alloc] init];
    layout.numberOfRows = 4;
    layout.layoutDelegate = self;
#else
    MyCollectionViewLayout *layout = [[MyCollectionViewLayout alloc] init];
    layout.layoutDelegate = self;
#endif
    
    CGRect rect = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20);
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"reUsefulCollectionViewCell"];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reUsefulCollectionViewCell" forIndexPath:indexPath];
    
//    NSLog(@"%@",NSStringFromCGRect(cell.frame));
    
    
//    CGRect rect = cell.frame;
//
//    CGFloat radius = 0;
//    
//    if (rect.size.width > rect.size.height)
//    {
//        radius = rect.size.height / 2.0;
//    }
//    else
//    {
//        radius = rect.size.width / 2.0;
//    }
//    
//    cell.layer.masksToBounds = YES;
//    cell.layer.borderColor = [UIColor whiteColor].CGColor;
//    cell.layer.borderWidth = 3;
//    cell.layer.cornerRadius = radius;
    
    CGFloat r = (indexPath.row * 1) % 255;
    CGFloat g = (indexPath.row * 2) % 255;
    CGFloat b = (indexPath.row * 3) % 255;
    
    [cell.label setText:[NSString stringWithFormat:@"%@\nr:%@ g:%@ b:%@",@(indexPath.row), @(r), @(g), @(b)]];
    
    cell.label.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    cell.backgroundColor = [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
    
    return cell;
}

#ifdef MoreRows

#pragma mark - AUUCollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(AUUCollectionViewLayout *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 30) / 2.0, [_itemHeights[indexPath.row] floatValue]);
}

#else

#pragma mark - MyCollectionViewLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(MyCollectionViewLayout *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 30) / 2.0, [_itemHeights[indexPath.row] floatValue]);
}

#endif

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.contentSize;
    
    CGFloat excursion = scrollView.frame.size.height - (size.height - offset.y);
    
    if (excursion >= 0)
    {
//        NSLog(@"%@", @(excursion));
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.contentSize;
    
    CGFloat excursion = scrollView.frame.size.height - (size.height - offset.y);
    
    if (excursion >= 60)
    {
        [(AUUCollectionViewLayout *)self.collectionView.collectionViewLayout resetLayout];
        
        [self addDataSource];
        
        [self.collectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
