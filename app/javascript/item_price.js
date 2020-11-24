// JSを使う際はapplication.jsに記述しなければならない
window.addEventListener('load', () => {
  //①まずJSを動かす記述（Ajaxappに書いてある↑
  // ②価格入力欄のidを手がかりに変数にconstで代入する
  const price = document.getElementById("item-price")
  const tax = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")
  //③価格のフォームに入力したあとにイベントを発火
  price.addEventListener("input", () => {
  //④手数料、利益計算
  const tax_price = Math.floor(price.value * 0.1) 
  const profit_price = Math.floor(price.value - tax_price) 
    //⑤手数料と利益を貼り付ける
  tax.innerHTML = tax_price
  profit.innerHTML = profit_price
})
});