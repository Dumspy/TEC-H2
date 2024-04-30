import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { cartItem } from 'src/app/services/cart/cart.service';

@Component({
  selector: 'app-orderitems',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './orderitems.component.html',
})

export class OrderitemsComponent {
  @Input() order: cartItem[] = [];
  @Input() id: number = 0;

  get totalValue() {
    return this.order.reduce((acc, item) => {
      return acc + item.price * item.quantity;
    }, 0);
  }
}
