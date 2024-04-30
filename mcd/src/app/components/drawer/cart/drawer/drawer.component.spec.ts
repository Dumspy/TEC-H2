import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CartDrawerComponent } from './drawer.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

describe('DrawerComponent', () => {
    let component: CartDrawerComponent;
    let fixture: ComponentFixture<CartDrawerComponent>;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [CartDrawerComponent, BrowserAnimationsModule]
        });
        fixture = TestBed.createComponent(CartDrawerComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should not display the drawer when hidden is true', () => {
        component.hidden$.next(true)
        fixture.detectChanges()

        const drawer = fixture.nativeElement.querySelector('*')

        expect(drawer).toBeFalsy()
    })

    it('should display the drawer when hidden is false', () => {
        component.hidden$.next(false);
        fixture.detectChanges();

        const drawer = fixture.nativeElement.querySelector('*');

        expect(drawer).toBeTruthy();
    })
});
