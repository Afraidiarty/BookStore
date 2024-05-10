<template>
  <AppHeader />
  <main>
    <section class="goods">
      <div class="container">
        <div class="section__top">
          <div class="section__titles">
            <h1 class="section__title">{{ $t("popular_books") }}</h1>
          </div>
        </div>
        <template v-if="books && books.length">
          <div class="section__goods">
            <div v-for="book in books" :key="book.id" class="card">
              <div class="card_content">
                <div class="card__img">
                  <img :src="require('./uploads/' + book.coverImage)" alt="" />
                </div>
                <div class="card__desc">
                  <router-link :to="'/book/' + book.id">{{
                    book.title
                  }}</router-link>
                </div>
                <div class="card__price">{{ book.price }} €</div>
                <div class="card__bottom" v-if="isLoggedIn">
                  <a
                    href="#"
                    class="card_buy"
                    @click.prevent="openPurchaseModal(book.id)"
                    >Купить</a
                  >
                </div>
                <div v-else class="warn__to">{{ $t("plz_signin") }}</div>
              </div>
            </div>
          </div>
        </template>

        <template v-else>
          <div
            style="
              display: flex;
              justify-content: center;
              align-items: center;
              height: 60vh;
            "
          >
            <h2 style="font-size: 40px; font-family: 'Montserrat'">
              {{ $t("not_exist") }}
            </h2>
          </div>
        </template>
      </div>
    </section>

    <section class="goods">
      <div class="container">
        <div class="section__top">
          <div class="section__titles">
            <h1 class="section__title">{{ $t("recomended") }}</h1>
          </div>
        </div>
        <template v-if="books && dataRecomended.length">
          <div class="section__goods">
            <div v-for="book in dataRecomended" :key="book.id" class="card">
              <div class="card_content">
                <div class="card__img">
                  <img :src="require('./uploads/' + book.coverImage)" alt="" />
                </div>
                <div class="card__desc">
                  <router-link :to="'/book/' + book.id">{{
                    book.title
                  }}</router-link>
                </div>
                <div class="card__price">{{ book.price }} €</div>
                <div class="card__bottom">
                  <a
                    href="#"
                    class="card_buy"
                    @click.prevent="openPurchaseModal(book.id)"
                    >{{ $t("buy") }}</a
                  >
                </div>
              </div>
            </div>
          </div>
        </template>

        <template v-else>
          <div
            style="
              display: flex;
              justify-content: center;
              align-items: center;
              height: 60vh;
            "
          >
            <h2 style="font-size: 40px; font-family: 'Montserrat'">
              {{ $t("not_exist") }}
            </h2>
          </div>
        </template>
      </div>
    </section>
  </main>

  <PurchaseModal
    v-if="showPurchaseModal"
    @close="showPurchaseModal = false"
    :selectedBookId="selectedBookId"
    :my_name="my_name"
  />
</template>

<script>
import AppHeader from "./components/Header.vue";
import axios from "axios";
import PurchaseModal from "./components/PurchaseModal.vue";

export default {
  name: "MainPage",
  components: {
    AppHeader,
    PurchaseModal,
  },
  data() {
    return {
      message: "",
      serverResponse: null,
      username: "",
      email: "",
      password: "",
      registrationMessage: "",
      successMessage: "",
      books: [],
      showPurchaseModal: false,
      selectedBookId: null,
      my_name: "",
      dataRecomended: [],
      myHistoryBuy: [],
    };
  },
  mounted() {
    this.fetchBooksSort();
    this.getHistoryRecommend();
  },
  computed: {
    isLoggedIn() {
      return localStorage.getItem("username") !== null;
    },
  },
  methods: {
    async getHistoryRecommend() {
      const username = this.getUsername();
      axios
        .post(
          "http://pject/backend/getMyHistory.php",
          { name: username },
          {
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            },
          }
        )
        .then((response) => {
          this.myHistoryBuy = response.data;
          console.log(this.myHistoryBuy);
          if (
            this.isLoggedIn &&
            this.myHistoryBuy &&
            this.myHistoryBuy.length > 0
          ) {
            const username = this.getUsername();
            axios
              .post(
                "http://pject/backend/recomended.php",
                { name: username },
                {
                  headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                  },
                }
              )
              .then((response) => {
                this.dataRecomended = response.data;
                console.log(this.dataRecomended);
              })
              .catch((error) => {
                console.error(error);
              });
          }
        })
        .catch((error) => {
          console.error(error);
        });
    },

    openPurchaseModal(bookId) {
      this.showPurchaseModal = true;
      this.selectedBookId = bookId;
      this.my_name = this.getUsername();
      console.log(this.my_name);
      console.log(this.showPurchaseModal);
      console.log(bookId);
    },
    fetchBooksSort() {
      axios
        .get("http://pject/backend/popularBooks.php")
        .then((response) => {
          console.log("Response length:", response.data.length);
          this.books = response.data;
        })
        .catch((error) => {
          console.error(error);
        });
    },

    getUsername() {
      return localStorage.getItem("username") || "Guest";
    },
    showSuccessMessage(message) {
      this.successMessage = message;
      setTimeout(() => {
        this.successMessage = "";
      }, 2000);
    },
  },
};
</script>

<style scoped>
@import "./assets/main.css";

.alert {
  position: fixed;
  top: 10px;
  right: 10px;
  font-family: "Montserrat", sans-serif;
}
.card {
  width: 18%;
}
.warn__to {
  text-align: center;
  cursor: pointer;
  font-family: "Roboto", sans-serif;
}
</style>
