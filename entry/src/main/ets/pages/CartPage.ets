/*
 * 购物车页面 - Member D
 * 仅实现：列表渲染、数量增减、全选/反选、实时总价计算
 */

import { CartStore } from '../common/CartStore';
import { LAYOUT_WIDTH_OR_HEIGHT } from '../common/CommonConstants';
import { CartItem } from '../common/CartStore';

@Entry
@Component
export struct CartPage {
  @StorageLink('cartItems') cartItems: CartItem[] = [];

  // 获取选中商品总价
  private getTotalPrice(): number {
    return this.cartItems
      .filter(item => item.selected)
      .reduce((total, item) => total + (item.price * item.count), 0);
  }

  // 获取选中商品数量
  private getSelectedCount(): number {
    return this.cartItems
      .filter(item => item.selected)
      .reduce((total, item) => total + item.count, 0);
  }

  build() {
    Column({ space: 0 }) {
      // 标题
      Text('购物车')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)
        .backgroundColor('#FFFFFF')

      // 购物车内容
      if (this.cartItems.length === 0) {
        // 空购物车
        Column() {
          Text('🛒')  // 使用Emoji，不需要图片
            .fontSize(60)
            .margin({ bottom: 16 })

          Text('购物车是空的')
            .fontSize(18)
            .fontColor('#999999')
        }
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        // 购物车有商品
        Column() {
          // 全选行
          Row({ space: 8 }) {
            Checkbox({ name: 'selectAll', group: 'cart' })
              .select(this.cartItems.every(item => item.selected))
              .onChange((checked: boolean) => {
                CartStore.toggleSelectAll();
              })

            Text('全选')
              .fontSize(16)
          }
          .padding(16)
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // 商品列表
          List({ space: 8 }) {
            ForEach(this.cartItems, (item: CartItem) => {
              ListItem() {
                this.CartItemCard(item)
              }
            }, (item: CartItem) => item.id.toString())
          }
          .width('100%')
          .layoutWeight(1)
          .padding({ left: 16, right: 16 })

          // 底部总价栏
          this.BottomTotalBar()
        }
        .height('100%')
      }
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
    .backgroundColor('#F5F5F5')
  }

  @Builder
  CartItemCard(item: CartItem) {
    Row({ space: 12 }) {
      // 选择框
      Checkbox({ name: 'item' + item.id, group: 'cart' })
        .select(item.selected)
        .onChange((checked: boolean) => {
          CartStore.toggleItemSelection(item.id);
        })

      // 商品图片（使用Member B提供的图片）
      Image(item.image)
        .width(80)
        .height(80)
        .borderRadius(8)

      // 商品信息
      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(16)
          .maxLines(2)
          .width('100%')

        Text('¥' + item.price.toFixed(2))
          .fontSize(18)
          .fontColor('#FF5000')
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })

        // 数量控制
        Row({ space: 12 }) {
          Button('-')
            .width(30)
            .height(30)
            .fontSize(16)
            .onClick(() => {
              CartStore.updateItemCount(item.id, item.count - 1);
            })

          Text(item.count.toString())
            .fontSize(16)
            .width(40)
            .textAlign(TextAlign.Center)

          Button('+')
            .width(30)
            .height(30)
            .fontSize(16)
            .onClick(() => {
              CartStore.updateItemCount(item.id, item.count + 1);
            })
        }
        .margin({ top: 8 })
      }
      .layoutWeight(1)

      // 删除按钮（文字按钮，不需要图片）
      Button('删除')
        .fontSize(12)
        .fontColor('#FF0000')
        .backgroundColor('#FFE5E5')
        .padding(8)
        .onClick(() => {
          CartStore.removeFromCart(item.id);
        })
    }
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .width('100%')
  }

  @Builder
  BottomTotalBar() {
    Row({ space: 16 }) {
      Column({ space: 4 }) {
        Text('合计:')
          .fontSize(14)
          .fontColor('#666666')

        Text('¥' + this.getTotalPrice().toFixed(2))
          .fontSize(20)
          .fontColor('#FF5000')
          .fontWeight(FontWeight.Bold)
      }
      .layoutWeight(1)

      Text('已选 ' + this.getSelectedCount() + ' 件')
        .fontSize(14)
        .fontColor('#333333')
    }
    .padding(16)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .border({ width: { top: 1 }, color: '#EEEEEE' })
  }
}
