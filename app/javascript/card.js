// JSを使う際はapplication.jsに記述しなければならない
// JSはまず、使う値を指定してあげる文を書いて、その後に使えるようにしてあげなければならない
const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
// ここで送信を止める。
    e.preventDefault();

// ８行目でどのホームか取得している。（目印をつける）
    const formResult = document.getElementById("charge-form");
// 目印をつける。その後に操作を行う。（rubyで言うnew）
    const formData = new FormData(formResult);
// getmethod内にはname属性をいれてあげる。
    const card = {
      number: formData.get("item_destination[number]"),
      cvc: formData.get("item_destination[cvc]"),
      exp_month: formData.get("item_destination[exp_month]"),
// pay.jpは西暦四桁で入力しないとだめなので、この記述は必須になる。
      exp_year:`20${formData.get("item_destination[exp_year]")}`
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
// ストロングパラメーターで使う、キーバリューを示している。キーはname='tokenにあたる。
// formwithの形にして上げている、理由は今の２３行目の形だとJSの形となってしまっているため、パラメーターの中に含ませて送ることができない。
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        //insertAdjacentHTML("beforeend", tokenObj);はまず、第一引数として入れる場所を指定。第二引数で場所を指定している。
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    }
  )});
};

window.addEventListener("load", pay);