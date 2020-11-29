import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    const html = `
    <div class="comments">
      <li>
        ${data.content.comment}
      </li>
    </div>
    `
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_comment');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value=''
    const submit = document.getElementById("comment-btn");
    console.log(submit);
    submit.disabled = false;
    submit.reset()
  }
});


{/* <p>${data.user.nickname}</p> */}
