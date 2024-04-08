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

const handleCommentForm = () => {
	$(".show_comment_form, .post_group").on("click", () => {
		$(".show_comment_form").addClass("hidden");
		$(".comment_text_area_after").removeClass("hidden");
	});
}

const appendNewComment = (comment) => {
	$('.comments_container').append(
		`<div class="post_comment"><p>${comment.content}</p></div>`
	)
}

document.addEventListener("turbolinks:load", () => {
  const dataset = $("#post-show").data();
	if (!dataset){ return false; }
  const postId = dataset.postId;


	axios.get(`/posts/${postId}/comments`)
	.then((response) => {
		const comments = response.data
		comments.forEach((comment) => {
			appendNewComment(comment)
		})
	})

	handleCommentForm()

	$('.add-comment-button').on('click', () => {
    const content = $('#comment_box').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/posts/${postId}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
					appendNewComment(comment)
          $('#comment_box').val('')
        })
    }
  })

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
