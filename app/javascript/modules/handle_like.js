import $ from "jquery";
import axios from "modules/axios";

const listenInactiveLikeEvent = (postId) => {
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
}


const listenActiveLikeEvent = (postId) => {
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
}

export {
  listenInactiveLikeEvent,
  listenActiveLikeEvent
}