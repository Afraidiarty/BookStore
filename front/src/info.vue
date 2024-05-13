<style scoped>
.row {
  margin-top: 30px;
}

.card {
  margin-top: 20px;
}

.CartCont {
  margin-top: 30px;
}

.card-title {
  display: flex;
  justify-content: center;
  font-family: "Roboto", sans-serif;
}
img.card-img-top {
  height: 335px;
}
.card-img-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}

.card-img-overlay .text-center {
  position: relative;
  z-index: 1;
  font-family: "Roboto", sans-serif;
}

.card-img-overlay .text-center h1,
.card-img-overlay .text-center p {
  color: white;
  font-family: "Roboto", sans-serif;
}

.col-lg-4 {
  display: flex;
  font-family: "Roboto", sans-serif;

  justify-content: center;
}

.ActorCart {
  display: flex;
  flex-wrap: wrap;
  flex-direction: column;
}

.BlockActor1 {
  display: flex;
  flex-direction: column;
  width: 100%;
  font-family: "Roboto", sans-serif;
}

.ActorCartInner {
  font-family: "Roboto", sans-serif;

  display: flex;
}

.quote {
  background-color: transparent;
  border-radius: 10px;
  padding: 20px;
  font-family: "Roboto", sans-serif;
}

.quote p {
  font-size: 18px;
  font-style: italic;
  color: #333;
  margin: 0;
  font-family: "Roboto", sans-serif;
}

.quote:before {
  content: "“";
  font-size: 2em;
  color: #999;
  position: relative;
  top: -20px;
  left: -10px;
}
.quote:after {
  content: "”";
  font-size: 2em;
  color: #999;
  position: relative;
  bottom: -20px;
  float: right;
}

.card-header1 {
  display: flex;
  justify-content: flex-end;
  font-family: "Roboto", sans-serif;
}

.card-text img {
  -o-object-fit: contain;
  object-fit: contain;
  height: 21px;
  width: 21px;
  position: relative;
  top: 7px;
}

.card-text a {
  font-family: "Roboto", sans-serif;

  text-decoration: none;
  color: #333;
  position: relative;
  transition: color 0.3s ease;
}

.card-text a:before {
  font-family: "Roboto", sans-serif;

  content: "";
  position: absolute;
  width: 100%;
  height: 2px;
  bottom: -2px;
  left: 0;
  background-color: #333;
  visibility: hidden;
  transform: scaleX(0);
  transition: all 0.3s ease-in-out;
}

.card-text a:hover:before {
  visibility: visible;
  transform: scaleX(0.4);
}

.card-text a:hover {
  color: #333;
}
p.card-text {
  line-height: 25px;
}
</style>

