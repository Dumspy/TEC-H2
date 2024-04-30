import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BehaviorSubject } from 'rxjs';
import { trigger, transition, style, animate } from '@angular/animations';

@Component({
    selector: 'app-drawer',
    standalone: true,
    imports: [CommonModule],
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
    templateUrl: './drawer.component.html',
})
export class DrawerComponent {
    hidden$ = new BehaviorSubject<boolean>(true)

    toggle() {
        this.hidden$.next(!this.hidden$.getValue())
    }
}
