import { GoodsListComponent } from './GoodsListComponent'; // 必须使用花括号导入

@Component
export struct HomeComponent {
  build() {
    Column() {
      Swiper() {
        // 使用正确的资源引用方式
        Image($r('app.media.goodsImg')).width('100%').height(150)
        Image($r('app.media.goodsImg_2')).width('100%').height(150)
      }
      .autoPlay(true)
      .height(150)
      .width('94%')
      .margin({bottom: 10, top: 10})
      .borderRadius(10)

      // 使用正确的组件名称
      GoodsListComponent()
    }
    .width('100%')
    .height('100%')
  }
}