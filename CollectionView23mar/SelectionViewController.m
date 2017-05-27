//
//  SelectionViewController.m
//  CollectionView23mar
//
//  Created by SOM LIMBU on 30/03/16.
//  Copyright © 2016 SOM LIMBU. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation SelectionViewController

@synthesize tempArrayInSelectionVC,tempArray2InSelectionVC;

- (void)viewDidLoad
 {
    
       [super viewDidLoad];
    
    self.selectedImagesArray=[[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] init],[[NSMutableArray alloc]init], nil];
    
    self.selectedStatusArray=[[NSMutableArray alloc]initWithObjects:[[NSMutableDictionary alloc] init],[[NSMutableDictionary alloc]init], nil];
     
     [[self.selectedImagesArray objectAtIndex:0] addObjectsFromArray:self.tempArrayInSelectionVC];
     [[self.selectedImagesArray objectAtIndex:1] addObjectsFromArray:self.tempArray2InSelectionVC];

     [self collectionViewData];

    
 }

-(void)collectionViewData
{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing=0.0f;
    flowLayout.minimumLineSpacing=3.0f;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize=CGSizeMake(100,100);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    self.selectedCollectinView=[[UICollectionView alloc]initWithFrame:CGRectMake(10,150, self.view.bounds.size.width-20, self.view.bounds.size.height-200) collectionViewLayout:flowLayout];
    [self.selectedCollectinView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.selectedCollectinView.backgroundColor=[UIColor grayColor];
    self.selectedCollectinView.layer.borderWidth=3.0f;
    self.selectedCollectinView.delegate=self;
    self.selectedCollectinView.dataSource=self;
    
    [self.view addSubview:self.selectedCollectinView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.selectedImagesArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [[self.selectedImagesArray objectAtIndex:section] count];
    
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 20);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString*str=@"cellIdentifier";
    
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    self.selectedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,cell.bounds.size.width,cell.bounds.size.height)];
    self.selectedImgView.backgroundColor=[UIColor greenColor];
    self.selectedImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.selectedImgView.clipsToBounds = YES;
    
    self.selectedImgView.image = [[self.selectedImagesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    
    [cell addSubview:self.selectedImgView];

    
    return cell;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
   [self.selectedCollectinView reloadData];


}

- (void)didReceiveMemoryWarning
 {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
