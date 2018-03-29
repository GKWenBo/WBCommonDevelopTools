//
//  WB_LogisticsInfomationCell.m
//  WB_LogisticsInfomationDemo
//
//  Created by Admin on 2017/7/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WBLogisticsInfomationCell.h"
#import "WBLogisticsInfomationConfig.h"
@implementation WBLogisticsInfomationCell
#pragma mark -- cell初始化
#pragma mark
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI
#pragma mark
- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.logisticsView.currented = NO;
    self.logisticsView.hasDownLine = YES;
    self.logisticsView.hasUpLine = YES;
    [self.contentView addSubview:self.logisticsView];
    
    [self.logisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark -- 赋值
#pragma mark
- (void)configData:(WBLogisticsInfomationModel *)model {
    [self.logisticsView reloadDataWithModel:model];
}

#pragma mark -- Layout
#pragma mark
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark -- Getter And Setter
#pragma mark
- (WBLogisticsInfomationContentView *)logisticsView {
    if (!_logisticsView) {
        _logisticsView = [WBLogisticsInfomationContentView new];
    }
    return _logisticsView;
}

- (void)setHasUpLine:(BOOL)hasUpLine {
    self.logisticsView.hasUpLine = hasUpLine;
}

- (void)setHasDownLine:(BOOL)hasDownLine {
    self.logisticsView.hasDownLine = hasDownLine;
}

- (void)setCurrented:(BOOL)currented {
    self.logisticsView.currented = currented;
}
@end
