(function(doc, win) {
    var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
        recalc = function() {
            var clientWidth = docEl.clientWidth;
            if(clientWidth>850){
              docEl.style.fontSize=103+"px"
              setTimeout(showPage, 1000/60);
              return false
            }
            if(!clientWidth) return;
            docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
            setTimeout(showPage, 1000/60);
        };
    if(!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);
function showPage() {
  $("body").css({
    'visibility': 'visible'
  })
}

