import { TestBed } from '@angular/core/testing';

import { CartService } from './cart.service';
import { take } from 'rxjs';

describe('CartService', () => {
    let service: CartService

    const testProdct = {
        id: 1,
        title: 'Test',
        price: 100,
        image: 'test.jpg',
        rating: {
            count: 0,
            rate: 0
        },
        category: 'test',
        description: 'test'
    }

    const testProdct2 = {
        id: 2,
        title: 'Test',
        price: 55,
        image: 'test.jpg',
        rating: {
            count: 0,
            rate: 0
        },
        category: 'test',
        description: 'test'
    }

    beforeEach(() => {
        TestBed.configureTestingModule({})
        service = TestBed.inject(CartService)
    })

    it('should be created', () => {
        expect(service).toBeTruthy()
    })

    it('should add a product to the cart', () => {
        service.addToCart(testProdct)
        service.getItems().subscribe((items) => {
            expect(items[0].id).toBe(testProdct.id)
        })
    })

    it('should remove a product from the cart', () => {
        service.addToCart(testProdct)
        service.removeItem(testProdct.id)
        service.getItems().subscribe((items) => {
            expect(items.length).toBe(0)
        })
    })

    it('should clear the cart', () => {
        service.addToCart(testProdct)
        service.clearCart()
        service.getItems().subscribe((items) => {
            expect(items.length).toBe(0)
        })
    })

    it('should set the quantity of a product', () => {
        service.addToCart(testProdct)
        service.setQuantity(testProdct.id, 2)
        service.getItems().subscribe((items) => {
            expect(items[0].quantity).toBe(2)
        })
    })

    it('should get the quantity of the cart', () => {
        service.addToCart(testProdct)
        service.addToCart(testProdct)
        service.addToCart(testProdct)
        service.getQuantity().subscribe((quantity) => {
            expect(quantity).toBe(3)
        })
    })

    it('should remove an product from the cart when quantity of the product is set to 0', () => {
        service.addToCart(testProdct)
        service.setQuantity(testProdct.id, 0)
        service.getItems().subscribe((items) => {
            expect(items.length).toBe(0)
        })
    })

    it('should get the total of the cart', () => {
        service.addToCart(testProdct)
        service.addToCart(testProdct)
        service.addToCart(testProdct2)
        service.getTotal().subscribe((total) => {
            expect(total).toBe(testProdct.price * 2 + testProdct2.price)
        })
    })

    it('should not remove a product from the cart if it does not exist', () => {
        service.addToCart(testProdct)
        service.removeItem(testProdct2.id)
        service.getItems().subscribe((items) => {
            expect(items.length).toBe(1)
        })
    })

    it('should return the quantity of a product', () => {
        service.addToCart(testProdct)
        service.setQuantity(testProdct.id, 2)

        service.getItemQuantity(testProdct.id).pipe(take(1)).subscribe((quantity) => {
            expect(quantity).toBe(2)
        })

        service.setQuantity(testProdct.id, 10)

        service.getItemQuantity(testProdct.id).pipe(take(1)).subscribe((quantity) => {
            expect(quantity).toBe(10)
        })
    })

});
