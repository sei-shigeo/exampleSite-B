// DOMContentLoadedイベントをリッスンして、ページが完全に読み込まれたときに実行
document.addEventListener("DOMContentLoaded", function() {
    updateActiveLink(); // 初期ロード時にリンクのスタイルを設定

    // HTMXのカスタムイベント 'htmx:afterOnLoad' をリッスン
    // HTMXが新しいコンテンツをロードした後に発生する
    document.body.addEventListener('htmx:afterOnLoad', function(evt) {
        updateActiveLink(); // コンテンツが更新された後にリンクのスタイルを更新
    });
});

// 現在のページに対応するリンクに 'active' クラスを追加する関数
function updateActiveLink() {
    // 現在のページのURLのパス部分を取得
    const currentLocation = window.location.pathname;
    // クラス名が 'nav-link' のすべてのリンク要素を取得
    const navLinks = document.querySelectorAll('.nav-link');

    // 各リンク要素に対して反復処理を行う
    navLinks.forEach(link => {
        // リンクのURLオブジェクトを作成し、そのパス部分を取得
        const linkPath = new URL(link.href).pathname;
        // 現在のページのパスとリンクのパスが正確に一致するかを確認
        if (linkPath === currentLocation) {
            link.classList.add('active'); // 一致する場合、リンクに 'active' クラスを追加
        } else {
            link.classList.remove('active'); // 一致しない場合、リンクから 'active' クラスを削除
        }
    });
}