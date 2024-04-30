import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ItemComponent } from './item.component';

describe('CategoryItemComponent', () => {
    let component: ItemComponent;
    let fixture: ComponentFixture<ItemComponent>;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [ItemComponent]
        });
        fixture = TestBed.createComponent(ItemComponent);
        component = fixture.componentInstance;

        component.product = {
            id: 1,
            title: 'Test',
            price: 1,
            description: 'Test',
            image: 'Test',
            category: 'Test',
            rating: {
                rate: 1,
                count: 1
            }
        }

        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });

    it('should call addToCart function when add to cart button is clicked', () => {
        spyOn(component, 'addToCart');

        const button = fixture.debugElement.nativeElement.querySelector(`#product${component.product.id}AddToCart`);
        button.click();

        expect(component.addToCart).toHaveBeenCalled();
    });
});
