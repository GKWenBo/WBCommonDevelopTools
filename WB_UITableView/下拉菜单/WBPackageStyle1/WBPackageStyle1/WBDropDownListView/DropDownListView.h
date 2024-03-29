//
//  DropDownListView.h
//  DropDownListView
//
//  Created by WMB on 2016/12/20.
//  Copyright © 2016年 文波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseDelegate.h"

#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000

@interface DropDownListView : UIView <UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentExtendSection;     //当前展开的section ，默认－1时，表示都没有展开
    
    NSMutableArray *selectedsArray;//用于保存当前选中的section indexPath
}
@property (nonatomic, assign) id<DropDownChooseDelegate> dropDownDelegate;
@property (nonatomic, assign) id<DropDownChooseDataSource> dropDownDataSource;
@property (nonatomic, strong) UIView *mSuperView; /**< 必须设置 */
@property (nonatomic, strong) UIView *mTableBaseView;
@property (nonatomic, strong) UITableView *mTableView;

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate;
- (void)setTitle:(NSString *)title inSection:(NSInteger) section;

- (BOOL)isShow;
- (void)hideExtendedChooseView;
@end
