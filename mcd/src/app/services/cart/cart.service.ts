import { Injectable } from '@angular/core';
import { Product } from '../api/types/product.type';
import { BehaviorSubject, map } from 'rxjs';
import { OrdersService } from '../orders/orders.service';

export type cartItem = Pick<Product, 'id' | 'title' | 'price' | 'image'> & { quantity: number };

@Injectable({
    providedIn: 'root'
})

export class CartService {
    private cart$ = new BehaviorSubject<cartItem[]>([]);

    constructor(private orderService: OrdersService) { }

    addToCart(product: Product) {
        const cart = [...this.cart$.getValue()]
        const item = cart.find((item) => item.id === product.id);

        if (item) {
            item.quantity++;
        } else {
            cart.push({
                id: product.id,
                title: product.title,
                price: product.price,
                image: product.image,
                quantity: 1
            });
        }

        this.cart$.next(cart);
    }

    setQuantity(id: number, quantity: number) {
        const cart = [...this.cart$.getValue()]
        const item = cart.find((item) => item.id === id);

        if (!item) { return }
        if (quantity === 0) {
            this.removeItem(id);
            return;
        }

        item.quantity = quantity;

        this.cart$.next(cart);
    }

    clearCart() {
        this.cart$.next([]);
    }

    removeItem(id: number) {
        const cart = [...this.cart$.getValue()]
        const item = cart.find((item) => item.id === id);

        if (!item) { return }

        this.cart$.next(cart.filter((item) => item.id !== id))
    }

    getQuantity() {
        return this.cart$.pipe(
            map((items) => items.reduce((acc, item) => acc + item.quantity, 0))
        );
    }

    getTotal() {
        return this.cart$.pipe(
            map((items) => items.reduce((acc, item) => acc + item.price * item.quantity, 0))
        );
    }

    getItems() {
        return this.cart$.asObservable();
    }

    getItemQuantity(id: number) {
        return this.cart$.pipe(
            map((items) => {
                const item = items.find((item) => item.id === id);
                return item ? item.quantity : 0;
            })
        );
    }

    checkout () {
        this.orderService.addOrder(this.cart$.getValue());
        this.clearCart();
    }
}
