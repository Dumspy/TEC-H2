import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RouterTestingModule } from "@angular/router/testing";
import { HttpClientTestingModule } from '@angular/common/http/testing';

import { CategoryComponent } from './category.component';

describe('CategoryComponent', () => {
    let component: CategoryComponent;
    let fixture: ComponentFixture<CategoryComponent>;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [CategoryComponent, RouterTestingModule, HttpClientTestingModule]
        });
        fixture = TestBed.createComponent(CategoryComponent);
        component = fixture.componentInstance;

        component.category = 'Test';

        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
