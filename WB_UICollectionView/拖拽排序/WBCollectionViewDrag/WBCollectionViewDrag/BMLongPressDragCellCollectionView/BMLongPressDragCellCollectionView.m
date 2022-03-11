//    MIT License
//
//    Copyright (c) 2019 https://liangdahong.com
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import "BMLongPressDragCellCollectionView.h"

typedef NS_ENUM(NSUInteger, BMLongPressDragCellCollectionViewScrollDirection) {
    BMLongPressDragCellCollectionViewScrollDirectionNone  = 0,
    BMLongPressDragCellCollectionViewScrollDirectionLeft  = 1,
    BMLongPressDragCellCollectionViewScrollDirectionRight = 2,
    BMLongPressDragCellCollectionViewScrollDirectionUp    = 3,
    BMLongPressDragCellCollectionViewScrollDirectionDown  = 4,
};

@interface BMLongPressDragCellCollectionView ()

/// 长按手势
@property (nonatomic, strong, nullable) UILongPressGestureRecognizer *longGesture;
/// 截图快照
@property (nonatomic, strong, nullable) UIView *snapedView;
/// 定时器
@property (nonatomic, strong, nullable) CADisplayLink *edgeTimer;
/// 旧的IndexPath
@property (nonatomic, strong, nullable) NSIndexPath *oldIndexPath;
/// 当前路径
@property (nonatomic, strong, nullable) NSIndexPath *currentIndexPath;

@property (nonatomic, assign) BOOL    isEndDrag; ///< 是否已经停止拖动
@property (nonatomic, assign) BOOL    banReload; ///< 禁止刷新
@property (nonatomic, assign) CGPoint oldPoint;  ///< 旧的位置
@property (nonatomic, assign) CGPoint lastPoint; ///< 最后的触摸点

@end

@implementation BMLongPressDragCellCollectionView

@dynamic delegate, dataSource;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initConfiguration];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initConfiguration];
    }
    return self;
}

- (void)dealloc {
    [self _stopEdgeTimer];
}

#pragma mark - getters setters

- (void)setCanDrag:(BOOL)canDrag {
    _canDrag = canDrag;
    self.longGesture.enabled = _canDrag;
}

- (void)setMinimumPressDuration:(NSTimeInterval)minimumPressDuration {
    _minimumPressDuration = minimumPressDuration;
    self.longGesture.minimumPressDuration = minimumPressDuration;
}

- (void)setDragZoomScale:(CGFloat)dragZoomScale {
    if (dragZoomScale < 0.1) {
        dragZoomScale = 1.2;
    }
    _dragZoomScale = dragZoomScale;
}

- (void)setDragSpeed:(CGFloat)dragSpeed {
    if (dragSpeed < 0.5) {
        dragSpeed = 8.0;
    }
    _dragSpeed = dragSpeed;
}

- (void)setDragSnapedViewBackgroundColor:(UIColor *)dragSnapedViewBackgroundColor {
    _dragSnapedViewBackgroundColor = dragSnapedViewBackgroundColor;
    _snapedView.backgroundColor = dragSnapedViewBackgroundColor;
}

- (UILongPressGestureRecognizer *)longGesture {
    if (!_longGesture) {
        _longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        _longGesture.minimumPressDuration = _minimumPressDuration;
    }
    return _longGesture;
}

// iOS 10 新特性 对UICollectionView做了优化，但是这里如果使用了会导致bug,重写此方法是为了让其无法修改
// https://developer.apple.com/documentation/uikit/uicollectionview/1771771-prefetchingenabled
// https://sxgfxm.github.io/blog/2016/10/18/uicollectionview-ios10-new-features
- (void)setPrefetchingEnabled:(BOOL)prefetchingEnabled {
    [super setPrefetchingEnabled:NO];
}

#pragma mark - 私有方法

- (void)initConfiguration {
    _canDrag              = YES;
    _minimumPressDuration = 0.5;
    _dragZoomScale = 1.2;
    _dragCellAlpha = 1.0;
    _dragSpeed     = 8.0;
    [self addGestureRecognizer:self.longGesture];
    // iOS 10 新特性 对 UICollectionView 做了优化，但是这里如果使用了会导致bug
    // https://developer.apple.com/documentation/uikit/uicollectionview/1771771-prefetchingenabled
    // https://sxgfxm.github.io/blog/2016/10/18/uicollectionview-ios10-new-features
    if (@available(iOS 10.0, *)) {
        self.prefetchingEnabled = NO;
    }
}

