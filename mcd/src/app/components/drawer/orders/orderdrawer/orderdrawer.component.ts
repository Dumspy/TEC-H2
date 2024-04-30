import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BehaviorSubject } from 'rxjs';
import { OrdersService } from 'src/app/services/orders/orders.service';
import { trigger, transition, style, animate } from '@angular/animations';
import { OrderitemsComponent } from "../orderitems/orderitems.component"; 
import { DrawerComponent } from 'src/app/components/drawer/drawer.component';

@Component({
    selector: 'app-orderdrawer',
    standalone: true,
    animations: [
        trigger('slideInOut', [
            transition(':enter', [
                style({ transform: 'translateX(100%)' }),
                animate('400ms ease-in-out', style({ transform: 'translateX(0%)' }))
            ]),
            transition(':leave', [
                animate('400ms ease-in-out', style({ transform: 'translateX(100%)' }))
            ])
        ])
    ],
    templateUrl: './orderdrawer.component.html',
    imports: [CommonModule, OrderitemsComponent]
})

export class OrderDrawerComponent {
    @Input() parrent: DrawerComponent | undefined;

    constructor(private ordersService: OrdersService) { }

    get orders() {
        return this.ordersService.getOrders();
    }

    get totalValue() {
        return this.ordersService.getTotalValue();
    }
}