function doNativeShare(){
    var title = document.title;
    var text = document.getElementsByName('description').item(0).content;
    var url = window.location.href;
    navigator.share({title: title, text: text, url: url}).then(() => console.log('Successfully sent share'),error => console.error('Error sharing: ' + error));
}