- (void)reloadData {
    if (_banReload) {
        return;
    }
    [super reloadData];
}

- (void)insertSections:(NSIndexSet *)sections {
    if (_banReload) {
        return;
    }
    [super insertSections:sections];
}

- (void)deleteSections:(NSIndexSet *)sections {
    if (_banReload) {
        return;
    }
    [super deleteSections:sections];
}

- (void)reloadSections:(NSIndexSet *)sections {
    if (_banReload) {
        return;
    }
    [super reloadSections:sections];
}

- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (_banReload) {
        return;
    }
    [super moveSection:section toSection:newSection];
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (_banReload) {
        return;
    }
    [super insertItemsAtIndexPaths:indexPaths];
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
   if (_banReload) {
       return;
   }
    [super deleteItemsAtIndexPaths:indexPaths];
}

- (void)reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (_banReload) {
        return;
    }
    [super reloadItemsAtIndexPaths:indexPaths];
}

- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if (_banReload) {
        return;
    }
    [super moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [super dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    // 处理复用时的问题，为了保证显示的正确性
    if (_isEndDrag) {
        cell.hidden = NO;
    } else {
        cell.hidden = (self.oldIndexPath
                       && self.oldIndexPath.item == indexPath.item
                       && self.oldIndexPath.section == indexPath.section);
    }
    return cell;
}

- (nullable NSIndexPath *)_getChangedNullIndexPath {
    __block NSIndexPath *index = nil;
    CGPoint point = [self.longGesture locationInView:self];
    NSInteger number = self.numberOfSections;
    while (number--) {
        NSInteger row = [self.dataSource collectionView:self numberOfItemsInSection:number];
        if (row == 0) {
            // 如果这组是空的
            CGRect headerFrame = [self layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:number]].frame;
            CGRect footerFrame = [self layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:number]].frame;
            CGRect frame = CGRectZero;
            if (((UICollectionViewFlowLayout *)self.collectionViewLayout).scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                // 水平方向
                frame = CGRectMake(CGRectGetMinX(headerFrame),
                                   CGRectGetMinY(headerFrame),
                                   CGRectGetMaxX(footerFrame) - CGRectGetMidX(headerFrame),
                                   CGRectGetWidth(footerFrame));
                
                if (frame.size.width < 10.0) {
                    // 如果这组的宽度小于 10.0，就设置一个默认值 10.0，主要是为了判断触摸点缩放在这组内。
                    frame.size.width  = 10.0;
                    frame.size.height = CGRectGetHeight(self.frame);
                    frame.origin.x    -= 5.0;
                }
            } else {
                // 垂直方向
                frame = CGRectMake(CGRectGetMinX(headerFrame),
                                   CGRectGetMinY(headerFrame),
                                   CGRectGetWidth(footerFrame),
                                   CGRectGetMaxY(footerFrame) - CGRectGetMidY(headerFrame));
                
                if (frame.size.height < 10.0) {
                    // 如果这组的高度小于 10.0，就设置一个默认值 10.0，主要是为了判断触摸点缩放在这组内。
                    frame.size.height = 10.0;
                    frame.size.width  = CGRectGetWidth(self.frame);
                    frame.origin.y    -= 5.0;
                }
            }
            
            if (CGRectContainsPoint(frame, point)) {
                // 触摸点在空的组内
                return [NSIndexPath indexPathForItem:0 inSection:number];
            }
        }
    }
    return index;
}

