// これを実行してあげないと、ページを限定してあげられないからよくない。
if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  // DOMの読み込み完了時に発火
  document.addEventListener('DOMContentLoaded', function(){

    // 関数なので呼び出されるまでは動かない。
    const createImageHTML = (blob) => {
      // 画像を正しい形にしてあげている。それを（blob）に代入
      // 画像を表示するためのdiv要素を生成
      
      // 画像を生成してあげている
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', "image");
      const imageList = document.getElementById("image-list")
      // 生成したHTMLの要素をブラウザに表示させる
      imageList.appendChild(blobImage);
    };

    document.getElementById('item-image').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する
      const imageContent = document.querySelector('.image');
      if (imageContent){
        imageContent.remove();
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob)

    });
  });    
}

