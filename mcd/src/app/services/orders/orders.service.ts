import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { cartItem } from '../cart/cart.service';

@Injectable({
  providedIn: 'root'
})
export class OrdersService {
  private completedOrders$ = new BehaviorSubject<cartItem[][]>([]);

  constructor() {
    const orders = JSON.parse(localStorage.getItem('orders') ?? '[]');
    if (orders) {
      this.completedOrders$.next(orders);
    }
  }

  getTotalValue() {
    return this.completedOrders$.getValue().reduce((acc, order) => {
      return acc + order.reduce((acc, item) => {
        return acc + item.price * item.quantity;
      }, 0);
    }, 0);
  }

  getOrders() {
    return this.completedOrders$.asObservable();
  }

  getOrderId() {
    return this.completedOrders$.getValue().length + 1;
  }

  addOrder(order: cartItem[]) {
    this.completedOrders$.next([...this.completedOrders$.getValue(), order]);

    localStorage.setItem('orders', JSON.stringify(this.completedOrders$.getValue()));
  }
}
