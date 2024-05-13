<template>
  <div class="content">
    <div>
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Admin Panel</a>
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
              <router-link class="nav-link" to="AdminPanel">Books</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="AdminOrder"
                >List order</router-link
              >
            </li>
            <li class="nav-item active">
              <router-link class="nav-link" to="AdminBuyList"
                >List user buy history</router-link
              >
            </li>
          </ul>
        </div>
      </nav>
    </div>
  </div>
  <div class="content">
    <br />
    <h1 style="text-align: center; font-size: 2em">List buy books</h1>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>ID purchase number</th>
          <th>Book Title</th>
          <th>User (nickname)</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in data" :key="item.id">
          <td>{{ item.id }}</td>
          <td>{{ item.book_name }}</td>
          <td>{{ item.name }}</td>
        </tr>
      </tbody>
    </table>
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
    this.GetBuy();
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
    GetBuy() {
      axios
        .get("http://pject/backend/getBuyList.php")
        .then((response) => {
          this.data = response.data;
          console.log(this.data);
        })
        .catch((error) => {
          console.error(error);
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
