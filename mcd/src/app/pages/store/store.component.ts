import { CommonModule } from '@angular/common';
import { ChangeDetectionStrategy, Component, inject, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { ApiService } from 'src/app/services/api/api.service';
import { CapitalizePipe } from "../../pipes/capitalize.pipe";
import { Observable } from 'rxjs';

@Component({
    selector: 'app-store',
    templateUrl: './store.component.html',
    standalone: true,
    imports: [CommonModule, RouterModule, CapitalizePipe],
    changeDetection: ChangeDetectionStrategy.OnPush
})
export class StoreComponent {
    categories$: Observable<string[]>

    constructor(private api : ApiService) {
        this.categories$ = this.api.getAllCategories()
    }
}
