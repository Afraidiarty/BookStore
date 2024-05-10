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
            <li class="nav-item active">
              <a class="nav-link" href="#">Books</a>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="AdminOrder"
                >List order</router-link
              >
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="AdminBuyList"
                >List user buy history</router-link
              >
            </li>
          </ul>
        </div>
      </nav>
    </div>
    <div class="container mt-5">
      <h1 class="mb-4">Book management</h1>

      <!-- Форма для добавления книги -->
      <div class="card mb-4">
        <div class="card-header">Add book</div>
        <div class="card-body">
          <form @submit.prevent="addBooks">
            <div class="form-group">
              <label for="title">Title book</label><br /><br />
              <input
                type="text"
                class="form-control"
                id="title"
                v-model="Title"
                placeholder="Enter the title of the book"
              />
            </div>
            <div class="form-group">
              <label for="author">Author</label><br /><br />
              <input
                type="text"
                class="form-control"
                id="author"
                v-model="author"
                placeholder="Enter the author of the book"
              />
            </div>
            <div class="form-group">
              <label for="genre">Publisher</label><br /><br />
              <input
                type="text"
                class="form-control"
                id="izdatel"
                v-model="izdatel"
                placeholder="Enter the publisher of the book"
              />
            </div>
            <div class="form-group">
              <label for="genre">Жанр</label><br /><br />
              <select class="form-control" id="genre" v-model="genre">
                <option value="фантастика">Фантастика</option>
                <option value="роман">Роман</option>
                <option value="детектив">Детектив</option>
                <option value="фэнтези">Фэнтези</option>
                <option value="приключения">Приключения</option>
                <option value="ужасы">Ужасы</option>
                <option value="исторический">Исторический</option>
                <option value="драма">Драма</option>
                <option value="комедия">Комедия</option>
                <option value="мистика">Мистика</option>
                <option value="триллер">Триллер</option>
                <option value="боевик">Боевик</option>
                <option value="фанфик">Фанфик</option>

                <!-- Добавить дополнительные варианты жанров -->
              </select>
            </div>

            <div class="form-group">
              <label for="genre">Description</label><br /><br />
              <textarea
                v-model="desc"
                class="form-control"
                id="description"
                rows="5"
                cols="50"
                style="min-height: 100px; max-height: 300px"
              ></textarea>
            </div>
            <div class="form-group">
              <label for="genre">Number of pages</label><br /><br />
              <input
                v-model="PageCount"
                type="number"
                class="form-control"
                id="PageCount"
              />
            </div>
            <div class="form-group">
              <label for="genre">Price</label><br /><br />
              <input
                v-model="price"
                type="number"
                class="form-control"
                id="price"
              />
            </div>
            <div class="form-group">
              <label for="img">Image</label><br /><br />
              <input
                type="file"
                class="form-control"
                id="img"
                accept="image/jpeg, image/png"
                @change="handleFileUpload"
              />
            </div>

            <button type="submit" class="btn btn-primary">ADD</button>
          </form>
        </div>
      </div>

      <!-- Таблица с книгами -->
      <div class="card">
        <div class="card-header">List books</div>
        <div class="card-body">
          <table class="table">
            <thead>
              <tr>
                <th>#</th>
                <th>Title</th>
                <th>Author</th>
                <th>Genre</th>
                <th>Price</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(book, index) in books" :key="index">
                <td>{{ index + 1 }}</td>
                <td>{{ book.title }}</td>
                <td>{{ book.author }}</td>
                <td>{{ book.genre }}</td>
                <td>{{ book.price }}</td>
                <td>
                  <button
                    class="btn btn-sm btn-primary"
                    @click="openEditModal(book.id)"
                  >
                    Edit books
                  </button>
                  <button
                    class="btn btn-sm btn-danger"
                    @click="deleteBook(book.id)"
                  >
                    Delete books
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Модальное окно для редактирования -->
  <div
    id="editBookModal"
    class="modal fade"
    tabindex="-1"
    role="dialog"
    aria-labelledby="editBookModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-lg" role="document">
      <!-- modal-lg для увеличения размера модального окна -->
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editBookModalLabel">
            Редактировать книгу
          </h5>
          <button
            type="button"
            class="close"
            data-dismiss="modal"
            aria-label="Close"
            @click="closeEditModal"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form @submit.prevent="editBook">
            <div class="row">
              <!-- Левая колонка -->
              <div class="col-md-6">
                <div class="form-group">
                  <label for="title">Название книги</label>
                  <input
                    type="text"
                    class="form-control"
                    id="title"
                    v-model="Title"
                    placeholder="Введите название книги"
                  />
                </div>
                <div class="form-group">
                  <label for="author">Автор</label>
                  <input
                    type="text"
                    class="form-control"
                    id="author"
                    v-model="author"
                    placeholder="Введите автора книги"
                  />
                </div>
                <div class="form-group">
                  <label for="izdatel">Издательство</label>
                  <input
                    type="text"
                    class="form-control"
                    id="izdatel"
                    v-model="izdatel"
                    placeholder="Введите издательство книги"
                  />
                </div>
                <div class="form-group">
                  <label for="description">Описание</label>
                  <textarea
                    v-model="desc"
                    class="form-control"
                    id="description"
                    rows="5"
                    cols="50"
                    style="min-height: 100px; max-height: 300px"
                  ></textarea>
                </div>
              </div>
              <!-- Правая колонка -->
              <div class="col-md-6">
                <div class="form-group">
                  <label for="genre">Жанр</label>
                  <select class="form-control" id="genre" v-model="genre">
                    <option value="фантастика">Фантастика</option>
                    <option value="роман">Роман</option>
                    <option value="детектив">Детектив</option>
                    <option value="фэнтези">Фэнтези</option>
                    <option value="приключения">Приключения</option>
                    <option value="ужасы">Ужасы</option>
                    <option value="исторический">Исторический</option>
                    <option value="драма">Драма</option>
                    <option value="комедия">Комедия</option>
                    <option value="мистика">Мистика</option>
                    <option value="триллер">Триллер</option>
                    <option value="боевик">Боевик</option>
                    <option value="фанфик">Фанфик</option>
                  </select>
                </div>
                <div class="form-group">
                  <label for="PageCount">Кол-во страниц</label>
                  <input
                    v-model="PageCount"
                    type="number"
                    class="form-control"
                    id="PageCount"
                  />
                </div>
                <div class="form-group">
                  <label for="price">Цена</label>
                  <input
                    v-model="price"
                    type="number"
                    class="form-control"
                    id="price"
                  />
                </div>
              </div>
            </div>
            <button type="submit" class="btn btn-primary">Сохранить</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