- (nullable NSIndexPath *)_getChangedIndexPath {
    __block NSIndexPath *index = nil;
    CGPoint point = [self.longGesture locationInView:self];
    // 遍历拖拽的 Cell 的中心点在哪一个 Cell 里
    [[self visibleCells] enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            index = [self indexPathForCell:obj];
            *stop = YES;
        }
    }];
    // 找到而且不是当前的 Cell 就返回此 index
    if (index) {
        if ((index.section == self.oldIndexPath.section) && (index.item == self.oldIndexPath.item)) {
            return nil;
        }
        return index;
    }
    
    // 获取最应该交换的 Cell
    __block CGFloat width = MAXFLOAT;
    __weak typeof(self) weakSelf = self;
    [[self visibleCells] enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            index = [self indexPathForCell:obj];
            *stop = YES;
        }
        __strong typeof(weakSelf) self = weakSelf;
        CGPoint p1 = self.snapedView.center;
        CGPoint p2 = obj.center;
        // 计算距离
        CGFloat distance = sqrt(pow((p1.x - p2.x), 2) + pow((p1.y - p2.y), 2));
        if (distance < width) {
            width = distance;
            index = [self indexPathForCell:obj];
        }
    }];
    if (!index) {
        return nil;
    }
    if ((index.section == self.oldIndexPath.section) && (index.item == self.oldIndexPath.item)) {
        // 最近的就是隐藏的 Cell 时, return nil
        return nil;
    }
    return index;
}

// 处理临界点问题
- (BMLongPressDragCellCollectionViewScrollDirection)_setScrollDirection {
    if (((self.bounds.size.height + self.contentOffset.y - _snapedView.center.y) < (_snapedView.bounds.size.height / 2))
        && ((self.bounds.size.height + self.contentOffset.y) < self.contentSize.height)) {
        return BMLongPressDragCellCollectionViewScrollDirectionDown;
        
    } else if (((_snapedView.center.y - self.contentOffset.y) < (_snapedView.bounds.size.height / 2))
               && self.contentOffset.y > 0) {
        return BMLongPressDragCellCollectionViewScrollDirectionUp;
        
    } else if (((self.bounds.size.width + self.contentOffset.x) - (_snapedView.center.x)) < (_snapedView.bounds.size.width / 2)
               && (self.bounds.size.width + self.contentOffset.x) < self.contentSize.width) {
        return BMLongPressDragCellCollectionViewScrollDirectionRight;
        
    } else if (((_snapedView.center.x - self.contentOffset.x) < (_snapedView.bounds.size.width) / 2)
               && self.contentOffset.x > 0) {
        return BMLongPressDragCellCollectionViewScrollDirectionLeft;
    }
    
    return BMLongPressDragCellCollectionViewScrollDirectionNone;
}

// 处理 UICollectionView 数据源
- (void)_updateSourceData {
    // 获取数据源
    NSMutableArray *array = [self.dataSource dataSourceWithDragCellCollectionView:self].mutableCopy;
    // 处理数据
    BOOL dataTypeCheck = ([self numberOfSections] != 1 || ([self  numberOfSections] == 1 && [array[0] isKindOfClass:NSArray.class]));
    if (dataTypeCheck) {
        for (int i = 0; i < array.count; i ++) {
            // 如果是嵌套数组 就把数组里面的数组换为 NSMutableArray。
            [array replaceObjectAtIndex:i withObject:[array[i] mutableCopy]];
        }
    }
    if (_currentIndexPath.section == _oldIndexPath.section) {

        NSMutableArray *orignalSection = dataTypeCheck ? array[_oldIndexPath.section] : array;
        
        if (_currentIndexPath.item > _oldIndexPath.item) {
            for (NSUInteger i = _oldIndexPath.item; i < _currentIndexPath.item ; i ++) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
            
        } else {
            for (NSUInteger i = _oldIndexPath.item; i > _currentIndexPath.item ; i --) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
        
    } else {
        NSMutableArray *orignalSection = array[_oldIndexPath.section];
        NSMutableArray *currentSection = array[_currentIndexPath.section];
        [currentSection insertObject:orignalSection[_oldIndexPath.item] atIndex:_currentIndexPath.item];
        // https://github.com/liangdahong/BMLongPressDragCellCollectionView/issues/16
        // 这里之前删除指定对象会有问题，如果数据源中的对象为 [字符串 而且是一样的时候, 因为 OC 中对字符串的内存做了特殊处理 ]，会把相同的字符串全部删除导致崩溃
        // [orignalSection removeObject:orignalSection[_oldIndexPath.item]];
        [orignalSection removeObjectAtIndex:_oldIndexPath.item];
    }
    // ==========处理数据
    // 更新外面的数据源
    // 这里会触发外面的使用者修改数据源，但外面的使用者可以会在此调用 reloadData 相关方法，所以做了拦截操作
    // https://github.com/liangdahong/BMLongPressDragCellCollectionView/issues/14
    self.banReload = YES;
    [self.delegate dragCellCollectionView:self newDataArrayAfterMove:array];
    self.banReload = NO;
}

- (void)_setEdgeTimer{
    if (!_edgeTimer) {
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_edgeScroll)];
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)_stopEdgeTimer{
    if (_edgeTimer) {
        [_edgeTimer invalidate];
        _edgeTimer = nil;
    }
}

