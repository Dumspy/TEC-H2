import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrderdrawerComponent } from './orderdrawer.component';

describe('OrderdrawerComponent', () => {
  let component: OrderdrawerComponent;
  let fixture: ComponentFixture<OrderdrawerComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [OrderdrawerComponent]
    });
    fixture = TestBed.createComponent(OrderdrawerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
