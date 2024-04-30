import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { StoreComponent } from './store.component';
import { CategoryComponent } from './category/category.component';

const routes: Routes = [
    { path: '', component: StoreComponent, children: [
            { path: ':category', component: CategoryComponent }
        ]
    },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})

export class StoreRoutingModule { }
