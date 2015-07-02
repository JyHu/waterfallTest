//
//  ViewController.m
//  WaterTesting
//
//  Created by 胡金友 on 15/7/2.
//  Copyright (c) 2015年 胡金友. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewLayout.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MyCollectionViewLayoutDelegate>

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
    for (NSInteger i = 0; i < 15 ; i ++)
    {
        [_dataSource addObject:@"1"];
        
        CGFloat itemHeight = arc4random()%200 + 20;
        [_itemHeights addObject:@(itemHeight)];
    }
}

- (void)initializeUserInterface
{
    MyCollectionViewLayout *layout = [[MyCollectionViewLayout alloc] init];
    layout.layoutDelegate = self;
    
    CGRect rect = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20);
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reUsefulCollectionViewCell"];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reUsefulCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1];
    
    return cell;
}

#pragma mark - MyCollectionViewLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(MyCollectionViewLayout *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 30) / 2.0, [_itemHeights[indexPath.row] floatValue]);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.contentSize;
    
    CGFloat excursion = scrollView.frame.size.height - (size.height - offset.y);
    
    if (excursion >= 0)
    {
        NSLog(@"%@", @(excursion));
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.contentSize;
    
    CGFloat excursion = scrollView.frame.size.height - (size.height - offset.y);
    
    if (excursion >= 60)
    {
        [self addDataSource];
        
        [self.collectionView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
