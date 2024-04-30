import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from 'src/app/services/api/api.service';
import { Product } from 'src/app/services/api/types/product.type';
import { ItemComponent } from "./item/item.component";
import { CapitalizePipe } from "../../../pipes/capitalize.pipe";
import { BehaviorSubject } from 'rxjs';

@Component({
    selector: 'app-category',
    standalone: true,
    templateUrl: './category.component.html',
    imports: [CommonModule, ItemComponent, CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush
})

export class CategoryComponent implements OnInit, OnChanges {
    @Input() category!: string
    validCategory$ = new BehaviorSubject<boolean>(false)
    loading$ = new BehaviorSubject<boolean>(true)
    products: Product[] = []

    constructor(private api: ApiService, private cdr: ChangeDetectorRef){}

    ngOnInit() {
        this.loadCategoryData()
    }

    ngOnChanges(changes: SimpleChanges): void {
        if ('category' in changes) {
            this.loading$.next(true)
            this.loadCategoryData();
        }
    }

    private loadCategoryData() {
        this.api.getAllCategories().subscribe((categories) => {
            this.validCategory$.next(categories.includes(this.category))

            if (this.validCategory$.getValue()) {
                this.loadProducts()
                return
            }

            this.loading$.next(false)
        });
    }

    private loadProducts() {
        this.api.getProductsByCategory(this.category).subscribe((products) => {
            this.products = products;
            this.loading$.next(false)
            this.cdr.markForCheck()
        });
    }
}
