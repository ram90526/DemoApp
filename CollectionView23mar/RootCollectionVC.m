//
//  ViewController.m
//  CollectionView23mar
//
//  Created by SOM LIMBU on 23/03/16.
//  Copyright © 2016 SOM LIMBU. All rights reserved.
//

#import "RootCollectionVC.h"
#import "DisplayImageVC.h"
#import "HeaderViewCV.h"
#import "SelectionViewController.h"

@interface RootCollectionVC ()

@property (strong,nonatomic)UICollectionView*cv;



@end

@implementation RootCollectionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //klsdnknjfnjsnj
    self.mainImagesArray=[[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] init],[[NSMutableArray alloc]init], nil];
    
    self.statusArray=[[NSMutableArray alloc]initWithObjects:[[NSMutableDictionary alloc] init],[[NSMutableDictionary alloc]init], nil];
    
    
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.segmentedController.momentary=YES;
    [self collectionViewData];
    
       }


-(void)collectionViewData
{

    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing=0.0f;
    flowLayout.minimumLineSpacing=3.0f;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize=CGSizeMake(100,100);
    flowLayout.sectionInset = UIEdgeInsetsMake(50, 0, 50, 0);
    
    self.cv=[[UICollectionView alloc]initWithFrame:CGRectMake(10,150, self.view.bounds.size.width-20, self.view.bounds.size.height-200) collectionViewLayout:flowLayout];
    [self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.cv registerClass:[HeaderViewCV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

    self.cv.backgroundColor=[UIColor grayColor];
    self.cv.layer.borderWidth=3.0f;
    self.cv.delegate=self;
    self.cv.dataSource=self;
    
    [self.view addSubview:self.cv];
    
}

//********************************* Collection View DelegateMethods *************************//

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return self.mainImagesArray.count;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
         HeaderViewCV*headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.headerTittle.text = @"Gallery";
        UIImage *headerImage = [UIImage imageNamed:@"images.png"];
        headerView.headerImageView.image = headerImage;
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [[self.mainImagesArray objectAtIndex:section] count];
    
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 0, 20);
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat requiredCells;
    requiredCells=3;

    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        requiredCells=5;
       
    }
    CGFloat widthOfCell =(self.cv.frame.size.width-30)/requiredCells;
    CGFloat heightOfCell =widthOfCell;
    CGSize returnValue = CGSizeMake(widthOfCell, heightOfCell);

    
    return returnValue;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString*str=@"cellIdentifier";

    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,cell.bounds.size.width,cell.bounds.size.height)];
    self.imgView.backgroundColor=[UIColor greenColor];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;
    
    self.imgView.image = [[self.mainImagesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
    
    self.checkBoxImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.imgView.frame.origin.x+60,self.imgView.frame.origin.y+60 , 20,20)];
    
    [self.imgView addSubview:self.checkBoxImageView];
    
    NSString*valueStr=[[self.statusArray objectAtIndex:indexPath.section] objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.item]];
    
    if ([valueStr isEqualToString:@"0"])
    {
        self.checkBoxImageView.image=[UIImage imageNamed:@"unClick.png"];
    }
    else
    {
        self.checkBoxImageView.image=[UIImage imageNamed:@"click.png"];
        
        
    }
   
    
    
    [cell addSubview:self.imgView];
    
    
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSString*valueStr=[[self.statusArray objectAtIndex:indexPath.section] objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.item]];
    
    if ([valueStr isEqualToString:@"0"]) {
        
        
        [[self.statusArray objectAtIndex:indexPath.section] setObject:@"1" forKey:[NSString stringWithFormat:@"%d",(int)indexPath.item]];
        
    }
    else{
    [[self.statusArray objectAtIndex:indexPath.section] setObject:@"0" forKey:[NSString stringWithFormat:@"%d",(int)indexPath.item]];

    }
    [self.cv reloadData];
   
    NSLog(@" upadating dict%@",self.statusArray);

//    [self performSegueWithIdentifier:@"nextVC" sender:self];
    
}


//**************************Segmented Controller*********************//

