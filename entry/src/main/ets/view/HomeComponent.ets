import GoodsList from './GoodsListComponent';

@Component
export struct HomeComponent {
  build() {
    Column() {
      // 1. 顶部轮播图 (Member A 负责的装修)
      Swiper() {
        Image($r('app.media.goodsImg')).width('100%').height(150)
        Image($r('app.media.goodsImg_2')).width('100%').height(150)
      }
      .autoPlay(true)
      .height(150)
      .width('94%')
      .margin({bottom: 10, top: 10})
      .borderRadius(10)

      // 2. 商品列表 ( Member B 负责的组件)
      GoodsList()
    }
    .width('100%')
    .height('100%')
  }
}