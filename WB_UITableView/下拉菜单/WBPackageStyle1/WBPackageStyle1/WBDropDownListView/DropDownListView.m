//
//  DropDownListView.m
//  DropDownListView
//
//  Created by WMB on 2016/12/20.
//  Copyright © 2016年 文波. All rights reserved.
//

#import "DropDownListView.h"


static CGFloat const kCellHeight = 40;
static NSInteger const kMaxRow = 6;

static CGFloat const kSectionFontSize = 14.0;
@implementation DropDownListView

#pragma mark -- 初始化
#pragma mark
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        currentExtendSection = -1;
        self.dropDownDataSource = datasource;
        self.dropDownDelegate = delegate;
        
        
        NSInteger sectionNum =0;
        if ([self.dropDownDataSource respondsToSelector:@selector(numberOfSections)] ) {
            
            sectionNum = [self.dropDownDataSource numberOfSections];
        }
        
        if (sectionNum == 0) {
            self = nil;
        }
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:100];
        selectedsArray=[[NSMutableArray alloc]init];
        
        for (int i=0; i<sectionNum; i++) {
            [selectedsArray addObject:indexPath];
        }
        
        
        //初始化默认显示view
        CGFloat sectionWidth = (1.0*(frame.size.width)/sectionNum);
        for (int i = 0; i <sectionNum; i++) {
            UIButton *sectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth*i, 1, sectionWidth, frame.size.height-2)];
            sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
            [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
            NSString *sectionBtnTitle = @"--";
            
            
            if ([self.dropDownDataSource respondsToSelector:@selector(defaultTitleInSection:)]) {
                sectionBtnTitle = [self.dropDownDataSource defaultTitleInSection:i];
            }
            
            sectionBtn.backgroundColor=[UIColor whiteColor];
            [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [sectionBtn setTitleColor:[UIColor colorWithRed:35/225.0 green:173/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateSelected];
            sectionBtn.titleLabel.font = [UIFont systemFontOfSize:kSectionFontSize];
            [sectionBtn  setTitle:sectionBtnTitle forState:UIControlStateNormal];
            [self addSubview:sectionBtn];
            
            
            UIImageView *sectionBtnIv = [[UIImageView alloc] initWithFrame:CGRectMake(sectionWidth*i +(sectionWidth + [self calculationButtonTitleWidth:sectionBtnTitle]) / 2 + 10, (self.frame.size.height-5.5) / 2.0, 9, 5.5)];
            [sectionBtnIv setImage:[UIImage imageNamed:@"dropdown"]];
            [sectionBtnIv setContentMode:UIViewContentModeScaleToFill];
            sectionBtnIv.tag = SECTION_IV_TAG_BEGIN + i;
            
            [self addSubview: sectionBtnIv];
            
            if (i<sectionNum && i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(sectionWidth*i, frame.size.height/4, .5, frame.size.height/2)];
                lineView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
                [self addSubview:lineView];
            }
            
        }
        
    }
    return self;
}
#pragma mark -- private method
#pragma mark
- (CGFloat)calculationButtonTitleWidth:(NSString *)title {
    CGSize expectedLabelSize = CGSizeZero;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:kSectionFontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    expectedLabelSize = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return ceil(expectedLabelSize.width);
}

#pragma mark -- button aciotn
#pragma mark
- (void)sectionBtnTouch:(UIButton *)btn
{
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;
    
    UIImageView *currentIV= (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + currentExtendSection)];
    
    if (currentExtendSection == section) {
        btn.selected = NO;
        currentIV.image = [UIImage imageNamed:@"dropdown"];
        
        [self hideExtendedChooseView];
    }else{
        
        if (currentExtendSection != -1) {
            UIButton *tempButton = (UIButton *)[self viewWithTag:SECTION_BTN_TAG_BEGIN + currentExtendSection];
            tempButton.selected = NO;
            
            /**
             *  需要先将上一个选中的状态改为初始状态，在设置当前选中
             */
            currentIV = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + currentExtendSection];
            currentIV.image = [UIImage imageNamed:@"dropdown"];
        }
        btn.selected = YES;
        
        currentExtendSection = section;
        
        currentIV = (UIImageView *)[self viewWithTag:SECTION_IV_TAG_BEGIN + currentExtendSection];
        currentIV.image = [UIImage imageNamed:@"dropdownSel"];
        
        [self showChooseListViewInSection:currentExtendSection];
    }
    
}
- (void)setTitle:(NSString *)title inSection:(NSInteger) section
{
    UIButton *btn = (id)[self viewWithTag:SECTION_BTN_TAG_BEGIN +section];
    [btn setTitle:title forState:UIControlStateNormal];
}
- (BOOL)isShow
{
    if (currentExtendSection == -1) {
        return NO;
    }
    return YES;
}
-  (void)hideExtendedChooseView
{
    if (currentExtendSection != -1) {
        currentExtendSection = -1;
        CGRect rect = self.mTableView.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.mTableBaseView.alpha = 1.0f;
            self.mTableView.alpha = 1.0f;
            
            self.mTableBaseView.alpha = 0.2f;
            self.mTableView.alpha = 0.2;
            
            self.mTableView.frame = rect;
        }completion:^(BOOL finished) {
            [self.mTableView removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
        }];
    }
}

