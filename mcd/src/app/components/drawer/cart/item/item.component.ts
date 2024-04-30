import { ChangeDetectionStrategy, Component, Input, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CartService, cartItem } from 'src/app/services/cart/cart.service';

@Component({
    selector: 'app-cart-item',
    standalone: true,
    imports: [CommonModule],
    templateUrl: './item.component.html',
    changeDetection: ChangeDetectionStrategy.OnPush
})

export class ItemComponent {
    @Input() item!: cartItem

    constructor(private cartService: CartService) {}

    get quantity() {
        return this.cartService.getItemQuantity(this.item.id)
    }

    increaseQuantity() {
        this.cartService.setQuantity(this.item.id, this.item.quantity + 1)
    }

    decreaseQuantity() {
        this.cartService.setQuantity(this.item.id, this.item.quantity - 1)
    }

    removeItem() {
        this.cartService.removeItem(this.item.id)
    }
}
