/*
 * 购物车全局状态管理 - Member D
 */
import { GoodsListItemType } from '../viewmodel/InitialData';

// 购物车商品项
export class CartItem {
  id: number;
  name: Resource;
  image: Resource;
  price: number;
  count: number;
  selected: boolean;

  constructor(id: number, name: Resource, image: Resource, price: number) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.price = price;
    this.count = 1;
    this.selected = true;
  }
}

// 初始化购物车数据
AppStorage.setOrCreate<CartItem[]>('cartItems', []);
AppStorage.setOrCreate<number>('cartTotalCount', 0);



export class CartStore {
  // 添加商品到购物车
  static addToCart(goods: GoodsListItemType): void {
    const items: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];
    const existingItem = items.find(item => item.id === goods.id);

    if (existingItem) {
      existingItem.count += 1;
    } else {
      const cartItem = new CartItem(
        goods.id,
        goods.goodsName,
        goods.goodsImg,
        goods.price
      );
      items.push(cartItem);
    }

    AppStorage.set<CartItem[]>('cartItems', [...items]);
    CartStore.updateCartCount();
  }

  // 更新商品数量
  static updateItemCount(id: number, count: number): void {
    const items: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];
    const item = items.find(item => item.id === id);

    if (item) {
      if (count <= 0) {
        CartStore.removeFromCart(id);
        return;
      }
      item.count = count;
      AppStorage.set<CartItem[]>('cartItems', [...items]);
      CartStore.updateCartCount();
    }
  }

  // 移除商品
  static removeFromCart(id: number): void {
    const items: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];
    const newItems = items.filter(item => item.id !== id);
    AppStorage.set<CartItem[]>('cartItems', [...newItems]);
    CartStore.updateCartCount();
  }

  // 切换选中状态
  static toggleItemSelection(id: number): void {
    const items: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];
    const item = items.find(item => item.id === id);

    if (item) {
      item.selected = !item.selected;
      AppStorage.set<CartItem[]>('cartItems', [...items]);
    }
  }

  // 全选/反选
  static toggleSelectAll(): void {
    const items: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];
    const allSelected = items.every(item => item.selected);

    items.forEach(item => {
      item.selected = !allSelected;
    });

    AppStorage.set<CartItem[]>('cartItems', [...items]);
  }

  // 获取选中商品总价
  static getSelectedTotalPrice(): number {
    const items: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];
    return items
      .filter(item => item.selected)
      .reduce((total, item) => total + (item.price * item.count), 0);
  }

  // 更新角标数量
  private static updateCartCount(): void {
    const items: CartItem[] = AppStorage.get<CartItem[]>('cartItems') || [];
    const totalCount = items.reduce((total, item) => total + item.count, 0);
    AppStorage.set<number>('cartTotalCount', totalCount);
  }
}

