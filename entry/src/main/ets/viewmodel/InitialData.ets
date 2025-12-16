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

//
export class GoodsListItemType {
  id: number; // 新增：用于购物车和详情页索引
  goodsImg: Resource;
  goodsName: Resource;
  advertisingLanguage: Resource;
  evaluate: Resource;
  price: number; // 修改：建议改为number类型方便计算总价，展示时再转string
  priceStr: Resource; // 保留原有的Resource用于展示
  category: number; // 新增：例如 0=精选, 1=手机, 2=服饰... 用于Member C筛选

  constructor(id: number, goodsImg: Resource, goodsName: Resource, price: number, priceStr: Resource, category: number) {
    this.id = id;
    this.goodsImg = goodsImg;
    this.goodsName = goodsName;
    this.advertisingLanguage = $r('app.string.advertising_language');
    this.evaluate = $r('app.string.evaluate');
    this.price = price;
    this.priceStr = priceStr;
    this.category = category;
  }
}

// Member B (列表/瀑布流)： 这些数据里的 id 都是唯一的，你在做详情页跳转时，可以拿这个 id 来判断点的是哪个商品。
// Member C (搜索)： 我混合了 category (0-4)，你可以测试点击左侧分类栏时，右侧是否只显示对应分类的商品。
// Member D (购物车)： 计算总价时请使用 price 字段（数字类型），展示时用 priceStr。
export const goodsInitialList: GoodsListItemType[] = [
  // --- Category 0: 精选 / Featured ---
  new GoodsListItemType(1, $r('app.media.goodsImg'), $r('app.string.goodsName'), 199, $r('app.string.price_199'), 0),
  new GoodsListItemType(2, $r('app.media.goodsImg_2'), $r('app.string.another_goodsName'), 265, $r('app.string.price_265'), 0),

  // --- Category 1: 手机 / Phone ---
  new GoodsListItemType(3, $r('app.media.goodsImg_3'), $r('app.string.goodsName'), 999, $r('app.string.price_999'), 1),
  new GoodsListItemType(4, $r('app.media.goodsImg_4'), $r('app.string.another_goodsName'), 810, $r('app.string.price_810'), 1),
  new GoodsListItemType(5, $r('app.media.goodsImg'), $r('app.string.goodsName'), 999, $r('app.string.price_999'), 1),

  // --- Category 2: 服饰 / Clothes ---
  new GoodsListItemType(6, $r('app.media.goodsImg_2'), $r('app.string.another_goodsName'), 199, $r('app.string.price_199'), 2),
  new GoodsListItemType(7, $r('app.media.goodsImg_3'), $r('app.string.goodsName'), 265, $r('app.string.price_265'), 2),
  new GoodsListItemType(8, $r('app.media.goodsImg_4'), $r('app.string.another_goodsName'), 199, $r('app.string.price_199'), 2),

  // --- Category 3: 穿搭 / Wear ---
  new GoodsListItemType(9, $r('app.media.goodsImg'), $r('app.string.goodsName'), 810, $r('app.string.price_810'), 3),
  new GoodsListItemType(10, $r('app.media.goodsImg_2'), $r('app.string.another_goodsName'), 265, $r('app.string.price_265'), 3),
  new GoodsListItemType(11, $r('app.media.goodsImg_3'), $r('app.string.goodsName'), 199, $r('app.string.price_199'), 3),

  // --- Category 4: 家居 / Home ---
  new GoodsListItemType(12, $r('app.media.goodsImg_4'), $r('app.string.another_goodsName'), 999, $r('app.string.price_999'), 4),
  new GoodsListItemType(13, $r('app.media.goodsImg'), $r('app.string.goodsName'), 810, $r('app.string.price_810'), 4),
  new GoodsListItemType(14, $r('app.media.goodsImg_2'), $r('app.string.another_goodsName'), 199, $r('app.string.price_199'), 4),
  new GoodsListItemType(15, $r('app.media.goodsImg_3'), $r('app.string.goodsName'), 265, $r('app.string.price_265'), 4),
  new GoodsListItemType(16, $r('app.media.goodsImg_4'), $r('app.string.another_goodsName'), 810, $r('app.string.price_810'), 4)
]