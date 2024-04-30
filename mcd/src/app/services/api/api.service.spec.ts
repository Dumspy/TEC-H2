import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule } from '@angular/common/http/testing';

import { ApiService } from './api.service';

describe('ApiService', () => {
    let service: ApiService;

    beforeEach(() => {
        TestBed.configureTestingModule({
            imports: [HttpClientTestingModule]
        });
        service = TestBed.inject(ApiService);
    });

    it('should be created', () => {
        expect(service).toBeTruthy();
    });

    it('should have getProductsByCategory function', () => {
        expect(service.getProductsByCategory).toBeTruthy();
    });

    it('should have getAllCategories function', () => {
        expect(service.getAllCategories).toBeTruthy();
    });
});
