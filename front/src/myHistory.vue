<template>
  <AppHeader />
  <div class="content">
    <br />
    <h1 style="text-align: center; font-size: 2em">История покупок книг</h1>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>Номер покупки</th>
          <th>Название Книги</th>
          <th>Цена</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in data" :key="item.id">
          <td>{{ index + 1 }}</td>
          <td>{{ item.book_name }}</td>
          <td>{{ item.name }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import AppHeader from "./components/Header.vue";
import { fetchInfo } from "./api.js";
import axios from "axios";

export default {
  name: "MyHistory",
  data() {
    return {
      additionalInfo: null,
      data: [],
    };
  },
  components: {
    AppHeader,
  },
  async mounted() {
    await this.fetchAdditionalInfo();
    this.getHistory();
  },
  methods: {
    getHistory() {
      axios
        .post(
          "http://pject/backend/getMyHistory.php",
          { name: this.additionalInfo.name },
          {
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            },
          }
        )
        .then((response) => {
          this.data = response.data;
          console.log(this.data);
        })
        .catch((error) => {
          console.error(error);
        });
      console.log("Additional Info in getHistory:", this.additionalInfo);
    },
    getUsername() {
      return localStorage.getItem("username");
    },
    async fetchAdditionalInfo() {
      try {
        const username = this.getUsername();
        this.additionalInfo = await fetchInfo(username);
      } catch (error) {
        console.error("Ошибка при получении дополнительной информации:", error);
      }
    },
  },
};
</script>

<style scoped>
.content {
  font-family: "Roboto", sans-serif;
}
</style>
