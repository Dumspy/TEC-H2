import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { GetAllCategoriesResponse } from './types/get-all-categories.response';
import { GetProductsByCategoryResponse } from './types/get-products-by-category.response';

const defaultHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json',
}

@Injectable({
    providedIn: 'root'
})

export class ApiService {
    http = inject(HttpClient)

    private cache$ = new Map<string, Observable<unknown>>()

    getAllCategories(refetch = false) {
        if(!this.cache$.get('categories') || refetch){
            this.cache$.set('categories', this.http.get('https://fakestoreapi.com/products/categories',{headers : defaultHeaders}))
        }

        return this.cache$.get('categories') as Observable<GetAllCategoriesResponse>
    }

    getProductsByCategory(category: string, refetch = false) {
        if(!this.cache$.get(`${category}-products`) || refetch){
            this.cache$.set(`${category}-products`, this.http.get(`https://fakestoreapi.com/products/category/${category}`,{headers : defaultHeaders}))
        }

        return this.cache$.get(`${category}-products`) as Observable<GetProductsByCategoryResponse>
    }
}
