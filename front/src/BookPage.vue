<template>
  <AppHeader />
  <div class="container">
    <div v-for="book in books" :key="book.id" class="card">
      <div class="shoeBackground">
        <img
          :src="require('./uploads/' + book.coverImage)"
          alt="Book Cover"
          class="book-image"
        />
        <a href="#" class="share"><i class="fas fa-share-alt"></i></a>
      </div>
      <div class="info">
        <div class="shoeName">
          <div>
            <h1 class="big">{{ book.title }}</h1>
          </div>
          <h3 class="small">{{ $t("author") }}: {{ book.author }}</h3>
          <h3 class="small">{{ $t("izdatel") }}: {{ book.izdatel }}</h3>
          <h3 class="small">{{ $t("countPage") }}: {{ book.pageCount }}</h3>
          <h3
            @click="showModal = true"
            class="small"
            style="font-weight: 600; cursor: pointer"
          >
            {{ $t("read_desc") }}
          </h3>
        </div>

        <div class="genre-container">
          <h3 class="title">{{ $t("genre") }}</h3>
          <div class="genres">
            <span class="genre">{{ book.genre }}</span>
          </div>
        </div>
        <div class="buy-price">
          <a @click.prevent="openPurchaseModal(book.id)" href="#" class="buy"
            ><i class="fas fa-shopping-cart"></i>{{ $t("buy") }}</a
          >
          <div class="price">
            <i class="fas fa-dollar-sign"></i>
            <h1>189.99</h1>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="details__content">
    <div class="details__content__">
      <form
        v-if="isLoggedIn"
        class="form-container"
        @submit.prevent="submitForm"
      >
        <textarea
          v-model="reviewText"
          class="form__input textarea"
          placeholder="Оставьте отзыв"
          name="reviewText"
          id="reviewText"
          cols="30"
          rows="6"
        ></textarea>

        <div class="star-rating">
          <input
            type="radio"
            id="star5"
            name="rating"
            value="5"
            @change="updateRating"
          />
          <label for="star5" :class="{ filled: rating >= 5 }"></label>
          <input
            type="radio"
            id="star4"
            name="rating"
            value="4"
            @change="updateRating"
          />
          <label for="star4" :class="{ filled: rating >= 4 }"></label>
          <input
            type="radio"
            id="star3"
            name="rating"
            value="3"
            @change="updateRating"
          />
          <label for="star3" :class="{ filled: rating >= 3 }"></label>
          <input
            type="radio"
            id="star2"
            name="rating"
            value="2"
            @change="updateRating"
          />
          <label for="star2" :class="{ filled: rating >= 2 }"></label>
          <input
            type="radio"
            id="star1"
            name="rating"
            value="1"
            @change="updateRating"
          />
          <label for="star1" :class="{ filled: rating >= 1 }"></label>
        </div>
        <br />
        <button type="submit" class="submit-button">Отправить</button>
      </form>
      <br />
      <div class="reviews__container">
        <div
          v-for="(review, index) in reviews"
          :key="index"
          class="reviews__single"
        >
          <div>
            <img class="avatar" src="./img/4794936.png" alt="" />
            <h4 class="reviews__title">{{ review.name }}</h4>
          </div>
          <div class="review__data">
            <div class="review__rating">
              <img
                v-for="star in parseInt(review.rating)"
                :key="star"
                src="./icons/FullStar.svg"
                alt=""
              />
            </div>
            <p class="review__description">{{ review.text }}</p>
          </div>
          <div
            v-if="additionalInfo && additionalInfo.levelAccess > 1"
            style="display: flex; justify-content: space-between"
          >
            <br /><br />
            <!-- Кнопки редактировать и удалить -->
            <div class="btn-group" style="margin-top: 15px">
              <button
                type="button"
                class="btn btn-primary"
                @click="editReview(index, review.id)"
              >
                Редактировать
              </button>
              <button
                type="button"
                class="btn btn-danger"
                @click="deleteReview(review.id)"
              >
                Удалить
              </button>
            </div>
            <!-- Конец кнопок -->
          </div>
        </div>
      </div>
    </div>
  </div>

  <div>
    <div v-if="!isRatingSelected" class="alert alert-danger" role="alert">
      Пожалуйста, выберите оценку
    </div>
  </div>

  <!-- Модальное окно -->
  <div v-if="editingIndex !== null" class="edit-modal">
    <div class="edit-modal-content">
      <span class="close" @click="closeModal">&times;</span>
      <textarea class="form-control" v-model="editedText" rows="4"></textarea>
      <button class="btn btn-primary" @click="saveChanges">Сохранить</button>
    </div>
  </div>

  <div v-if="editingIndex !== null" class="modal-overlay"></div>

  <div class="modaler-overlay" v-show="showModal"></div>
  <div v-for="book in books" :key="book.id" v-show="showModal" class="modaler">
    <h1>{{ $t("desc") }}</h1>
    <p>{{ book.description }}</p>
    <button class="button" @click="showModal = false">
      {{ $t("close_modal") }}
    </button>
  </div>

  <PurchaseModal
    v-if="showPurchaseModal"
    @close="showPurchaseModal = false"
    :selectedBookId="selectedBookId"
    :my_name="my_name"
  />
