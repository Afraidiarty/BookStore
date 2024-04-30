<template>
  <div class="content">
    <div>
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Админ-панель</a>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarNav"
          aria-controls="navbarNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <router-link class="nav-link" to="AdminPanel">Книги</router-link>
            </li>
            <li class="nav-item active">
              <router-link class="nav-link" to="AdminOrder"
                >Просмотр заявок</router-link
              >
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="AdminBuyList"
                >История покупок пользователей</router-link
              >
            </li>
          </ul>
        </div>
      </nav>
    </div>
  </div>
  <br />
  <div class="content">
    <h1 style="text-align: center; font-size: 2em">Заявки</h1>
    <br />

    <!-- Проверяем наличие данных -->
    <table v-if="data && data.length" class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Номер заказа</th>
          <th scope="col">ФИО</th>
          <th scope="col">Email</th>
          <th scope="col">Телефон</th>
          <th scope="col">Название книги</th>
          <th scope="col">ID книги</th>
          <th scope="col">Имя учетной записи</th>
          <th scope="col"></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in data" :key="item.id">
          <td>{{ index + 1 }}</td>
          <td>{{ item.FIO }}</td>
          <td>{{ item.email }}</td>
          <td>{{ item.phone }}</td>
          <td>{{ item.title }}</td>
          <td>{{ item.book_id }}</td>
          <td>{{ item.name }}</td>
          <td>
            <button
              class="btn btn-primary"
              @click="acceptOrder(item.name, item.title, item.id)"
            >
              Принять заказ
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    <div v-else>
      <div
        style="
          display: flex;
          justify-content: center;
          align-items: center;
          height: 60vh;
        "
      >
        <h2 style="font-size: 40px; font-family: 'Montserrat'">
          Заявки отсутвуют
        </h2>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { fetchInfo } from "./api.js";

export default {
  data() {
    return {
      data: [],
      additionalInfo: null,
    };
  },
  async mounted() {
    this.getOrders();
    await this.fetchAdditionalInfo();
    if (this.additionalInfo && this.additionalInfo.levelAccess < 2) {
      this.$router.push("/Main");
    }
  },
  methods: {
    async fetchAdditionalInfo() {
      try {
        const username = this.getUsername();
        this.additionalInfo = await fetchInfo(username);
        console.log(this.additionalInfo);
      } catch (error) {
        console.error("Ошибка при получении дополнительной информации:", error);
      }
    },
    getUsername() {
      return localStorage.getItem("username");
    },
    getOrders() {
      axios
        .get("http://pject/backend/getOrders.php")
        .then((response) => {
          this.data = response.data;
          console.log(this.data.NotExit);
        })
        .catch((error) => {
          console.error(error);
        });
    },
    acceptOrder(name, book_name, id_order) {
      axios
        .post(
          "http://pject/backend/acceptOrder.php",
          {
            name: name,
            book_name: book_name,
            id_order: id_order,
          },
          {
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            },
          }
        )
        .then((response) => {
          window.location.reload();
          console.log("Ответ от сервера:", response.data);
        })
        .catch((error) => {
          console.error("Ошибка при отправке запроса:", error);
        });
    },
  },
};
</script>

<style scoped>
@import "./assets/main.css";
.content {
  font-family: "Lucida Sans", "Lucida Sans Regular", "Lucida Grande",
    "Lucida Sans Unicode", Geneva, Verdana, sans-serif;
}
</style>
