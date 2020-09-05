(function (){
    // Preloader
    let preloader = _e('#preloader');
    preloader.classList.add('hide');
    
    // // Socket io - Make Connection
    // let socket = io.connect('http://localhost:3000');
    
    function _e(elem){
        return document.querySelector(elem);
    }
})()