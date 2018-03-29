//
//  WB_AddressPickerView.m
//  WB_AddressPickerView
//
//  Created by Admin on 2017/7/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBAddressPickerView.h"

#define kMasKBackgroudColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define kFont [UIFont systemFontOfSize:16.f]
#define KPadding 5.f
/*
 屏幕宽高
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

static CGFloat const kContentViewHeight = 266.f;
static CGFloat const kTopViewHeight = 50.f;

@interface WBAddressPickerView () <UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *currentProvice;
    NSString *currentCity;
    NSString *currentArea;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSArray *areas;

@end

@implementation WBAddressPickerView

#pragma mark -- 视图初始化
#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
        [self setupUI];
    }
    return self;
}

#pragma mark -- 初始化数据
#pragma mark
- (void)initData {
    /** 第一个省份全部城市 */
    self.cities = [[self.provinces objectAtIndex:0] objectForKey:@"cities"];
    /** 第一个省份 */
    currentProvice = [[self.provinces objectAtIndex:0] objectForKey:@"state"];
    /** 第一个省份对应一个市 */
    currentCity = [[self.cities objectAtIndex:0] objectForKey:@"city"];
    /** 第一个省份对应的第一个市对应的一个区 */
    self.areas = [[self.cities objectAtIndex:0] objectForKey:@"areas"];
    if (self.areas > 0) {
        currentArea = [self.areas objectAtIndex:0];
    }else {
        currentArea = @"";
    }
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    self.backgroundColor = kMasKBackgroudColor;
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.bounds = SCREEN_BOUNDS;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.pickerView];
    [self.topView addSubview:self.cancelBtn];
    [self.topView addSubview:self.confirmBtn];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
#pragma mark
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [self.provinces count];
            break;
        case 1:
            return [self.cities count];
            break;
        case 2:
            return [self.areas count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [[self.provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[self.cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if (self.areas.count > 0) {
                return [self.areas objectAtIndex:row];
                break;
            }
        default:
            return @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [pickerView selectRow:row inComponent:component animated:YES];
    switch (component) {
        case 0:
            self.cities = [[self.provinces objectAtIndex:row] objectForKey:@"cities"];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView reloadComponent:1];
            self.areas = [[self.cities objectAtIndex:0] objectForKey:@"areas"];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
            currentProvice = [[self.provinces objectAtIndex:row] objectForKey:@"state"];
            currentCity = [self.cities.firstObject objectForKey:@"city"];
            if (self.areas.count > 0) {
                currentArea = self.areas.firstObject;
            }else {
                currentArea = @"";
            }
            break;
        case 1:
            self.areas = [[self.cities objectAtIndex:row] objectForKey:@"areas"];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
            currentCity = [self.cities[row] objectForKey:@"city"];
            if (self.areas.count > 0) {
                currentArea = self.areas.firstObject;
            }else {
                currentArea = @"";
            }
            break;
        case 2:
            if (self.areas.count > 0) {
                currentArea = self.areas[row];
            }else {
                currentArea = @"";
            }
            break;
            
        default:
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

#pragma mark -- 设置默认显示
#pragma mark
- (void)configDataProvince:(NSString *)province cityName:(NSString *)cityName areaName:(NSString *)areaName {
    NSString *provinceStr = province;
    NSString *cityStr = cityName;
    NSString *districtStr = areaName;
    int oneColumn = 0, twoColumn = 0, threeColum = 0;
    // 省份
    for (int i=0; i<self.provinces.count; i++)
    {
        if ([provinceStr isEqualToString:[self.provinces[i] objectForKey:@"state"]]) {
            oneColumn = i;
        }
    }
    
    // 用来记录是某个省下的所有市
    NSArray *tempArray = [self.provinces[oneColumn] objectForKey:@"cities"];
    // 市
    for  (int j=0; j<[tempArray count]; j++)
    {
        if ([cityStr isEqualToString:[tempArray[j] objectForKey:@"city"]])
        {
            twoColumn = j;
            break;
        }
    }
    // 区
    for (int k=0; k<[[tempArray[twoColumn] objectForKey:@"areas"] count]; k++)
    {
        if ([districtStr isEqualToString:[tempArray[twoColumn] objectForKey:@"areas"][k]])
        {
            threeColum = k;
            break;
        }
    }
    
    [self pickerView:self.pickerView didSelectRow:oneColumn inComponent:0];
    [self pickerView:self.pickerView didSelectRow:twoColumn inComponent:1];
    [self pickerView:self.pickerView didSelectRow:threeColum inComponent:2];
}


#pragma mark -- UIGestureRecognizerDelegate
#pragma mark
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark -- Event Response
#pragma mark
- (void)confirmBtnClicked {
    [self dismiss];
    if (_block) {
        _block(currentProvice,currentCity,currentArea);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark -- Show And Dismiss Animations
#pragma mark
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.layer.opacity = 1.f;
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT - kContentViewHeight, SCREEN_WIDTH, kContentViewHeight);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.layer.opacity = 0.f;
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kContentViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- <#Your Mark#>
#pragma mark

#pragma mark -- Getter And Setter
#pragma mark
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kContentViewHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopViewHeight)];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kTopViewHeight, SCREEN_WIDTH, kContentViewHeight - kTopViewHeight)];
        _pickerView.backgroundColor = [UIColor clearColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.titleLabel.font = kFont;
        _cancelBtn.frame = CGRectMake(KPadding, 0, 50.f, kTopViewHeight);
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 50 - KPadding, 0, 50.f, kTopViewHeight);
        _confirmBtn.titleLabel.font = kFont;
        [_confirmBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}


- (NSArray *)provinces {
    if (!_provinces) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"addressData" ofType:@"plist"];
        _provinces = [NSArray arrayWithContentsOfFile:path];
    }
    return _provinces;
}

@end
