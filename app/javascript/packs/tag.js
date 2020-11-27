// pathを取得・変更するプロバティ
if (location.pathname.match("items/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("tagname");
    // なにかのKeyを話した時に発生するイベント
    inputElement.addEventListener("keyup", () => {
      const tagname = document.getElementById("tagname").value;
      // XMLHttpRequestとは、サーバーにHTTPリクエストを非同期で行える（つまりページの更新なしにサーバーからデータを受け取ったりできる）
      const XHR = new XMLHttpRequest();
      // 第一引数にHTTPメソッド、第二引数にURL、第三引数には非同期通信であることを示すためにtrue
      // Searchアクションへリクエストを送るように指定している。search/?tagname=${tagname}この表現はSearchにtagnameを送っているという表現になる。
      XHR.open("GET", `search/?tagname=${tagname}`, true);
      XHR.responseType = "json";
      XHR.send();
      // 読み込みが終了になり次第次の処理を実行する
      XHR.onload = () => {
        // tag名を打つ場所
        const searchResult = document.getElementById("tag-area");
        searchResult.innerHTML = "";
        if (XHR.response) {
          // responseを使うことでデータを受け取る
          const tagName = XHR.response.tagname;
          console.log(tagName)
          tagName.forEach((tag) => {
            // tagの候補が出てくる場所を作成
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.tagname;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("tagname").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    }); 
  });
};