<template>
  <AppHeader />

  <div class="container-fluid GlobalCont">
    <div class="container CartCont">
      <div class="row">
        <div class="col-lg-4 .col-sm-6">
          <div class="card" style="width: 18rem">
            <img
              class="card-img-top"
              src="./img/Route-map-feature.jpg"
              alt="Card image cap"
            />
            <div class="card-body">
              <div class="card-header">{{ $t("located_company") }}</div>
              <div class="card-body">
                <p class="card-text">
                  {{ $t("located_desc") }}
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="col-lg-4 .col-sm-6">
          <div class="card" style="width: 18rem">
            <img
              class="card-img-top"
              src="./img/a-wall-of-books-with-the-word-library-on-it_900958-25811.avif"
              alt="Card image cap"
            />
            <div class="card-body">
              <div class="card-header">{{ $t("Rare_Auth") }}</div>
              <div class="card-body">
                <p class="card-text">
                  {{ $t("Auth_desc") }}
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="col-lg-4 .col-sm-6">
          <div class="card" style="width: 18rem">
            <img
              class="card-img-top"
              src="./img/f57904a-----.jpg"
              alt="Card image cap"
            />
            <div class="card-body">
              <div class="card-header">{{ $t("deliver_s") }}</div>
              <div class="card-body">
                <p class="card-text">
                  {{ $t("deliver_desc") }}
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="col-lg-4 .col-sm-6">
          <div class="card bg-light mb-3" style="max-width: 18rem">
            <div class="card-header">
              {{ $t("card__title_1") }}
            </div>
            <div class="card-body">
              <p class="card-text">
                {{ $t("card__desc_1") }}
              </p>
            </div>
          </div>
        </div>

        <div class="col-lg-4 .col-sm-6">
          <div class="card bg-light mb-3" style="max-width: 18rem">
            <div class="card-header">{{ $t("card__title_2") }}</div>
            <div class="card-body">
              <p class="card-text">
                {{ $t("card__desc_2") }}
              </p>
            </div>
          </div>
        </div>

        <div class="col-lg-4 .col-sm-6">
          <div class="card bg-light mb-3" style="max-width: 18rem">
            <div class="card-header">{{ $t("card__title_3") }}</div>
            <div class="card-body">
              <h5 class="card-title">{{ $t("card__title_3") }}</h5>
              <p class="card-text">
                <a href="">
                  <img src="./img/email.png" alt="" />
                  company2020@gmail.com</a
                >
              </p>

              <p class="card-text">
                <a href=""
                  ><img src="./img/instagram.png" alt="" /> Instagram</a
                >
              </p>
              <p class="card-text">
                <a href=""><img src="./img/telegram.png" alt="" /> Telegram</a>
              </p>

              <p class="card-text">
                <a href=""><img src="./img/facebook.png" alt="" /> Facebook</a>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="container">
    <div class="card bg-dark text-white">
      <img
        class="card-img"
        src="./img/4k-forest-7sfd6znw2ry6hnlt.jpg"
        alt="Card image"
      />
      <div
        class="card-img-overlay d-flex justify-content-center align-items-center"
      >
        <div class="text-center">
          <h1 class="card-title">{{ $t("Story_") }}</h1>
          <p class="card-text">
            <span>&#10023;</span>{{ $t("legend") }}<span>&#10023;</span>
          </p>
        </div>
      </div>
    </div>
  </div>

  <div class="container ActorCart">
    <div class="card" style="flex-direction: row">
      <img
        class="card-img-top"
        style="width: 18rem; object-fit: cover"
        src="./img/images.jpeg"
        alt="Card image cap"
      />
      <div class="card-body">
        <div class="card-header">Natali Portman</div>
        <p class="card-text">
          <span class="quote">
            <p>"{{ $t("cetat") }}"</p>
          </span>
        </p>
      </div>
    </div>

    <div class="card" style="flex-direction: row-reverse">
      <img
        class="card-img-top"
        style="
          width: 18rem;
          object-fit: cover;
          object-fit: contain;
          height: 18rem;
        "
        src="./img/kurt-russell.avif"
        alt="Card image cap"
      />
      <div class="card-body">
        <div class="card-header card-header1">Kurt Russell</div>
        <p class="card-text">
          <span class="quote">
            <p>"{{ $t("cetat") }}"</p>
          </span>
        </p>
      </div>
    </div>

    <div class="card" style="flex-direction: row">
      <img
        class="card-img-top"
        style="
          width: 18rem;
          object-fit: cover;
          object-fit: contain;
          height: 18rem;
        "
        src="./img/MV5BMTQzMjkwNTQ2OF5BMl5BanBnXkFtZTgwNTQ4MTQ4MTE@._V1_.jpg"
        alt="Card image cap"
      />
      <div class="card-body">
        <div class="card-header">Natali Portman</div>
        <p class="card-text">
          <span class="quote">
            <p>"{{ $t("cetat") }}"</p>
          </span>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import AppHeader from "./components/Header.vue";

export default {
  name: "InfoPage",
  components: {
    AppHeader,
  },
};
</script>
