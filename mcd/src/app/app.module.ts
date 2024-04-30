import { NgModule } from '@angular/core'
import { BrowserModule } from '@angular/platform-browser'
import { HttpClientModule } from '@angular/common/http'

import { AppRoutingModule } from './app-routing.module'
import { AppComponent } from './app.component'
import { CartDrawerComponent } from "./components/drawer/cart/drawer/drawer.component";
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { OrderDrawerComponent } from "./components/drawer/orders/orderdrawer/orderdrawer.component";
import { DrawerComponent } from "./components/drawer/drawer.component";

@NgModule({
    declarations: [
        AppComponent,
    ],
    providers: [],
    bootstrap: [AppComponent],
    imports: [
        BrowserModule,
        BrowserAnimationsModule,
        HttpClientModule,
        AppRoutingModule,
        CartDrawerComponent,
        OrderDrawerComponent,
        CartDrawerComponent,
        DrawerComponent
    ]
})
export class AppModule { }
