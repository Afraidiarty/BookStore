<template>
  <div class="modalOr">
    <div class="modal-contentOr">
      <span class="close" @click="closeModal">&times;</span>
      <h2 style="text-align: center">Оформление заказа</h2>
      <form @submit.prevent="addOrder">
        <div class="form-group">
          <label for="FIO">ФИО:</label>
          <input type="text" id="FIO" v-model="formData.FIO" required />
        </div>
        <div class="form-group">
          <label for="email">Email:</label>
          <input type="email" id="email" v-model="formData.email" required />
        </div>
        <div class="form-group">
          <label for="phone">Номер телефона:</label>
          <input type="tel" id="phone" v-model="formData.phone" required />
        </div>
        <button type="submit">Заказать</button>
      </form>
    </div>
  </div>
</template>

<script>
import { getUsername } from "@/storage";
import axios from "axios";
export default {
  name: "PurchaseModal",
  props: {
    selectedBookId: Number,
  },
  data() {
    return {
      formData: {
        FIO: "",
        email: "",
        phone: "",
        book_id: null,
        MyName: null,
      },
    };
  },
  methods: {
    closeModal() {
      console.log(this.selectedBookId);
      this.$emit("close");
    },
    addOrder() {
      this.formData.book_id = this.selectedBookId;
      this.formData.MyName = getUsername();
      console.log("Отправка заказа:", this.formData);
      axios
        .post("http://pject/backend/addOrder.php", this.formData, {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          console.log("Успешно отправлено на сервер:", response.data);
          window.location.reload();
        })
        .catch((error) => {
          console.error("Ошибка при отправке на сервер:", error);
        });
    },
  },
};
</script>

<style scoped>
.modalOr {
  font-family: "Roboto", sans-serif;
  border-radius: 20px;
  display: block;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal-contentOr {
  background-color: #fefefe;
  margin: 10% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 50%;
  border-radius: 20px;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

form {
  display: flex;
  flex-direction: column;
}

.form-group {
  margin-bottom: 1rem;
}

label {
  font-weight: bold;
}

input[type="text"],
input[type="email"],
input[type="tel"],
button {
  padding: 0.5rem;
  margin-top: 0.5rem;
  font-size: 1rem;
}
button {
  padding: 0.5rem 1rem;
  margin-top: 0.5rem;
  font-size: 1rem;
  border: none;
  border-radius: 4px;
  background-color: #007bff;
  color: #fff;
  cursor: pointer;
  width: 50%;
  margin: 0px auto;
  transition: background-color 0.3s ease;
}
</style>
