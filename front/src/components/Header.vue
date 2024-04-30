<style scoped>
.dropdown__menu {
  position: absolute;
  top: 100%;
  left: 0;
  background-color: #ffffff;
  border: 1px solid #cccccc;
  border-radius: 4px;
  padding: 8px;
  z-index: 1000;
  margin-top: 9%;
  margin-left: 23%;
  line-height: 31px;
  width: 71%;
}

.avatar {
  position: relative;
  display: inline-block;
  cursor: pointer;
}

.avatar:hover .profile-info {
  display: block;
}

.profile-info {
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  display: none;
  background-color: #fff;
  padding: 10px;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}
.book-item {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.book-cover {
  width: 100px;
  height: auto;
  margin-right: 20px;
}

.book-details {
  flex-grow: 1;
}
</style>

<template>
  <div class="app-header">
    <header class="header">
      <div class="container">
        <div class="header__top">
          <div class="header__navigation">
            <div class="location">
              <div class="location__label">Ваш город:</div>
              <div class="lacation__city">Одесса</div>
            </div>
            <nav class="nav-top">
              <a href="#">Оплата и доставка</a>
              <a href="#">О компании</a>
              <a href="#">Поддержка</a>
            </nav>
          </div>
          <div class="user-menu">
            <template v-if="isLoggedIn">
              <div
                class="avatar"
                style="display: inline-block"
                @mouseover="showProfileInfo = true"
                @mouseleave="showProfileInfo = false"
              >
                <span>Добро пожаловать, {{ getUsername() }}</span>
                <button
                  @click="logout"
                  style="background: none; border: none; vertical-align: middle"
                >
                  <img
                    src="../icons/login.svg"
                    alt="Выход"
                    style="width: 14px; height: 14px"
                  /></button
                ><br /><br />
                <router-link to="../myHistory"
                  ><span>
                    <img
                      style="width: 17px; height: 17px; vertical-align: sub"
                      src="../icons/shopping-basket.svg"
                      alt=""
                    />
                    История покупок</span
                  ></router-link
                >
              </div>
            </template>
            <template v-else>
              <a href="#" data-toggle="modal" data-target="#loginModal"
                >Войти</a
              >
              <span>/</span>
              <a href="#" data-toggle="modal" data-target="#registerModal"
                >Зарегистрироваться</a
              >
            </template>
          </div>
        </div>
        <div class="header__bottom">
          <div class="logo">
            <img src="../icons/logo.svg" alt="Изображение логотипа" />
          </div>
          <div class="navigation">
            <div class="navigation">
              <div class="dropdown">
                <router-link to="/Main"
                  ><div class="navigation__btn" @click="toggleDropdown">
                    Главная
                  </div></router-link
                >
              </div>
            </div>
          </div>

          <div class="search__content">
            <input class="c-checkbox" type="checkbox" id="checkbox" />
            <div class="c-formContainer">
              <form class="c-form" @submit.prevent="searchBooks">
                <input
                  v-model="searchQuery"
                  @input="searchBooks"
                  class="c-form__input"
                  placeholder="Поиск книги..."
                  type="text"
                  required
                />

                <label class="c-form__buttonLabel" for="checkbox">
                  <button class="c-form__button" type="button">
                    <img
                      style="width: 18px; height: 18px"
                      src="../icons/search.svg"
                      alt=""
                    />
                  </button>
                </label>
                <label class="c-form__toggle" for="checkbox" data-title="">
                  <img
                    style="width: 21px; height: 21px"
                    src="../icons/search.svg"
                    alt=""
                  />
                </label>
              </form>
              <div v-show="isVisible" id="searchResults">
                <ul>
                  <li v-for="result in searchResults" :key="result.id">
                    <router-link target="_blank" :to="'/book/' + result.id">
                      <div class="book-item">
                        <img
                          :src="require('../uploads/' + result.coverImage)"
                          alt=""
                        />
                        <div class="book-details">
                          <h3>{{ result.title }}</h3>
                          <p>{{ result.price }} €</p>
                        </div>
                      </div>
                    </router-link>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <div class="header__nav-purchases">
            <div v-if="data.levelAccess > 1" class="settings">
              <router-link to="../AdminPanel"
                ><button class="settings__btn">
                  <span class="material-symbols-outlined"> settings </span>
                </button></router-link
              >
            </div>
          </div>
        </div>
      </div>
    </header>
  </div>

  <!-- Login Modal -->
  <div
    class="modal fade"
    id="loginModal"
    tabindex="-1"
    role="dialog"
    aria-labelledby="loginModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="loginModalLabel">Login</h5>
          <button
            type="button"
            class="close"
            data-dismiss="modal"
            aria-label="Close"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <!-- Login Form -->
          <form @submit.prevent="login">
            <div class="form-group">
              <label for="username">Username</label><br /><br />
              <input
                type="text"
                class="form-control"
                id="username"
                v-model="username"
              />
            </div>
            <div class="form-group">
              <label for="password">Password</label><br /><br />
              <input
                type="password"
                class="form-control"
                id="password"
                v-model="password"
              />
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
          </form>
        </div>
      </div>
    </div>
    <div>
      <!-- Здесь ваш шаблон -->
      <!-- Уведомление -->
      <div
        v-if="successMessage"
        :class="{
          alert: true,
          'alert-success': isSuccess,
          'alert-danger': !isSuccess,
        }"
        role="alert"
      >
        {{ successMessage }}
      </div>
    </div>
  </div>
  <!-- Register Modal -->
  <div
    class="modal fade"
    id="registerModal"
    tabindex="-1"
    role="dialog"
    aria-labelledby="registerModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="registerModalLabel">Register</h5>
          <button
            type="button"
            class="close"
            data-dismiss="modal"
            aria-label="Close"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <!-- Register Form -->
          <form @submit.prevent="registerUser">
            <div class="form-group">
              <label for="newUsername">Username</label><br /><br />
              <input
                type="text"
                class="form-control"
                id="newUsername"
                v-model="username"
              />
            </div>

            <div class="form-group">
              <label for="newEmail">Email</label><br /><br />
              <input
                type="email"
                class="form-control"
                id="newEmail"
                v-model="email"
              />
            </div>
            <div class="form-group">
              <label for="newPassword">Password</label><br /><br />
              <input
                type="password"
                class="form-control"
                id="newPassword"
                v-model="password"
              />
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
          </form>
        </div>
      </div>
    </div>
    <div>
      <div
        v-if="successMessage"
        :class="{
          alert: true,
          'alert-success': isSuccess,
          'alert-danger': !isSuccess,
        }"
        role="alert"
      >
        {{ successMessage }}
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "AppHeader",
  data() {
    return {
      isOpen: false,
      username: "",
      email: "",
      password: "",
      registrationMessage: "",
      successMessage: "",
      data: [],
      searchQuery: "",
      searchResults: [],
      isVisible: false,
    };
  },
  computed: {
    isLoggedIn() {
      return localStorage.getItem("username") !== null;
    },
  },
  methods: {
    async searchBooks() {
      if (this.searchQuery.trim() !== "") {
        console.log(this.searchQuery);
        try {
          const response = await axios.post(
            "http://pject/backend/search.php",
            { query: this.searchQuery },
            {
              headers: {
                "Content-Type": "application/json",
              },
            }
          );
          this.searchResults = response.data;
          if (!this.searchResults || this.searchResults.length === 0) {
            this.isVisible = false;
          } else {
            this.isVisible = true;
          }
        } catch (error) {
          console.error("Ошибка при выполнении запроса:", error);
        }
      } else {
        this.searchResults = [];
        this.isVisible = false;
      }
    },
    getUsername() {
      return localStorage.getItem("username");
    },
    getID() {
      return localStorage.getItem(this.data.UserID);
    },
    logout() {
      localStorage.removeItem("username");
      window.location.reload();
    },
    toggleDropdown() {
      this.isOpen = !this.isOpen;
    },
    registerUser() {
      const formData = new FormData();
      formData.append("username", this.username);
      formData.append("email", this.email);
      formData.append("password", this.password);

      axios
        .post("http://pject/backend/register.php", formData, {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          console.log(response.data);
          if (response.data.isSuccess) {
            this.registrationMessage = response.data.message;
            this.showSuccessMessage(response.data.message);
            this.isSuccess = true;
          } else {
            this.showSuccessMessage(response.data.message);
            this.isSuccess = false;
            console.log(response.data.message);
          }
        })
        .catch((error) => {
          console.error("Error registering user:", error);
          this.showSuccessMessage(error.message);
          this.isSuccess = false;
        });
    },

    login() {
      const formData = new FormData();
      formData.append("username", this.username);
      formData.append("password", this.password);

      axios
        .post("http://pject/backend/login.php", formData, {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          console.log(response.data);
          this.registrationMessage = response.data;
          this.showSuccessMessage("User logged in successfully!");

          localStorage.setItem("username", this.username);

          this.isSuccess = true;
          setTimeout(() => {
            window.location.reload();
          }, 2000);
        })
        .catch((error) => {
          console.error("Error login user:", error);
          this.showSuccessMessage("Wrong password or Login!");
          this.isSuccess = false;
        });
    },
    showSuccessMessage(message) {
      this.successMessage = message;
      setTimeout(() => {
        this.successMessage = "";
      }, 2000);
    },
    async fetchInfo(username) {
      try {
        const response = await fetch("http://pject/backend/getImportant.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ username: username }),
        });

        if (!response.ok) {
          throw new Error("Ошибка HTTP: " + response.status);
        }

        const responseData = await response.text();
        const data = JSON.parse(responseData);
        console.log(data);

        this.data = data;
      } catch (error) {
        console.error("Ошибка при получении данных:", error);
      }
    },
  },
  mounted() {
    if (this.isLoggedIn) {
      this.fetchInfo(this.getUsername());
    }
  },
};
</script>

<style scoped>
.alert {
  position: fixed;
  top: 10px;
  right: 10px;
  font-family: "Montserrat", sans-serif;
}
</style>
