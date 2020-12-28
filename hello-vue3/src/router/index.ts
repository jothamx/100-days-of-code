import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import Home from '../views/Home.vue'

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/about',
        name: 'About',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
    },
    {
        path: '/lodash',
        name: 'Lodash',
        component: () => import(/* webpackChunkName: "lodash" */ '../views/Lodash.vue')
    },
    {
        path: '/watcher',
        name: 'Watcher',
        component: () => import(/* webpackChunkName: "watcher" */ '../views/Watcher.vue')
    },
    {
        path: '/binding',
        name: 'ClassStyleBindings',
        component: () => import(/* webpackChunkName: "binding" */'../views/ClassStyleBindings.vue')

    }
]

const router = createRouter({
    history: createWebHashHistory(),
    routes
})

export default router
