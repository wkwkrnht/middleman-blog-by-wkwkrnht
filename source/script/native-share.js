function doNativeShare(){
    navigator
    .share({
        title: document.title,
        url: window.location.href
    })
    .then(console.log.bind(console))
    .catch(console.log.bind(console));
}