import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ItemComponent } from './item.component';

describe('CartItemComponent', () => {
    let component: ItemComponent;
    let fixture: ComponentFixture<ItemComponent>;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [ItemComponent]
        });
        fixture = TestBed.createComponent(ItemComponent);
        component = fixture.componentInstance;

        component.item = {
            id: 1,
            title: 'Test Item',
            price: 10,
            image: 'test.jpg',
            quantity: 3,
        }

        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should call the increase quantity function when the increased button is clicked', () => {
        spyOn(component, 'increaseQuantity');

        const button = fixture.nativeElement.querySelector('[aria-label="Increase quantity"]');
        button.click();

        expect(component.increaseQuantity).toHaveBeenCalled();
    });

    it('should call the decrease quantity function when the decreased button is clicked', () => {
        spyOn(component, 'decreaseQuantity');

        const button = fixture.nativeElement.querySelector('[aria-label="Decrease quantity"]') as HTMLButtonElement;
        button.click();

        expect(component.decreaseQuantity).toHaveBeenCalled();
    });

    it('should call the removeItem function when the remove button is clicked', () => {
        spyOn(component, 'removeItem');

        const button = fixture.nativeElement.querySelector('[aria-label="Remove '+component.item.title+' from cart"]') as HTMLButtonElement;
        button.click();

        expect(component.removeItem).toHaveBeenCalledWith();
    });
});
