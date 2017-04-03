
//
//  MustListViewController.m
//  音乐播放器
//
//  Created by mac on 2017/4/3.
//  Copyright © 2017年 macTb. All rights reserved.
//  音乐列表控制器

#import "MustListViewController.h"
#import "UIBarButtonItem+MJ.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "Music.h"
#import "RequestManager.h"
#import <Masonry.h>
@interface MustListViewController ()<UITableViewDelegate,UITableViewDataSource>

//毛玻璃
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong)UIVisualEffectView *visualeffectview;

@property (nonatomic, strong)NSArray *musicListArray;

//tableView背景图片
@property(nonatomic,strong)UIImageView *tableViewBackgroundImage;

@property (nonatomic, strong)UILabel *theAlbumNameLabel;
@end

@implementation MustListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupNav];
    [self stupBackView];
 
    [self setuMusicData];
    
}

- (void)setuMusicData
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [[RequestManager sharedManager] fetchDataWithUrl:kMusicList updateUI:^{
        [SVProgressHUD dismiss];
        Music *music =[[RequestManager sharedManager]returnMusicAtIndex:0];
        
        self.theAlbumNameLabel.text = music.listName;
        // 歌单背景
        [self.tableViewBackgroundImage sd_setImageWithURL:[NSURL URLWithString:music.listTheCoverUrl]];
    }];
    
  }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    // 设置导航栏背景为透明状态
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    // 导航栏下的细线
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    
//    NSLog(@"%@", self.navigationController.navigationBar.subviews.firstObject);
//    
//    self.navigationController.navigationBar.alpha = 0.3;
//    self.title = @"歌单";
    
    
    //导航栏加任务栏透明
    self.navigationController.navigationBar.translucent =YES;
    UIColor *color =[UIColor clearColor];
    CGRect rect =CGRectMake(0.0f, 0.0f,self.view.frame.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsGetImageFromCurrentImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //标题
    self.navigationItem.title = @"歌单";
}

- (void)setupNav
{
    //去除头部空白
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"cm2_topbar_icn_playing" highIcon:nil target:self action:@selector(rightBarButtonItemAction)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"cm2_topbar_icn_back" highIcon:nil target:self action:nil];
    
    // 毛玻璃
    UIBlurEffect *blureffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // 添加毛玻璃view视图
    self.visualeffectview = [[UIVisualEffectView alloc] initWithEffect:blureffect];
    self.visualeffectview.frame = CGRectMake(0, 0, kWidth, kHeight *0.383f);
    
    //tabbleView区头
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight *0.2975f)];
    headerView.backgroundColor =[UIColor clearColor];
    self.tableView.backgroundColor= [UIColor clearColor];
    self.tableView.tableHeaderView =headerView;

}

- (void)stupBackView
{
    self.tableViewBackgroundImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight *0.383f)];
    [self.tableViewBackgroundImage setImage:[UIImage imageNamed:@"cm2_default_cover_playlistonly_112"]];
    self.tableViewBackgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    self.tableViewBackgroundImage.clipsToBounds = YES;
    self.tableViewBackgroundImage.backgroundColor = [UIColor clearColor];
    
    self.theAlbumNameLabel = [[UILabel alloc] init];
    [self.tableViewBackgroundImage addSubview:self.theAlbumNameLabel];
    self.theAlbumNameLabel.textColor = [UIColor whiteColor];
    [self.theAlbumNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tableViewBackgroundImage);
        make.centerY.equalTo(self.tableViewBackgroundImage);
    }];
    
    
    
    //添加到背景显示
    [self.view insertSubview:self.tableViewBackgroundImage atIndex:0];
    
    
}

- (void)rightBarButtonItemAction
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"music"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <0) {
        self.tableViewBackgroundImage.frame  =CGRectMake(scrollView.contentOffset.y/2, 0, kWidth +(-scrollView.contentOffset.y), (kHeight*0.383f)+(-scrollView.contentOffset.y));
        self.visualeffectview.frame  =CGRectMake(scrollView.contentOffset.y/2, 0, kWidth +(-scrollView.contentOffset.y), (kHeight*0.383f)+(-scrollView.contentOffset.y));
        
    }
    
     //self.tableViewBackgroundImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight *0.383f)];
}
@end
