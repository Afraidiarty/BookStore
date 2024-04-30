import { createApp } from "vue";
import App from "./App.vue";
import { createRouter, createWebHistory } from "vue-router";
import AdminPanel from "./AdminPanel.vue";
import MainComponent from "./Main.vue";
import BookPage from "./BookPage.vue";
import AdminOrder from "./AdminOrder.vue";
import AdminBuyList from "./AdminBuyList.vue";
import myHistory from "./myHistory.vue";

const routes = [
  {
    path: "/AdminPanel",
    component: AdminPanel,
    meta: { title: "Панель администратора" },
  },
  {
    path: "/Main",
    component: MainComponent,
    meta: { title: "Главная страница" },
  },
  {
    path: "/book/:id",
    component: BookPage,
    props: true,
    meta: { title: "Книга" },
  },
  {
    path: "/AdminOrder",
    component: AdminOrder,
    meta: { title: "Админ Панель(просмотр заявок)" },
  },
  {
    path: "/AdminBuyList",
    component: AdminBuyList,
    meta: { title: "История покупок книг" },
  },
  {
    path: "/myHistory",
    component: myHistory,
    meta: { title: "Моя история покупок" },
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

const app = createApp(App);
app.use(router);

router.afterEach((to) => {
  document.title = to.meta.title || "По умолчанию";
});

app.mount("#app");
