function doNativeShare(){
    var title = document.title;
    var txt = document.getElementsByName('description').item(0).content;
    var url = window.location.href;
    navigator.share({title: title, text: txt, url: url}).then(console.log.bind(console)).catch(console.log.bind(console));
}