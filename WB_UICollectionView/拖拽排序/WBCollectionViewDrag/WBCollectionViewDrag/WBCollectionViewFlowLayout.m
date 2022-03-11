//
//  WBCollectionViewFlowLayout.m
//  WBCollectionViewDrag
//
//  Created by wenbo on 2022/2/28.
//

#import "WBCollectionViewFlowLayout.h"
#import "WBDecorationView.h"

@interface WBCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *>*decorationViewAttributes;

@end

@implementation WBCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _roundLeftPadding = 6.f;
        _roundBottomPadding = 12.f;
        [self registerClass:[WBDecorationView class] forDecorationViewOfKind:@"WBDecorationView"];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
        
    NSInteger sectionCount = [self.collectionView numberOfSections];
    if (sectionCount == 0) {
        return;
    }
    
    [self.decorationViewAttributes removeAllObjects];
    
    for (int section = 0; section < sectionCount; section ++) {
        /// 最多存储两组装饰视图
        if (section > 1) {
            break;
        }
        
        NSInteger numOfItem = [self.collectionView numberOfItemsInSection:section];
        
        /// first
        CGRect firstFrame = CGRectNull;
        UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        if (headerAttr && (headerAttr.frame.size.width != 0 || headerAttr.frame.size.height != 0)) {
            firstFrame = headerAttr.frame;
        }
        
        /// last
        CGRect lastFrame = CGRectNull;
        UICollectionViewLayoutAttributes *lastAttr = nil;
        if (section == 0) {
            /// 第0组
            if (numOfItem > 0) {
                lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:numOfItem - 1 inSection:section]];
            }
            /// 有footer且size不为null
            UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            if (footerAttr && (footerAttr.frame.size.width != 0 || footerAttr.frame.size.height != 0)) {
                lastAttr = footerAttr;
            }
        } else {
            /// 除开第0组，后面组数合并共用一个装饰视图
            NSInteger lastSection = sectionCount - 1;
            numOfItem = [self.collectionView numberOfItemsInSection:lastSection];
            if (numOfItem > 0) {
                lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:numOfItem - 1 inSection:sectionCount - 1]];
            }
            /// 有footer且size不为null
            UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:lastSection]];
            if (footerAttr && (footerAttr.frame.size.width != 0 || footerAttr.frame.size.height != 0)) {
                lastAttr = footerAttr;
            }
        }
        if (lastAttr && (lastAttr.frame.size.width != 0 || lastAttr.frame.size.height != 0)) {
            lastFrame = lastAttr.frame;
        }
        
        /// sectionFrame
        CGRect sectionFrame = CGRectNull;
        if (!CGRectIsNull(firstFrame) && !CGRectIsNull(lastFrame)) {
            sectionFrame = CGRectUnion(firstFrame, lastFrame);
        } else if (!CGRectIsNull(firstFrame)) {
            sectionFrame = CGRectUnion(firstFrame, firstFrame);
        } else if (!CGRectIsNull(lastFrame)) {
            sectionFrame = CGRectUnion(lastFrame, lastFrame);
        }
        
        if (CGRectIsNull(sectionFrame)) {
            continue;
        }
        
        sectionFrame.origin.y = sectionFrame.origin.y;
        sectionFrame.origin.x = sectionFrame.origin.x + _roundLeftPadding;
        sectionFrame.size.height = sectionFrame.size.height + _roundBottomPadding;
        sectionFrame.size.width = self.collectionView.frame.size.width - 2 * _roundLeftPadding;
        
        /// 定义装饰视图
        UICollectionViewLayoutAttributes *decorationAttrs = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:NSStringFromClass([WBDecorationView class]) withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        decorationAttrs.frame = sectionFrame;
        decorationAttrs.zIndex = -1;
        [self.decorationViewAttributes addObject:decorationAttrs];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttributes) {
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }
    return attrs;
}

// MARK: - getter
- (NSMutableArray *)decorationViewAttributes {
    if (!_decorationViewAttributes) {
        _decorationViewAttributes = @[].mutableCopy;
    }
    return _decorationViewAttributes;
}

@end