- (void)_edgeScroll {
    BMLongPressDragCellCollectionViewScrollDirection scrollDirection = [self _setScrollDirection];

    if (BMLongPressDragCellCollectionViewScrollDirectionNone == scrollDirection) {
        return;
    }

    switch (scrollDirection) {
        case BMLongPressDragCellCollectionViewScrollDirectionLeft:{
            // 这里的动画必须设为 NO
            [self setContentOffset:CGPointMake(self.contentOffset.x - _dragSpeed, self.contentOffset.y) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x - _dragSpeed, _snapedView.center.y);
            _lastPoint.x -= _dragSpeed;
        }
            break;
        case BMLongPressDragCellCollectionViewScrollDirectionRight:{
            [self setContentOffset:CGPointMake(self.contentOffset.x + _dragSpeed, self.contentOffset.y) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x + _dragSpeed, _snapedView.center.y);
            _lastPoint.x += _dragSpeed;
        }
            break;
        case BMLongPressDragCellCollectionViewScrollDirectionUp:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - _dragSpeed) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x, _snapedView.center.y - _dragSpeed);
            _lastPoint.y -= _dragSpeed;
        }
            break;
        case BMLongPressDragCellCollectionViewScrollDirectionDown:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + _dragSpeed) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x, _snapedView.center.y + _dragSpeed);
            _lastPoint.y += _dragSpeed;
        }
            break;
        default:
            break;
    }

    // 如果Cell 拖拽到了边沿时
    // 截图视图位置移动
    [UIView animateWithDuration:0.1 animations:^{
        self.snapedView.center = self.lastPoint;
    }];
    
    // 获取应该交换的 Cell 的位置
    NSIndexPath *index1 = [self _getChangedNullIndexPath];
    NSIndexPath *index = nil;

    index = index1 ? : [self _getChangedIndexPath];

    if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionView:changedDragAtPoint:)]) {
        [self.delegate dragCellCollectionView:self changedDragAtPoint:_lastPoint];
    }
    
    if (!index) {
        return;
    }
    
    // 是否可以交换
    if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldBeginExchange:sourceIndexPath:toIndexPath:)]) {
        if (![self.delegate dragCellCollectionViewShouldBeginExchange:self sourceIndexPath:_oldIndexPath toIndexPath:index]) {
            return;
        }
    }
    _currentIndexPath = index;

    UICollectionViewCell *cell1 = [self cellForItemAtIndexPath:_currentIndexPath];

    NSIndexPath *sourceIndexPath = _oldIndexPath;
    NSIndexPath *toIndexPath = _currentIndexPath;
    if (!index1) {
        self.oldPoint = cell1.center;
        // 更新数据源
        [self _updateSourceData];
        // 移动 cell
        [self moveItemAtIndexPath:_oldIndexPath toIndexPath:_currentIndexPath];
        // 设置移动后的起始 indexPath
        _oldIndexPath = _currentIndexPath;
        // 为了防止在缓存池取出的 Cell 已隐藏,
        // 以后可以优化
        [self reloadItemsAtIndexPaths:@[_oldIndexPath]];
        
    } else {
        // 更新数据源
        [self _updateSourceData];
        // 移动 cell
        [self moveItemAtIndexPath:_oldIndexPath toIndexPath:_currentIndexPath];
        self.oldPoint = [self cellForItemAtIndexPath:_currentIndexPath].center;
        // 设置移动后的起始 indexPath
        _oldIndexPath = _currentIndexPath;
        [self reloadItemsAtIndexPaths:@[_oldIndexPath]];
    }

    // 交换结束时
    if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldEndExchange:sourceIndexPath:toIndexPath:)]) {
        [self.delegate dragCellCollectionViewShouldEndExchange:self sourceIndexPath:sourceIndexPath toIndexPath:toIndexPath];
    }
}