- (void)showChooseListViewInSection:(NSInteger)section
{
    if (!self.mTableView) {
        self.mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height , self.frame.size.width, self.mSuperView.frame.size.height - self.frame.origin.y - self.frame.size.height)];
        self.mTableBaseView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [self.mTableBaseView addGestureRecognizer:bgTap];
        
        self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 240) style:UITableViewStylePlain];
        self.mTableView.separatorColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        
        self.mTableView.tableFooterView = [[UIView alloc]init];
        
    }
    
    //修改tableview的frame
    int sectionWidth =CGRectGetWidth(self.frame);
    CGRect rect = self.mTableView.frame;
    rect.origin.x = 0;
    rect.size.width = sectionWidth;
    rect.size.height = 0;
    self.mTableView.frame = rect;
    [self.mSuperView addSubview:self.mTableBaseView];
    [self.mSuperView addSubview:self.mTableView];
    
    //动画设置位置
    CGFloat height = 0;
    NSInteger row = [self.dropDownDataSource numberOfRowsInSection:currentExtendSection];
    if (row >= kMaxRow) {
        height = kMaxRow * kCellHeight;
    } else {
        height = row * kCellHeight;
    }
    
    rect .size.height = height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mTableBaseView.alpha = 0.2;
        self.mTableView.alpha = 0.2;
        
        self.mTableBaseView.alpha = 1.0;
        self.mTableView.alpha = 1.0;
        self.mTableView.frame =  rect;
    }];
    [self.mTableView reloadData];
}

- (void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + currentExtendSection)];
    currentIV.image = [UIImage imageNamed:@"dropdown"];
    
    UIButton *currentSectionBtn = (UIButton *)[self viewWithTag:SECTION_BTN_TAG_BEGIN + currentExtendSection];
    currentSectionBtn.selected = NO;
    [self hideExtendedChooseView];
}

#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:)]) {
        
        [selectedsArray replaceObjectAtIndex:currentExtendSection withObject:indexPath];
        [tableView reloadData];
        
        NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
        
        UIButton *currentSectionBtn = (UIButton *)[self viewWithTag:SECTION_BTN_TAG_BEGIN + currentExtendSection];
        [currentSectionBtn setTitle:chooseCellTitle forState:UIControlStateNormal];
        
        currentSectionBtn.selected = NO;
        
        UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IV_TAG_BEGIN + currentExtendSection)];
        currentIV.image = [UIImage imageNamed:@"dropdown"];
        
        CGRect rect = currentIV.frame;
        rect.origin.x =  CGRectGetWidth(currentSectionBtn.frame) * currentExtendSection + (CGRectGetWidth(currentSectionBtn.frame) + [self calculationButtonTitleWidth:chooseCellTitle]) / 2.0 + 10;
        currentIV.frame = rect;
        
        [self.dropDownDelegate chooseAtSection:currentExtendSection index:indexPath.row];
        
        [self hideExtendedChooseView];
    }
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
#pragma mark
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dropDownDataSource numberOfRowsInSection:currentExtendSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dropDownDataSource titleInSection:currentExtendSection index:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    NSIndexPath *tmpIndexPath = selectedsArray[currentExtendSection];
    if (tmpIndexPath.row == indexPath.row && tmpIndexPath.section == indexPath.section) {
        cell.textLabel.textColor = [UIColor colorWithRed:35/225.0 green:173/255.0 blue:255/255.0 alpha:1.0];
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}
@end
