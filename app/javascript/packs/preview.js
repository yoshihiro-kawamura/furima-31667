// これを実行してあげないと、ページを限定してあげられないからよくない。
if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const ImageList = document.getElementById('image-list');

    // 関数なので呼び出されるまでは動かない。
    const createImageHTML = (blob) => {
      // 画像を正しい形にしてあげている。それを（blob）に代入
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      
      // 画像を生成してあげている
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);

      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };


    document.getElementById('item-image').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する
      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob)

    });
  });    
}