#pragma mark - 事件响应

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    CGPoint point = [longGesture locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan: {
            // 手势开始
            self.userInteractionEnabled = NO;
            _oldIndexPath = indexPath;
            // 判断手势落点位置是否在 Cell 上, 没有按在 cell 上就 break
            if (_oldIndexPath == nil) {
                self.longGesture.enabled = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.canDrag) {
                        self.longGesture.enabled = YES;
                    }
                });
                break;
            }
            
            // 将要开始拖拽时，询问此位置的Cell是否可以拖拽
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldBeginMove:indexPath:)]) {
                if (![self.delegate dragCellCollectionViewShouldBeginMove:self indexPath:_oldIndexPath]) {
                    _oldIndexPath = nil;
                    self.longGesture.enabled = NO;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (self.canDrag) {
                            self.longGesture.enabled = YES;
                        }
                    });
                    break;
                }
            }
            self.isEndDrag = NO;
            // 取出正在长按的cell
            UICollectionViewCell *cell = [self cellForItemAtIndexPath:_oldIndexPath];
            self.oldPoint = cell.center;
            // 先置 nil
            if (_snapedView) {
                _snapedView = nil;
            }
            // 是否外部提供拖拽View
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionView: startDragAtIndexPath:)]) {
                _snapedView = [self.delegate dragCellCollectionView:self startDragAtIndexPath:indexPath];
            }
            if (!_snapedView) {
                // 使用系统截图功能，得到 cell 的快照 view
                _snapedView = [cell snapshotViewAfterScreenUpdates:NO];
            }
            
            // 修改颜色
            if (_dragSnapedViewBackgroundColor) {
                _snapedView.backgroundColor = _dragSnapedViewBackgroundColor;
            }
            
            // 让外面做一些特殊处理
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionView: dragView:indexPath:)]) {
                [self.delegate dragCellCollectionView:self dragView:_snapedView indexPath:indexPath];
            }
            
            // 设置frame
            _snapedView.frame = cell.frame;
            // 添加到 collectionView 不然无法显示
            [self addSubview:_snapedView];
            // 截图后隐藏当前 cell
            cell.hidden = YES;
            
            // 获取当前触摸的中心点
            CGPoint currentPoint = point;
            
            // 动画放大和移动到触摸点下面
            [UIView animateWithDuration:0.25 animations:^{
                self.snapedView.transform = CGAffineTransformMakeScale(self.dragZoomScale, self.dragZoomScale);
                self.snapedView.center = CGPointMake(currentPoint.x, currentPoint.y);
                self.snapedView.alpha = self.dragCellAlpha;
            }];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            // 开启 collectionView 的边缘自动滚动检测
            // https://github.com/liangdahong/BMLongPressDragCellCollectionView/issues/15
            if (!_edgeTimer) {
                [self _setEdgeTimer];
            }

            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionView:changedDragAtPoint:)]) {
                [self.delegate dragCellCollectionView:self changedDragAtPoint:point];
            }
            // 当前手指位置
            _lastPoint = point;
            // 截图视图位置移动
            [UIView animateWithDuration:0.1 animations:^{
                self.snapedView.center = self.lastPoint;
            }];
            
            NSIndexPath *index1 = [self _getChangedNullIndexPath];
            NSIndexPath *index = nil;
            
            if (index1) {
                index = index1;
            } else {
                index = [self _getChangedIndexPath];
            }
            
            // 没有取到 || 距离隐藏的 Cell 最近时就返回
            if (!index) {
                break;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldBeginExchange:sourceIndexPath:toIndexPath:)]) {
                if (![self.delegate dragCellCollectionViewShouldBeginExchange:self sourceIndexPath:_oldIndexPath toIndexPath:index]) {
                    break;
                }
            }
            
            _currentIndexPath = index;
            UICollectionViewCell *cell1 = [self cellForItemAtIndexPath:_currentIndexPath];

            NSIndexPath *sourceIndexPath = _oldIndexPath;
            NSIndexPath *toIndexPath = _currentIndexPath;
            if (!index1) {
                self.oldPoint = cell1.center;
                // 更新数据源
                [self _updateSourceData];
                // 移动 cell
                [self moveItemAtIndexPath:_oldIndexPath toIndexPath:_currentIndexPath];
                // 设置移动后的起始 indexPath
                _oldIndexPath = _currentIndexPath;
                [self reloadItemsAtIndexPaths:@[_oldIndexPath]];
                
            } else {
                // 更新数据源
                [self _updateSourceData];
                // 移动 cell
                [self moveItemAtIndexPath:_oldIndexPath toIndexPath:_currentIndexPath];
                self.oldPoint = [self cellForItemAtIndexPath:_currentIndexPath].center;
                // 设置移动后的起始 indexPath
                _oldIndexPath = _currentIndexPath;
                [self reloadItemsAtIndexPaths:@[_oldIndexPath]];
            }

            // 交换结束时
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldEndExchange:sourceIndexPath:toIndexPath:)]) {
                [self.delegate dragCellCollectionViewShouldEndExchange:self sourceIndexPath:sourceIndexPath toIndexPath:toIndexPath];
            }

            break;
        }
            break;
            
        default: {
            self.userInteractionEnabled = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionView:endedDragAtPoint:)]) {
                [self.delegate dragCellCollectionView:self endedDragAtPoint:point];
            }

            if (longGesture.isEnabled) {
                
                if (!self.oldIndexPath) {
                    return;
                }
                UICollectionViewCell *cell = [self cellForItemAtIndexPath:_oldIndexPath];
                // 结束动画过程中停止交互，防止出问题
                self.userInteractionEnabled = NO;
                // 结束拖拽了
                self.isEndDrag = YES;
                // 给截图视图一个动画移动到隐藏 cell 的新位置
                [UIView animateWithDuration:0.25 animations:^{
                    if (!cell) {
                        self.snapedView.center = self.oldPoint;
                    } else {
                        self.snapedView.center = cell.center;
                    }
                    self.snapedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                    self.snapedView.alpha = 1.0;
                } completion:^(BOOL finished) {
                    // 移除截图视图、显示隐藏的 cell 并开启交互
                    [self.snapedView removeFromSuperview];
                    self.snapedView = nil;
                    cell.hidden = NO;
                    self.userInteractionEnabled = YES;
                }];
            }
            // 关闭定时器
            self.oldIndexPath = nil;
            [self _stopEdgeTimer];
        }
            break;
    }
}