</template>

<script>
import axios from "axios";
import AppHeader from "./components/Header.vue";
import { fetchInfo } from "./api.js";
import PurchaseModal from "./components/PurchaseModal.vue";

export default {
  name: "BookPage",
  components: {
    AppHeader,
    PurchaseModal,
  },
  computed: {
    isLoggedIn() {
      return localStorage.getItem("username") !== null;
    },
  },
  data() {
    return {
      id: this.$route.params.id,
      books: [],
      reviews: [],
      reviewText: "",
      rating: null,
      additionalInfo: null,
      isRatingSelected: true,
      editingIndex: null,
      editedText: "",
      reviewId: null,
      showModal: false,
      showPurchaseModal: false,
    };
  },
  mounted() {
    this.fetchBookById(this.id);
    this.fetchAdditionalInfo();
    this.fetchReviews(this.id);
  },

  methods: {
    openPurchaseModal(bookId) {
      this.showPurchaseModal = true;
      this.selectedBookId = bookId;
      this.my_name = this.getUsername();
      console.log(this.my_name);
      console.log(this.showPurchaseModal);
      console.log(bookId);
    },
    deleteReview(reviewId) {
      axios
        .post(
          "http://pject/backend/deleteReviews.php",
          {
            reviewId: reviewId,
          },
          {
            headers: {
              "Content-Type": "application/json",
            },
          }
        )
        .then((response) => {
          console.log(response.data);
          window.location.reload();
        })
        .catch((error) => {
          console.error("Error editing review:", error);
        });
    },
    editReview(index, reviewId) {
      this.editingIndex = index;
      this.editedText = this.reviews[index].text;
      this.reviewId = reviewId;

      console.log(this.reviewId);
    },
    closeModal() {
      this.editingIndex = null;
      this.editedText = "";
    },
    saveChanges() {
      if (this.editingIndex !== null) {
        try {
          axios
            .post(
              "http://pject/backend/editReviews.php",
              {
                editedText: this.editedText,
                reviewId: this.reviewId,
              },
              {
                headers: {
                  "Content-Type": "application/json",
                },
              }
            )
            .then((response) => {
              console.log(response.data);
              window.location.reload();
            })
            .catch((error) => {
              console.error("Error editing review:", error);
            });
        } catch (error) {
          console.error("Error fetching reviews:", error);
        }

        this.closeModal();
      }
    },

    async fetchReviews(id) {
      try {
        const response = await axios.get(
          `http://pject/backend/getReviews.php?id=${id}`
        );

        this.reviews = response.data;
        console.log(this.reviews);
      } catch (error) {
        console.error("Error fetching reviews:", error);
      }
    },

    getUsername() {
      return localStorage.getItem("username");
    },
    async fetchBookById(id) {
      try {
        const response = await axios.get(
          `http://pject/backend/getBooksID.php?id=${id}`
        );

        this.books = response.data;
        console.log(this.books);
      } catch (error) {
        console.error("Ошибка при получении данных о книге:", error);
      }
    },
    async fetchAdditionalInfo() {
      try {
        const username = this.getUsername();
        this.additionalInfo = await fetchInfo(username);
        console.log(this.additionalInfo);
      } catch (error) {
        console.error("Ошибка при получении дополнительной информации:", error);
      }
    },
    updateRating(event) {
      this.rating = event.target.value;
    },
    submitForm() {
      if (!this.rating) {
        this.isRatingSelected = false;
        return;
      } else {
        console.log("Форма отправлена!");
        this.isRatingSelected = true;
      }

      const formData = {
        reviewText: this.reviewText,
        rating: this.rating,
        id_book: this.id,
        id_user: this.additionalInfo.UserID,
      };

      console.log(formData);

      axios
        .post("http://pject/backend/addReviews.php", formData, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((response) => {
          console.log(response.data);
          window.location.reload();
        })
        .catch((error) => {
          console.error("Error:", error);
        });
    },
  },
  created() {
    this.fetchAdditionalInfo();
  },
};
</script>

<style scoped>
body {
  font-family: Arial, sans-serif;
}
textarea.form-control {
  height: 138px;
  width: 700px;
}
.product {
  display: flex;
  margin-bottom: 2em;
}
.product img {
  max-width: 200px;
  margin-right: 2em;
}
.alert {
  position: fixed;
  top: 10px;
  right: 10px;
  font-family: "Montserrat", sans-serif;
}
.reviews {
  margin-top: 2em;
}
.review {
  font-family: Days One, sans-serif;
  border-top: 1px solid #ccc;
  padding: 1em 0;
}

.details__content {
  font-family: Days One, sans-serif;
  padding: 20px;
  background-color: #f7f7f7;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.reviews__container {
  display: flex;
  flex-wrap: wrap;
}

.reviews__single {
  width: 31%;
  margin: 0 auto 20px;
  padding: 20px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.book-details {
  display: flex;
}
.reviews__single[data-v-e03193de]:not(:first-child) {
  margin: 0 auto 20px;
}

.reviews__title {
  font-size: 1.2rem;
  color: #333;
  margin-bottom: 10px;
}

.review__description {
  font-size: 1rem;
  color: #666;
}
/* Стили для модального окна(редиктирование) */
.edit-modal {
  font-family: "Roboto", sans-serif;

  display: flex;
  align-items: center;
  justify-content: center;
  position: fixed;
  z-index: 1000;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
.button {
  padding: 10px 20px;
  border: none;
  outline: none;
  font-size: 15px;
  border-radius: 20px;
  cursor: pointer;
  background-color: #3284ed;
  color: white;
  margin-left: auto;
}

.modal-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 98;
  background-color: rgba(0, 0, 0, 0.3);
}

.modal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 99;

  width: 100%;
  max-width: 400px;
  background-color: #fff;
  border-radius: 16px;

  padding: 25px;

  h1 {
    color: #222;
    font-size: 32px;
    font-weight: 900;
    margin-bottom: 15px;
  }

  p {
    color: #666;
    font-size: 18px;
    font-weight: 400;
    margin-bottom: 15px;
  }
}
.edit-modal-content {
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  position: relative;
}

.close {
  position: absolute;
  top: 10px;
  right: 10px;
  cursor: pointer;
}
.modaler {
  font-family: "Roboto", sans-serif;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 99;
  line-height: 30px;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  width: 100%;
  max-width: 400px;
  background-color: #fff;
  border-radius: 16px;

  padding: 25px;

  h1 {
    color: #222;
    font-size: 32px;
    font-weight: 900;
    margin-bottom: 15px;
  }

  p {
    color: #666;
    font-size: 18px;
    font-weight: 400;
    margin-bottom: 15px;
  }
}
.modal-overlay {
  position: fixed;
  z-index: 999;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.review__rating img {
  width: 20px;
  height: 20px;
}

.form__input {
  width: 100%;
  padding: 10px;
  margin-top: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.textarea {
  outline: none;
  font-family: "Montserrat", sans-serif;
}

.submit-button {
  background-color: #007bff;
  color: #fff;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.submit-button:hover {
  background-color: #0056b3;
}
.avatar {
  width: 6%;
}
.star-rating {
  unicode-bidi: bidi-override;
  direction: rtl;
  text-align: left;
}

.star-rating input[type="radio"] {
  display: none;
}

.star-rating label {
  display: inline-block;
  margin: 0 1px;
  width: 25px;
  height: 25px;
  background-image: url("./icons/Empty.svg");
  background-size: cover;
}

.star-rating input[type="radio"]:checked ~ label {
  background-image: url("./icons/FullStar.svg");
}

.star-rating input[type="radio"]:not(:checked) ~ label:hover,
.star-rating input[type="radio"]:not(:checked) ~ label:hover ~ label {
  background-image: url("./icons/FullStar.svg");
}
form.form-container {
  width: 31%;
  margin: 0 auto;
}
.book-container {
  font-family: "Roboto", sans-serif;
  line-height: 35px;
  margin-top: 16px;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 60%;
  padding: 20px;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  text-align: left;
}
.modaler-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 98;
  background-color: rgba(0, 0, 0, 0.3);
  height: 1092px;
}
.book-image {
  float: left;
  margin-right: 20px;
  /* width: 63%;
  height: 92%; */
}

.book-details {
  overflow: hidden;
}

.book-details h2 {
  margin-top: 0;
}
.container-desc {
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 16vh;
  background-color: transparent;
}
.description {
  font-family: "Roboto", sans-serif;
  padding: 29px;
  line-height: 27px;
  max-width: 400px;
  padding: 20px;
  background-color: #fff;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}
.buy-button {
  display: inline-block;
  padding: 10px 20px;
  background-color: #007bff;
  color: #fff;
  text-decoration: none;
  border-radius: 5px;
  font-size: 16px;
  margin-top: 20px;
}
.book-container {
  margin: 0 auto;
  text-align: center;
}

.book-image {
  display: block;
  margin: 0 auto 20px;
}

.book-details {
  text-align: left;
}
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 40px;
  overflow: hidden;
  font-family: "Poppins", sans-serif;
  line-height: 35px;
}

.card {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 860px;
  flex-direction: row;
  border: none;
}

.shoeBackground {
  position: relative;
  width: 28%;
  height: 454px;
  box-shadow: -15px 0 35px rgba(0, 0, 0, 0.1), 0 -15px 35px rgba(0, 0, 0, 0.1),
    0 15px 35px rgba(0, 0, 0, 0.1);
  transition: 0.5s;
}

.gradients {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
}

.gradient {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  z-index: -2;
}

.first {
  z-index: 0;
  animation: 1s width ease;
}

@keyframes width {
  from {
    width: 0%;
  }
  to {
    width: 100%;
  }
}

.second {
  z-index: -1;
}

.logo {
  position: absolute;
  width: 100px;
  left: 20px;
  top: 20px;
}

.share {
  position: absolute;
  top: 15px;
  right: 15px;
  background-color: #fff;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  text-align: center;
  font-size: 1.3rem;
  text-decoration: none;
  color: var(--primary);
  transition: 0.5s;
}

.share:hover {
  transform: scale(1.1);
}

.share i {
  line-height: 50px;
}

.Title {
  position: absolute;
  top: 85px;
  left: 15px;
  font-size: 11rem;
  text-transform: uppercase;
  line-height: 0.9;
  color: #fff;
  opacity: 0.1;
}

.shoe {
  position: absolute;
  width: 140%;
  opacity: 0;
  bottom: 0;
  right: 0;
  transform: rotate(-20deg);
  transition: 0.5s;
}

.shoe.show {
  opacity: 1;
}

.info {
  width: 44%;
  height: 454px;
  border-radius: 0px 8px 8px 0px;
  background-color: #fff;
  z-index: 1;
  padding: 37px 30px;
  box-shadow: 15px 0 35px rgba(0, 0, 0, 0.1), 0 -15px 35px rgba(0, 0, 0, 0.1),
    0 15px 35px rgba(0, 0, 0, 0.1);
  line-height: 42px;
}

.shoeName {
  padding: 0 0 10px 0;
}

.shoeName div {
  display: flex;
  align-items: center;
}

.shoeName div .big {
  white-space: nowrap;
  margin-right: 10px;
  font-size: 1.7rem;
  color: #333;
  line-height: 1;
}

.shoeName div .new {
  background-color: var(--primary);
  text-transform: uppercase;
  color: #fff;
  padding: 3px 10px;
  border-radius: 5px;
  transition: 0.5s;
}

.shoeName .small {
  font-weight: 500;
  color: #444;
  margin-top: 3px;
  text-transform: capitalize;
}

.shoeName,
.description,
.color-container,
.genre-container {
  border-bottom: 1px solid #dadada;
}

.description {
  padding: 17px;
}

.title {
  color: #3a3a3a;
  font-weight: 600;
  font-size: 1.2rem;
  text-transform: uppercase;
}

.text {
  color: #555;
  font-size: 17px;
}

.color-container {
  padding: 10px 0;
}

.colors {
  padding: 8px 0;
  display: flex;
  align-items: center;
}

.genre-container {
  padding: 10px 0;
  margin-bottom: 10px;
}

.genres {
  padding: 8px 0;
  display: flex;
  align-items: center;
}

.genre {
  width: 100%;
  height: 42px;
  border-radius: 6px;
  background-color: #eee;
  margin: 0 10px;
  text-align: center;
  line-height: 41px;
  font-size: 1.1rem;
  font-weight: 500;
  cursor: pointer;
  transition: 0.3s;
}

.buy-price {
  padding-top: 5px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.price {
  color: #333;
  display: flex;
  align-items: flex-start;
}

.price h1 {
  font-size: 1.5rem;
  font-weight: 600;
  line-height: 1;
}

.price i {
  font-size: 1.4rem;
  margin-right: 1px;
}

.buy {
  background-color: var(--primary);
  text-decoration: none;
  color: #fff;
  text-transform: uppercase;
  letter-spacing: 1px;
  font-weight: 500;
  /* font-size: 0.7rem; */
  transition: 0.5s;
  height: 41px;
  font-size: 14px;
  padding: 0px 21px;
  border-radius: 8px;
}

.buy:hover {
  transform: scale(1.1);
}

.buy i {
  margin-right: 2px;
}

@media (max-width: 1070px) {
  .shoe {
    width: 135%;
  }
}

@media (max-width: 1000px) {
  .card {
    flex-direction: column;
    width: 100%;
    box-shadow: 0 0 35px 1px rgba(0, 0, 0, 0.2);
  }

  .card > div {
    width: 100%;
    box-shadow: none;
  }

  .shoe {
    width: 100%;
    transform: rotate(-5deg) translateY(-50%);
    top: 55%;
    right: 2%;
  }

  .Title {
    top: 20%;
    left: 5%;
  }
}

@media (max-width: 600px) {
  .share {
    width: 40px;
    height: 40px;
  }

  .share i {
    font-size: 1rem;
    line-height: 40px;
  }

  .logo {
    width: 70px;
  }
}

@media (max-width: 490px) {
  .Title {
    font-size: 7rem;
  }

  .shoeName div .big {
    font-size: 1.3rem;
  }

  .small {
    font-size: 1.5rem;
  }

  .new {
    padding: 2px 6px;
    font-size: 0.9rem;
  }
  h3.small {
    font-size: 0.9em;
  }
  .title {
    font-size: 0.9rem;
  }

  .text {
    font-size: 0.8rem;
  }

  .buy {
    padding: 0.5rem 0.8rem;
    font-size: 0.8rem;
  }

  .price h1 {
    font-size: 1.1rem;
  }

  .price i {
    font-size: 0.9rem;
  }

  .genre {
    width: 30px;
    height: 30px;
    margin: 0 8px;
    font-size: 0.9rem;
    line-height: 30px;
  }

  .color {
    margin: 0 6px;
    width: 0 20px;
    width: 20px;
    height: 20px;
    border-width: 4px;
  }

  .share {
    width: 35px;
    height: 35px;
    top: 10px;
    right: 10px;
  }

  .share i {
    font-size: 0.8rem;
    line-height: 35px;
  }

  .logo {
    width: 60px;
    top: 10px;
    left: 10px;
  }

  .info {
    padding: 20px;
  }
}

@media (max-width: 400px) {
  .buy i {
    display: none;
  }

  .container {
    padding: 20px;
  }
}
</style>