//import AppHeader from "./components/Header.vue";
import { fetchInfo } from "./api.js";

export default {
  components: {},

  data() {
    return {
      Title: "",
      Author: "",
      Publisher: "",
      genre: "фантастика",
      Description: "",
      price: "",
      file: null,
      books: [],
      additionalInfo: null,
      selectedBook: null,
    };
  },
  async mounted() {
    this.fetchBooks();
    await this.fetchAdditionalInfo();
    if (this.additionalInfo && this.additionalInfo.levelAccess < 2) {
      this.$router.push("/Main");
    }
  },

  methods: {
    deleteBook(bookID) {
      axios
        .post(
          "http://pject/backend/deleteBook.php",
          {
            bookID: bookID,
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
    editBook() {
      console.log(this.selectedBook);

      const requestData = {
        title: this.Title,
        author: this.author,
        izdatel: this.izdatel,
        genre: this.genre,
        desc: this.desc,
        PageCount: this.PageCount,
        price: this.price,
        id_book: this.selectedBook,
      };

      axios
        .post("http://pject/backend/editBooks.php", requestData, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((response) => {
          console.log(response.data);
          window.location.reload();
        })
        .catch((error) => {
          console.error(error);
        });
    },
    openEditModal(book) {
      this.selectedBook = book;
      const modal = document.getElementById("editBookModal");
      modal.classList.add("show");
      modal.style.display = "block";
      modal.style.backgroundColor = "rgba(0, 0, 0, 0.5)";
    },
    closeEditModal() {
      const modal = document.getElementById("editBookModal");
      modal.classList.remove("show");
      modal.style.display = "none";
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
    getUsername() {
      return localStorage.getItem("username");
    },
    addBooks() {
      const formData = new FormData();
      formData.append("title", this.Title);
      formData.append("author", this.author);
      formData.append("izdatel", this.izdatel);
      formData.append("genre", this.genre);
      formData.append("desc", this.desc);
      formData.append("PageCount", this.PageCount);
      formData.append("price", this.price);
      if (this.file) {
        formData.append("file", this.file);
      }

      console.log(this.file);

      axios
        .post("http://pject/backend/addBooks.php", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((response) => {
          console.log(response.data);
          window.location.reload();
        })
        .catch((error) => {
          console.error(error);
        });
    },
    handleFileUpload(event) {
      this.file = event.target.files[0];
    },
    fetchBooks() {
      axios
        .get("http://pject/backend/getBooks.php")
        .then((response) => {
          this.books = response.data;
          console.log(this.books);
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
/* Стили для модального окна */
.modal-content {
  border-radius: 10px;
}

.modal-header {
  background-color: #007bff;
  color: #fff;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
}

.modal-title {
  margin-bottom: 0;
}

.modal-body {
  padding: 20px;
}

.modal-footer {
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
}

/* Стили для кнопок */
.btn-primary {
  background-color: #007bff;
  border-color: #007bff;
}

.btn-primary:hover {
  background-color: #0056b3;
  border-color: #0056b3;
}

.btn-primary:focus,
.btn-primary.focus {
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.5);
}
</style>
