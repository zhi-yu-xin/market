/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { LAYOUT_WIDTH_OR_HEIGHT } from '../common/CommonConstants';
import { CartComponent } from './CartComponent';
import { CategoryComponent } from './CategoryComponent';
import { HomeComponent } from './HomeComponent';
import { MineComponent } from './MineComponent';

@Component
export default struct TabBar {
  @State currentIndex: number = 0;
  @StorageLink('cartTotalCount') cartCount: number = 0;  // Member D: 购物车角标数量
  private controller: TabsController = new TabsController();

  // Member A实现的TabBuilder - 用于首页、分类、我的
  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 24, height: 24 })
        .objectFit(ImageFit.Contain)
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#ffe3e92f' : '#6B6B6B')
        .fontSize(10)
        .margin({ top: 4 })
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.controller.changeIndex(this.currentIndex);
    })
  }

  // Member D: 专门为购物车Tab添加角标的Builder
  @Builder CartTabBuilder() {
    Column() {
      // 使用Stack包裹图标以实现角标效果
      Stack({ alignContent: Alignment.TopEnd }) {
        // Member A提供的图标（暂时用icon，实际应该用购物车图标）
        Image(this.currentIndex === 2 ? $r('app.media.icon_cart_selected') : $r('app.media.icon_cart_normal'))
          .size({ width: 24, height: 24 })
          .objectFit(ImageFit.Contain)

        // Member D: 购物车角标
        if (this.cartCount > 0) {
          Text(this.cartCount > 99 ? '99+' : this.cartCount.toString())
            .fontSize(10)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF3B30')
            .padding({ left: 4, right: 4, top: 1, bottom: 1 })
            .borderRadius(8)
            .position({ x: '70%', y: '-20%' })
        }
      }
      .width(30)
      .height(30)

      Text('购物车')  // 确保这里是"购物车"，不是"我的"
        .fontColor(this.currentIndex === 2 ? '#ffe3e92f' : '#6B6B6B')
        .fontSize(10)
        .margin({ top: 4 })
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = 2;  // 购物车是索引2
      this.controller.changeIndex(this.currentIndex);
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        // Tab 1: 首页 - 索引0
        TabContent() {
          HomeComponent()
        }
        .tabBar(this.TabBuilder('精选', 0, $r('app.media.icon'), $r('app.media.icon')))

        // Tab 2: 分类 - 索引1
        TabContent() {
          CategoryComponent()
        }
        .tabBar(this.TabBuilder('分类', 1, $r('app.media.icon'), $r('app.media.icon')))

        // Tab 3: 购物车 - 索引2
        TabContent() {
          CartComponent()
        }
        .tabBar(this.CartTabBuilder())  // 使用购物车专用Builder

        // Tab 4: 我的 - 索引3
        TabContent() {
          MineComponent()
        }
        .tabBar(this.TabBuilder('我的', 3, $r('app.media.icon'), $r('app.media.icon')))
      }
      .vertical(false)
      .scrollable(false)
      .barHeight(56)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .width(LAYOUT_WIDTH_OR_HEIGHT)
      .height(LAYOUT_WIDTH_OR_HEIGHT)
    }
    .width(LAYOUT_WIDTH_OR_HEIGHT)
    .height(LAYOUT_WIDTH_OR_HEIGHT)
  }
}