- (IBAction)imagesSegment:(UISegmentedControl*)sender
{
    
    switch (self.segmentedController.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"Gallery btn clicked");
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                
            }
            self.str1=@"Gallery";

            [self presentViewController:self.imagePicker animated:YES completion:nil];

            break;
            
            case 1:
            NSLog( @"Camera btn clicked!" );
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                
            }
            self.str1=@"Camera";

            [self presentViewController:self.imagePicker animated:YES completion:nil];
            
            default:
            break;
     }
}

//***************************ImagePickerController*************************//

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    
    if ([self.str1 isEqualToString:@"Gallery"])
        
    {

        
        [[self.mainImagesArray objectAtIndex:0] addObject:chosenImage];
       unsigned long int new=[[self.mainImagesArray objectAtIndex:0] count];
        
        [[self.statusArray objectAtIndex:0] setValue:@"0" forKey:[NSString stringWithFormat:@"%lu",new-1]];

        
    }
    else if ([self.str1 isEqualToString:@"Camera"])
        
    {
        
        [[self.mainImagesArray objectAtIndex:1]addObject:chosenImage];
        unsigned long int new=[[self.mainImagesArray objectAtIndex:1] count];
        
        [[self.statusArray objectAtIndex:1] setValue:@"0" forKey:[NSString stringWithFormat:@"%lu",new-1]];
       
    
    }
    NSLog(@"images %@", self.mainImagesArray);
    NSLog(@"count %@",self.statusArray);
    
    [self.cv reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{


    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)nextBtn:(id)sender
{
    
    //****************************Gallery*******************************//
    
    self.tempArray1=[[NSMutableArray alloc]init];

    for (int i=0; i<=[[self.statusArray objectAtIndex:0] count]; i++)
    {
         NSLog(@"keys are %@",[[self.statusArray objectAtIndex:0]objectForKey:[NSString stringWithFormat:@"%d",i]]);
        
        if ([[[self.statusArray objectAtIndex:0]objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:@"1"])
        {
            
        [self.tempArray1 addObject:[[self.mainImagesArray objectAtIndex:0]objectAtIndex:i]];
            
            NSLog(@"images %@",self.tempArray1);
            
        }
        
        else if ([[[self.statusArray objectAtIndex:0]objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:@"0"])
        {
          [self.tempArray1 removeObject:[[self.mainImagesArray objectAtIndex:0]objectAtIndex:i]];
             NSLog(@"remove images Gallery %@",self.tempArray1);
        
        }
    }
    
    //****************************Camera*******************************//

    
    self.tempArray2=[[NSMutableArray alloc]init];

    for (int i=0; i<=[[self.statusArray objectAtIndex:1] count]; i++)
    {
        
        
        NSLog(@"keys are %@",[[self.statusArray objectAtIndex:1]objectForKey:[NSString stringWithFormat:@"%d",i]]);
        
        if ([[[self.statusArray objectAtIndex:1]objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:@"1"])
        {
            
       [self.tempArray2 addObject:[[self.mainImagesArray objectAtIndex:1]objectAtIndex:i]];
            
            NSLog(@"images %@",self.tempArray2);
            
        }
        else if ([[[self.statusArray objectAtIndex:1]objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:@"0"])
        {
            [self.tempArray2 removeObject:[[self.mainImagesArray objectAtIndex:1]objectAtIndex:i]];
            NSLog(@"remove images Camera %@",self.tempArray2);
            
        }
        
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //    if ([segue.identifier isEqualToString:@"nextVC"])
    //    {
    //        DisplayImageVC *DVC = (DisplayImageVC *)segue.destinationViewController;
    //
    //        DVC.dpImg=tempImg;
    //
    //    }
    
    
    if ([segue.identifier isEqualToString:@"nextVCSegue"])
    {
        
        SelectionViewController*selectedVC=(SelectionViewController*)segue.destinationViewController;
        
        
        selectedVC.tempArrayInSelectionVC=self.tempArray1;
        selectedVC.tempArray2InSelectionVC=self.tempArray2;
        
        
        NSLog(@"Selected images %@",selectedVC.tempArrayInSelectionVC);
        NSLog(@"Selected images %@",selectedVC.tempArray2InSelectionVC);

    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.cv reloadData];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
