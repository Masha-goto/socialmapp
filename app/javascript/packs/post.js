import $ from "jquery";
import axios from "axios";
import { csrfToken } from "@rails/ujs";

axios.defaults.headers.common["X-CSRF-Token"] = csrfToken();

const handleLikedDisplay = (hasLiked) => {
  if (hasLiked) {
    $(".active-like").removeClass("hidden");
  } else {
    $(".inactive-like").removeClass("hidden");
  }
};

document.addEventListener("turbolinks:load", () => {
  const dataset = $("#post-show").data();
	if (!dataset){ return false; }
  const postId = dataset.postId;

  axios.get(`/posts/${postId}/like`).then((response) => {
    const hasLiked = response.data.hasLiked;
    handleLikedDisplay(hasLiked);
  });

  $(".inactive-like").on("click", () => {
    axios.post(`/posts/${postId}/like`)
			.then((res) => {
				if (res.data.status === 'ok') {
					$('.active-like').removeClass('hidden')
					$('.inactive-like').addClass('hidden')
				}
			})
			.catch((e) => {
				window.alert(`Error`)
				console.log(e)
			})
  });

  $('.active-like').on('click', () => {
    axios.delete(`/posts/${postId}/like`)
			.then((res) => {
				if (res.data.status === 'ok') {
					$('.active-like').addClass('hidden')
					$('.inactive-like').removeClass('hidden')
				}
			})
			.catch((e) => {
				window.alert(`Error`)
				console.log(e)
			})
  });
});