- (void)dragMoveItemToIndexPath:(NSIndexPath *)newIndexPath {
    if (self.isEndDrag) {
        return;
    }
    self.isEndDrag = YES;
    self.longGesture.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.canDrag) {
            self.longGesture.enabled = YES;
        }
    });
    
    if (_oldIndexPath) {
        _currentIndexPath = newIndexPath;
        // 更新数据源
        [self _updateSourceData];
        // 移动 cell
        [self moveItemAtIndexPath:_oldIndexPath toIndexPath:_currentIndexPath];
        // 设置移动后的起始 indexPath
        _oldIndexPath = newIndexPath;
        [self reloadItemsAtIndexPaths:@[newIndexPath]];
        
        UICollectionViewCell *cell = [self cellForItemAtIndexPath:_oldIndexPath];
        cell.hidden = YES;
        
        // 结束动画过程中停止交互，防止出问题
        self.userInteractionEnabled = NO;
        // 结束拖拽了
        self.isEndDrag = YES;
        // 给截图视图一个动画移动到隐藏 cell 的新位置
        [UIView animateWithDuration:0.25 animations:^{
            if (!cell) {
                self.snapedView.center = self.oldPoint;
            } else {
                self.snapedView.center = cell.center;
            }
            self.snapedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            self.snapedView.alpha = 1.0;
        } completion:^(BOOL finished) {
            // 移除截图视图、显示隐藏的 cell 并开启交互
            [self.snapedView removeFromSuperview];
            cell.hidden = NO;
            self.userInteractionEnabled = YES;
        }];
    }

    // 关闭定时器
    _oldIndexPath = nil;
    [self _stopEdgeTimer];
}

@end
