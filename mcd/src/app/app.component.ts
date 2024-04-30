import { Component } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent {
    currentRoute!: string

    constructor(private router: Router) {
        this.router.events.subscribe((event) => {
            if(event instanceof NavigationEnd) {
                const baseRoute = event.url.split('/')[1] || 'home'
                this.currentRoute = baseRoute
            }
        })
    }
}
