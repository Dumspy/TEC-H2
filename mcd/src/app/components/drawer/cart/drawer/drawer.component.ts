import { ChangeDetectionStrategy, Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CartService } from 'src/app/services/cart/cart.service';
import { ItemComponent } from "../item/item.component";
import { OrdersService } from 'src/app/services/orders/orders.service';
import { DrawerComponent } from 'src/app/components/drawer/drawer.component';

@Component({
    selector: 'app-cart-drawer',
    standalone: true,
    templateUrl: './drawer.component.html',
    imports: [CommonModule, ItemComponent],
    changeDetection: ChangeDetectionStrategy.OnPush
})

export class CartDrawerComponent {
    @Input() parrent: DrawerComponent | undefined;
    private quant = 0

    constructor(private cartService: CartService, private orderService: OrdersService) {
        this.quantity.subscribe((quantity) => {
            this.quant = quantity
        })
    }

    get total() {
        return this.cartService.getTotal()
    }

    get cart() {
        return this.cartService.getItems()
    }

    get quantity() {
        return this.cartService.getQuantity()
    }

    get orderId() {
        return this.orderService.getOrderId()
    }

    clearCart() {
        this.cartService.clearCart()
        this.parrent?.toggle()
    }

    checkout() {
        if (this.quant <= 0) { return }
        alert(`Order ID: ${this.orderId} placed\nThank you for your purchase!`)
        this.parrent?.toggle();
        this.cartService.checkout()
    }
}
