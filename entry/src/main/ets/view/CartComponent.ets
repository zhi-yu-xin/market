/*
 * 购物车组件 - Member D
 * 简单地包装CartPage
 */

import { CartPage } from '../pages/CartPage';

@Component
export struct CartComponent {
  build() {
    Column() {
      // 这里需要导入CartPage组件
      // 由于CartPage是@Entry组件，可能需要特殊处理
      // 我们先使用简单的占位，然后根据实际调整
      CartPage()
    }
    .width('100%')
    .height('100%')
  }
}
